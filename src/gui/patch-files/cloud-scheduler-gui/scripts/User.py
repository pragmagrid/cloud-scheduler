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
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText

RESET_PASSWORD_URL = "http://LOCALHOST/reset_password"
SOURCE_EMAIL = "happy@vernity.com"


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
    
    
    def __init__(self,data=None,sessionId=None,getAnotherUserData=False): 
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
                    #SIGN IN
                    self.__setSessionToken()
                else:
                    #ADMIN REQUEST USER'S DATA
                    sql = 'SELECT `session_id` FROM `session` WHERE `user_id` = "'+str(self.__userId)+'";'
                    self.__db.execute(sql)
                    sessionId = self.__db.getCursor().fetchone()
                    if sessionId != None:
                        self.__sessionId = sessionId[0]
            else:
                #SET TIME ZONE
                self.__sessionId = sessionId
                sql = 'SELECT `user_id` FROM `session` WHERE `session_id` = "'+str(self.__sessionId)+'";'
                self.__db.execute(sql)
                uid = self.__db.getCursor().fetchone()
                if uid != None:
                    self.__userId = uid[0]
                    
                
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
    
        sql = "UPDATE `session` SET `session_id`='"+str(self.__sessionId)+"' WHERE `user_id`= '"+str(self.__userId)+"';"     
        if self.__db.execute(sql):
            #this userId had ever logged in before.
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
        
        
    def resetPassword(self,password):
        db = Database()
        if db.connect():
            
            hashObject = hashlib.sha512(password)
            passwordDig = hashObject.hexdigest()
            
            try:
                sql = 'SELECT * FROM `user` WHERE `username` = "'+str(self.__username)+'";'
                db.execute(sql)
                data = db.getCursor().fetchone()
            
                if data != None:
                    
                    #generate id
                    while True:
                        genID = self.__idGenerator()
                        sql = "SELECT * FROM forget_password WHERE id='"+str(genID)+"'"
                        db.execute(sql)
                        data = db.getCursor().fetchone()
                        if not data:    #not duplicate ID
                            break
                        else:           #duplicate ID   
                            genID = self.__idGenerator()
                    
                    
                    sql = "SELECT * FROM forget_password WHERE username='"+str(self.__username)+"'"
                    db.execute(sql)
                    data = db.getCursor().fetchone()
                    if not data:     #username doesn't already exist
                        pass
                    else:            #username already exist  
                        sql = "DELETE FROM `forget_password` WHERE `username`='"+str(self.__username)+"'"
                        db.execute(sql)
                        
                        
                    sql = "INSERT INTO `forget_password`(`id`, `username`) VALUES ('"+str(genID)+"','"+str(self.__username)+"', '"+str(passwordDig)+"')"
                    db.execute(sql)

                    
                    #if commit -> will continue..
                    toaddr = self.getEmailAddress()
                    msg = MIMEMultipart()
                    msg['From'] = SOURCE_EMAIL
                    msg['To'] = toaddr
                    msg['Subject'] = "CHAMP : Reset password"
                     
                    body = "Hello, "+str(self.getFirstName())+"\n\n"
                    body += "We've recieved a request to reset the password for this account. \n\n"
                    body += "To reset your password please click on this link: "+RESET_PASSWORD_URL+str(genID)
        
                    msg.attach(MIMEText(body, 'plain'))
             
                    server = smtplib.SMTP('mail.vernity.com', 587)
                    
                    server.starttls()
                    server.login(SOURCE_EMAIL, "@V3rn!ty")
                    text = msg.as_string()
                    
                    server.sendmail(SOURCE_EMAIL, toaddr, text)
                    server.quit()
                    
                    db.commit()
                    return True
            except:
                db.rollback()
            
            
        return False
                
    def getPublicKey(self):
        return self.__publicKey
