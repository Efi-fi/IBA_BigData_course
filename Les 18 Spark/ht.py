from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession
from datetime import datetime
from pyspark.sql.functions import *

#from pyspark.sql.functions import col


conf = SparkConf().setAppName('app1')
sc = SparkContext(conf=conf)

spark = SparkSession.builder.getOrCreate()

df = spark.read.format('json').load('alerts.json')
#df.printSchema()

task3 = df.withColumn("event_time", to_timestamp(df.event_time))
#task3.filter(task3.event_time >= lit("2019-06-10") and task3.event_time < lit("2019-06-19")).show()
#task3.printSchema()

task4 = task3.filter(df.event_source_type == "healthchecker_alert")
#task4.show()

task51 = task4.groupBy("alert_id", to_date("event_time").alias("date")).agg(min("event_time").alias("event_time_min"))
task5 = task4.drop("alert_id").join(task51, (task51.event_time_min == task4.event_time), 'inner').drop('event_time_min', 'date')
#task5.show()

task6 = task5.select(task5.alert_id, task5.event_source_type, explode(task5.entitled_assets).alias('asset_id') , task5.event_time, task5.instance_id, task5.serial)
#task6.show()

task7 = task6.select(task6.alert_id, task6.event_time, to_date(task6.event_time).alias("date"), task6.asset_id)
task7.show()

task7.write.csv('result.csv', header=True)

