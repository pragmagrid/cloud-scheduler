.. highlight:: rest

PRAGMA Cloud Scheduler User Guide
============================================================

.. contents::

Create a cloud scheduler account
--------------------------------
#. Go to http://fiji.rocksclusters.org/cloud-scheduler and click on the “ Create an Account” link.
#. Fill out the required fields under “Login”, “Profile”, and “Additional Attributes”.
#. Click the “Register” button.  
#. You should receive an email from the PRAGMA Cloud Admin with subject “Please Activate Your Account”.  Click on the “activate your account” link in the email and it will automatically log you into the Cloud Scheduler.  

At this point you will able to view the resources but will not be able to make reservations.  We will receive an email when you create your account and once we verify your information, will add you to the appropriate group so that you can make reservations and send you a confirmation email.

Create a virtual cluster
------------------------
#. Login to the Cloud Scheduler by typing in your username and password at http://fiji.rocksclusters.org/cloud-scheduler/.

#. Once logged in, click on the “Schedule” tab as shown in the below image.  The days of the week and resources are shown in the rows of the table and the times of the day along the columns.  Any boxes with the red lines thru them mean that you do not have permission to access this resource or it is unavailable at this time.  Any white boxes with text (e.g., “16 Available CPUs…”) in them indicate there is available capacity left on the resource.  
 
   .. image:: images/Scheduler.png

#. If you click on a white box, a new pop up box will appear like below.  Follow the instructions indicated in the diagram.

   .. image:: images/reservation.png

#. If there are any errors with your parameters, an error message will be displayed. Otherwise you will get a confirmation screen like below:

   .. image:: images/confirmation.png

#. You should immediately get an email confirmation that your reservation was created like below:

   .. image:: images/created.png

#. When the reservation is being started at its scheduled time, you will receive another email and then again when the resources are available to be logged in.

   .. image:: images/ready.png

#. At this point, you should  be able to log into the resources directly.  E.g.,

   $ ssh root@rocks-57.sdsc.edu

 
