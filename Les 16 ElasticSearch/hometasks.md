## Задания:
1) Завести Elasticsearch Cluster в Европе
2) Зайти в Kibana -> Dev Tools
3) Создать индекс elasticsearch_cluster с динамическим маппингом с информацией об инстансах созданного ELK стека (в каких регионах созданы, какой продукт, для Elasticsearch – какой вид нода, является ли текущим мастером). Информацию берите из deployment на клауде.
```
# Creating index
PUT /elasticsearch_cluster
{
  "settings": {},
  "mappings": {}
}

# Adding documents
POST elasticsearch_cluster/_doc/0
{
	"zone": "eu-west-2a",
	"type": "AWS.DATA.HIGHIO.I3",
	"num": "0",
	"version": "7.10.1",
	"role": {
		"master eligible": "true",
		"data": "true",
		"coordinating": "true",
		"ingest": "true",
		"master": "false",
		"ML": "false"
	}
}

POST elasticsearch_cluster/_doc/1
{
	"zone": "eu-west-2a",
	"type": "AWS.KIBANA.R5D",
	"num": "1",
	"version": "7.10.1"
}

POST elasticsearch_cluster/_doc/2
{
	"zone": "eu-west-2b",
	"type": "AWS.APM.R5D",
	"num": "0",
	"version": "7.10.1"
}

POST elasticsearch_cluster/_doc/2
{
	"zone": "eu-west-2b",
	"type": "AWS.APM.R5D",
	"num": "1",
	"version": "7.10.1"
}

POST elasticsearch_cluster/_doc/3
{
	"zone": "eu-west-2b",
	"type": "AWS.DATA.HIGHIO.I3",
	"num": 0,
	"version": "7.10.1",
	"role": {
		"master eligible": false,
		"data": true,
		"coordinating": true,
		"ingest": true,
		"master": true,
		"ML": false
	}
}

POST elasticsearch_cluster/_doc/4
{
	"zone": "eu-west-2c",
	"type": "AWS.MASTER.R5D",
	"num": 0,
	"version": "7.10.1",
	"role": {
		"master eligible": true,
		"data": false,
		"coordinating": false,
		"ingest": false,
		"master": false,
		"ML": false
	}
}
```
4) Создать индекс с временнЫми данными из любой предметной области. У индекса должно быть 3 primary shards и 3 replica shards. Mapping должен быть кастомным, при этом должны быть как анализируемые текстовые поля, так и keyword (чтобы соответствовало смыслу). Дата должна быть в формате дата, а также должны присутствовать числовые данные. Новые текстовые поля должны индексироваться только как keyword.  На одном из keyword полей выключите doc_values. Одно из полей не должно индексироваться вовсе.
```
PUT /weather1
{
  "settings": {
  		"index.number_of_shards": 3,
  		"number_of_replicas": 3
  	},
  "mappings": {
	  "properties": {
	    "@datetime": {"type": "date_nanos"},
	    "country": {"type": "keyword", "doc_values": false},
	    "city": {"type" : "keyword"},
	    "temp": {"type" : "float"},
	    "humidity": {"type" : "float"},
	    "pressure": {"type" : "float"},
	    "wind_speed": {"type" : "float"},
	    "wind_dir": {"type" : "short", "enabled": false},
	    "desc": {"type": "text"}
	   }
	}
}
```
5) Написать сложный bool запрос с различными видами queries и написать словами, что он показывает.
Запрос показывает документы, где температура ближе или ниже 0 и влажность близка либо выше 90% в городе Гродно, который находиться не в Польше, причём наличие снега делает запись приоритетней.
```
GET weather1/_search
{
  "query": {
    "bool": {
      "must": 
      [
        {
          "match": {
            "city": "Grodno"
          }
        }
      ],
      "must_not": 
      [
        {
          "match": 
          {
            "country": "Poland"
          }
        }
      ],
      "should": 
      [
        {
          "match_phrase": 
          {
            "desc": "snow"
          }
        },
        {"range": {
            "temp": {
              "lte": 0
            }
          }
        },
        {"range": {
          "humidity": {
            "lte": 90
          }
        }
        }
      ]
    }
  }
}
```
6) Написать сложную агрегацию с sub-buckets и сортировкой по метрикам и написать словами, что она показывает. Ответ должен содержать только результаты агрегации, но не сами документы.

Запрос выведет по возрастанию средние значения влажномти по дням.
```
GET weather1/_search
{
  "size": 0,
  "aggs": {
    "date_hist":
    {
      "date_histogram": {
        "field": "@datetime",
        "interval": "day",
        "order": {
          "avg_hum": "asc"
        }
      },
      "aggs": {
        "avg_hum": {
          "avg": {
            "field": "humidity"
          }
        }
      }
    }
  }
}
```