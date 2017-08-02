#!/opt/python/bin/python
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 07 22:26:22 2017

@author: CS401:Nannapas Banluesombatkul
"""


import cgitb
cgitb.enable()

from Database import Database
import string
import random
import hashlib
import smtplib
from datetime import datetime, timedelta
from email.MIMEText import MIMEText

HOSTNAME = "LOCALHOST"
RESET_PASSWORD_URL = "http://"+HOSTNAME+"/cloud-scheduler-gui/UI/dist/#/resetPWD"
SOURCE_EMAIL = 'root@'+HOSTNAME
GEN_ID_LENGTH = 16
RESET_PASSWORD_TIME = 30 #minutes

import requests
NOTIFICATION_URL = "http://"+HOSTNAME+"/cloud-scheduler-gui/scripts/loginNotification.py"

class User: 
    __userId = None
    __username = None
    __firstname = None
    __lastName = None
    __emailAddress = None
    __phoneNumber = None
    __status = None
    __timezone = None
    __organization = None
    __position = None
    __language = None
    
    
    def __init__(self,data=None,sessionId=None,getAnotherUserData=False,genId=None): 
        if genId == None:
            if data != None:
                self.__sessionId = None
                self.__userId = data[0]
                self.__username = data[1] 
                self.__password = data[2]
                self.__firstname = data[3]
                self.__lastName = data[4]
                self.__emailAddress = data[5]
                self.__phoneNumber = data[6]
                self.__status = data[7]
                self.__organization = data[8]
                self.__position = data[9]
                self.__language = data[10]
                self.__timezone = data[11]
                self.__publicKey = data[12]
                    
            self.__db = Database()
            if self.__db.connect():
                
                if sessionId == None :
                    if getAnotherUserData == False:
                        #SIGN IN OR user request to forget_password
                        self.__setSessionToken()
                    else:
                        #ADMIN REQUEST USER'S DATA 
                        sql = 'SELECT `session_id` FROM `session` WHERE `user_id` = "'+str(self.__userId)+'";'
                        self.__db.execute(sql)
                        sessionId = self.__db.getCursor().fetchone()
                        if sessionId != None:
                            self.__sessionId = sessionId[0]
                else:
                    
                    if sessionId != None:
                        #SET TIME ZONE AND SIGN OUT
                        self.__sessionId = sessionId
                        sql = 'SELECT `user_id` FROM `session` WHERE `session_id` = "'+str(self.__sessionId)+'";'
                        self.__db.execute(sql)
                        uid = self.__db.getCursor().fetchone()
                        if uid != None:
                            self.__userId = uid[0]
        else:
            #for confirm reset password
            pass
                        
                
    def getUserId(self):
        return self.__userId
        
    def getUsername(self):
        return self.__username
        
    def getPassword(self):
        return self.__password
    
    def getFirstname(self):
        return self.__firstname 
        
    def getLastname(self):
        return self.__lastName
        
    def getEmailAddress(self):
        return self.__emailAddress
        
    def getPhoneNumber(self):
        return self.__phoneNumber
        
    def getStatus(self):
        return self.__status
        
    def getOrganization(self):
        return self.__organization
        
    def getPosition(self):
        return self.__position
        
    def getLanguage(self):
        return self.__language
        
    def getTimezone(self):
        return self.__timezone
        
    def setTimezone(self, timezone):
        self.__timezone = timezone
        
        if self.__userId != None:
            sql = "UPDATE `user` SET `timezone`='"+str(self.__timezone)+"' WHERE `user_id`= '"+str(self.__userId)+"';"     
            if self.__db.execute(sql):
                self.__db.commit()
        
    def __setSessionToken(self):
        self.__sessionId = self.__idGenerator()
        
        #check login status
        sql = "SELECT `user_id`, `session_id`,`status` FROM `session` WHERE `user_id`= '"+str(self.__userId)+"';"
        if self.__db.execute(sql):
            
            data = self.__db.getCursor().fetchone()
            if data:
                #this userId had ever logged in before.
                self.__loginStatus = data[2]
                
                if self.__loginStatus:
                    requests.get(NOTIFICATION_URL+'?session_id='+str(data[1]))
                    
                sql = "UPDATE `session` SET `session_id`='"+str(self.__sessionId)+"', `status`=True  WHERE `user_id`= "+str(self.__userId)+";"     
                if self.__db.execute(sql):
                    self.__db.commit()
            	    
        else:
            #no entry of this userId. (login first time)
            while True:
                sql = "INSERT INTO `session`(`user_id`, `session_id`) VALUES ('"+str(self.__userId)+"','"+str(self.__sessionId)+"');"
            
                if self.__db.execute(sql):
                    #session_id is not duplicated
                    self.__db.commit()
                    break
                else:
                    #session_id is duplicated
                    self.__sessionId = self.__idGenerator()           
        
    def getSessionToken(self):   
        return self.__sessionId
        
        
    def __idGenerator(self,size=6, chars=string.ascii_uppercase + string.digits):
        return ''.join(random.choice(chars) for _ in range(size))
        
        
    def resetPassword(self,password=None,confirm=False,genId=None):
        db = Database()
        if db.connect():
            #user request to reset password from GUI
        
            if not confirm :
                hashObject = hashlib.sha512(password)
                passwordDig = hashObject.hexdigest()
                
                try:
                        
                    #generate id
                    while True:
                        genID = self.__idGenerator(size=GEN_ID_LENGTH)
                        sql = "SELECT * FROM forget_password WHERE id='"+str(genID)+"'"
                        db.execute(sql)
                        data = db.getCursor().fetchone()
                        if not data:    #not duplicate ID
                            break
                        else:           #duplicate ID   
                            genID = self.__idGenerator(size=GEN_ID_LENGTH)
                    
                    
                    sql = "SELECT * FROM `forget_password` WHERE `user_id` ='"+str(self.__userId)+"';"
                    
                    if db.execute(sql) :
                        data = db.getCursor().fetchone()
                        if not data:     #username doesn't already exist
                            pass
                        else:            #username already exist  
                            sql = "DELETE FROM `forget_password` WHERE `user_id`='"+str(self.__userId)+"'"
                            db.execute(sql)
                        
                    now = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')
                    sql = "INSERT INTO `forget_password`(`id`, `user_id`, `password`,`timestamp`) VALUES ('"+str(genID)+"','"+str(self.__userId)+"', '"+str(passwordDig)+"', '"+str(now)+"');"
                    
                    if db.execute(sql) :
                        #if commit -> will continue..
                        db.commit()
                         
                        body = "Dear "+str(self.__firstname)+",\n\n"
                        body += "We've recieved a request to reset the password for this account. \n\n"
                        body += "To reset your password please click on this link: "+RESET_PASSWORD_URL+'?id='+str(genID)                    
                        
                        msg = MIMEText(body)
                        msg['Subject'] = "PRAGMA Cloud Scheduler : Reset password"
                        msg['From'] = SOURCE_EMAIL
                        msg['To'] = self.__emailAddress
                    
                        s = smtplib.SMTP('localhost')
                        s.sendmail(msg['From'], [msg['To']], msg.as_string())
                        s.quit()
                        
                        return True
                except:
                    db.rollback()
                finally:
                    db.close()
                    
            else:
                #after confirm to reset password from email
                if genId != None and len(genId)==GEN_ID_LENGTH and not '\'' in genId and not ',' in genId and not '"' in genId and not '=' in genId and not ' ' in genId: #check for sql injection
                    sql = "SELECT * FROM `forget_password` WHERE `id` ='"+str(genId)+"';"
                    if db.execute(sql) :
                        data = db.getCursor().fetchone()
                        if not data:
                            return False
                        else:
                            userId = data[1]
                            password = data[2]
                            timeStamp = datetime.strptime(str(data[3]),'%Y-%m-%d %H:%M:%S')
                            now = datetime.utcnow()
                            
                            if now-timeStamp < timedelta(minutes = RESET_PASSWORD_TIME):
                                sql = 'UPDATE `user` SET `password` = "'+str(password)+'" WHERE `user_id` = '+str(userId)+';'
                                if db.execute(sql) :
                                    db.commit()
                                    return True
                                else:
                                    sql = 'SELECT `password` FROM `user` WHERE `user_id` = '+str(userId)+';'
                                    if db.execute(sql):
                                        data = db.fetchone()
                                        if data != None:
                                            if data[0] == password:
                                                return True
                   
        return False
                
    def getPublicKey(self):
        return self.__publicKey
    
    def setSessionStatus(self,status):
        sql = "UPDATE `session` SET `status`="+str(status)+" WHERE `user_id`= '"+str(self.__userId)+"';"  
	
        if self.__db.execute(sql):
            self.__db.commit()
            return True
        return False
