# This script for Only check the Active directory Replication Summary also email the status.
# This script will run inside the AD or ADC

'''
#-------------Sample output-------------#
############### 'AD Replication Status' ###############

 Replication Summary Start Time: 2024-02-06 12:02:24
Source DSA          largest delta    fails/total %%   error
 AD             09m:41s    0 /   5    0
 ADC            05m:57s    0 /   5    0
 
 Destination DSA     largest delta    fails/total %%   error
 AD             05m:57s    0 /   5    0
 ADC            08m:44s    0 /   5    0

'''


import os
import smtplib
from email.message import EmailMessage
import re
result = os.system('repadmin /replsummary > output.txt')	# Save the output in a file.

output = open('output.txt', 'r')				# Read the file
lines = output.readlines()					# Read the lines one by one

one = lines[0].strip()
two = str(lines[12].strip())
three = str(lines[14].strip())
four = str(lines[16].strip())
five = str(lines[20].strip())
six = str(lines[22].strip())
seven = str(lines[24].strip())
eight = str(lines[26].strip())

body = (f"{one}", f"{two}", f"{three}", f"{four}", f"{five}", f"{six}", f'{seven}', f'{eight}')		# Create tuple for email body

msg = EmailMessage()

msg.set_content(f" {'#'*15} 'AD Replication Status' {'#'*15} \n\n {body[0]}\n{body[1]}\n {body[2]}\n {body[3]}\n {body[4]}\n {body[5]}\n {body[6]}\n {body[7]}")

try:
        msg["Subject"] = f"Anyconnect AD"
        msg["From"] = "test@test.org"
        msg["cc"] = "test1@test.org"
        msg["To"] = "test2@test.org"
        server = smtplib.SMTP("smtp.office365.com", 587)
        server.ehlo()
        server.starttls()
        server.login("test@test.org", "YourEmailPassword")
        server.send_message(msg)
        server.quit()
        del msg["Subject"]
        del msg["From"]
        del msg["To"]
        del msg["cc"]
        print("Email send done")

except:
        print("Error: Email Send failed")

output.close()

