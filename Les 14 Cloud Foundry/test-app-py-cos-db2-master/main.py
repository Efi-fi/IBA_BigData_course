#!/usr/bin/python3
from flask import Flask, request, render_template, redirect
import ibm_boto3
from ibm_botocore.client import Config, ClientError
import os
import json
import ibm_db

data_cos = {}

if __name__ == '__main__':
    with open("./secret/credentials_cos.json", "r") as read_file:
        data_cos = json.load(read_file)

# Constants for IBM COS values
COS_ENDPOINT = "https://s3.eu-de.cloud-object-storage.appdomain.cloud"
BUCKET_NAME = 'bucket-1-efim'

COS_API_KEY_ID = data_cos['apikey']
ACCESS_KEY_ID = data_cos['cos_hmac_keys']['access_key_id']
SECRET_ACCESS_KEY = data_cos['cos_hmac_keys']['secret_access_key']

cos_cli = ibm_boto3.client("s3",
    COS_API_KEY_ID,
    endpoint_url=COS_ENDPOINT,
    aws_access_key_id=ACCESS_KEY_ID,
    aws_secret_access_key=SECRET_ACCESS_KEY
)


data_db = {}

if __name__ == '__main__':
    with open("./secret/credentials_db.json", "r") as read_file:
        data_db = json.load(read_file)
        
# get service information if on IBM Cloud Platform
if 'VCAP_SERVICES' in os.environ:
    db2info = json.loads(os.environ['VCAP_SERVICES'])['dashDB For Transactions'][0]
    db2cred = db2info["credentials"]
    appenv = json.loads(os.environ['VCAP_APPLICATION'])
else:
    print ('Not cloud environment')
    db2cred = {}
    db2cred['db']  = data_db['db']
    db2cred['hostname'] = data_db['hostname']
    db2cred['port'] = data_db['port']
    db2cred['username'] = data_db['username']
    db2cred['password'] = data_db['password']
    
app = Flask(__name__)

def human_readable_size(size, decimal_places=1):
    for unit in ['B','KB','MB','GB','TB']:
        if size < 1024.0:
            break
        size /= 1024.0
    dp = 0 if unit == 'B' else decimal_places
    return f"{size:.{dp}f} {unit}"
    
def get_bucket_contents():
    print("Retrieving bucket contents from: {0}".format(BUCKET_NAME))
    try:
        response = cos_cli.list_objects(Bucket=BUCKET_NAME)
        #print(response)
        res = []
        
        if "Contents" in response:
            for file in response["Contents"]:
                res.append((
                    file["Key"], 
                    human_readable_size(file["Size"]),
                    file["LastModified"].strftime("%Y-%m-%d %H:%M:%S"))
                )
        return res
        
    except ClientError as be:
        print("CLIENT ERROR: {0}\n".format(be))
    except Exception as e:
        print("Unable to retrieve bucket contents: {0}".format(e))
        

@app.route('/', methods=['POST', 'GET'])
def progress():
    files = get_bucket_contents()
    return render_template("main.html", files=files)
    
@app.route('/write_to_db', methods=['POST', 'GET'])
def write_to_db():
    # connect to DB2
    try:
        db2conn = ibm_db.connect("DATABASE="+db2cred['db']+";HOSTNAME="+db2cred['hostname']+";PORT="+str(db2cred['port'])+";UID="+db2cred['username']+";PWD="+db2cred['password']+";","","")
    except:
        connerr="Connection to database failed"
        print(connerr + ": " + str(ibm_db.conn_errormsg())) 
        return {"error": connerr}
    delete_stmt = ibm_db.exec_immediate(db2conn, "DELETE from for_app")
    filesAll = get_bucket_contents()
    for file in filesAll:
        sql = "INSERT INTO for_app VALUES (?)"
        stmt = ibm_db.prepare(db2conn, sql)
        ibm_db.bind_param(stmt, 1, file[0])
        ibm_db.execute(stmt)
    ibm_db.close(db2conn)
    return render_template("success.html")

if __name__ == '__main__':
    port = int(os.getenv('PORT', 8000))
    app.run(host="0.0.0.0", port=port)
