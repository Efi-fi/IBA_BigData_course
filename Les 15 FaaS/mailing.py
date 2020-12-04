import smtplib
from email.mime.text import MIMEText
from email.header import Header

dict = {
	'username': "my.own.test.mail.2000@gmail.com",
	'password': "mypassword=0",
	'host': "smtp.gmail.com:587",
	'subject': "Dollar rate $$$",
	'to_adr': "my.own.test.mail.2000@gmail.com",
	'from_adr': "my.own.test.mail.2000@gmail.com",
	'Cur_OfficialRate': 123214
}

def main(dict):
	server = smtplib.SMTP(dict['host'])
	server.starttls()
	server.ehlo()
	server.login(dict['username'], dict['password'])

	subject = dict['subject']
	body = f'Курс доллара: 1$ = {dict["Cur_OfficialRate"]} BYN\r\n\r\nС уважением\r\nЕфим'
	msg = MIMEText(body, 'plain')
	msg['Subject'] = Header(subject)

	server.sendmail(dict['from_adr'], [dict['to_adr']], msg.as_string())
	server.quit()

main(dict)
