#!/usr/bin/env python3
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication
import smtplib
import json
import argparse

parser = argparse.ArgumentParser("Enviado desde la clase de las 10.")
parser.add_argument("destinatario", help="destinatario")
parser.add_argument("asunto", help="mensaje", type = str)
parser.add_argument("mensaje", help="mensaje", type = str)
parser.add_argument("archivo", help="archivo", type = str)

param= parser.parse_args()
dest= params.destinatario
msj=params.mensaje
asun=params.asunto
file=params.archivo

data = {}
# create message object instance
msg = MIMEMultipart()

# setup the parameters of the message

msg['From'] = 'diego.avilalp@uanl.edu.mx'

msg['To'] = (dest)
msg['Subject'] = (asun)

 

# add in the message body
msg.attach(MIMEText(msj, 'plain'))
msg.attach(MIMEText(open(file).read()))
msg.attach(MIMEApplication(open(file, 'rb').read()))
#create server
server = smtplib.SMTP('smtp.office365.com:587')

server.starttls()

# Login Credentials for sending the mail
server.login('diego.avilalp@uanl.edu.mx','82435879B')

# send the message via the server.
server.sendmail(msg['From'], msg['To'], msg.as_string())
server.quit()

print("successfully sent email to %s:" % (msg['To']))
