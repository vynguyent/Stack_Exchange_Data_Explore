# Stack_Exchange_Data_Explore

#### Database 
The whole database of StackExchange can be found <a href="https://archive.org/details/stackexchange">here</a>.    

There are 318 communities in Stack Exchange and the files look like:  

---- 3dprinting.stackexchange.com   
-------- Badges.xml   
-------- Comments.xml   
-------- PostHistory.xml   
-------- ...........   
---- academia.stackexchange.com   
-------- Badges.xml   
-------- Comments.xml   
-------- PostHistory.xml   
-------- ..........   
---- ........     
---- ........    
---- ........    

After I downloaded the 7z file, I unziped it and use the script "to_mongo.py" to save it into a mongodb database.    

If you are using PyCharm, there is a awesome plugin for mongodb which is called "mongo4idea". 
You can download <a href="https://github.com/dboissier/mongo4idea/raw/master/snapshot/mongo4idea-0.8.0-idea2016-distribution.zip">it</a> 
from <a href="https://github.com/dboissier/mongo4idea">mongo4idea</a> and put it under the "PyCharm Community Edition\plugins" directory.

##### Connect to mongodb
Since I'm now using my own desktop as the mongodb server, you need to connect my server via <a href="https://ngrok.com/">gnork</a>. Don't worry! It's quite easy. 
Once you have your <username>, <password> and <ngrok_address>, you can connect to the server using the sample code below:  

Python:  
~~~~
from pymongo import MongoClient
client = MongoClient(<ngrok_address>)
client.admin.authenticate(<username>, <password>)
client.database_names()
~~~~

R:  
~~~~
library(mongolite)
client <- mongo(collection=<collection_name>, db=<database_name>, url="mongodb://<username>:<password>@<ngrok_address>")
~~~~

Note: For R users, it seems that you can only connect to one database at a time.

#### Apache Spark
Mongodb is good! But soon you will find that it is still too slow. So it seems that Spark is the only choice.   

After you download the latest version of Apache Spark, you can run it in iPython Notebook.  

iPython Notebook
~~~~
import os
import sys

spark_home = "D:\spark-2.0.0-bin-hadoop2.7"  # change this directory to your won! 
os.environ['SPARK_HOME'] = spark_home
sys.path.append(os.path.join(spark_home, "python"))
sys.path.append(os.path.join(spark_home, "python", "lib", "py4j-0.10.1-src.zip"))

execfile(os.path.join(spark_home, "python", "pyspark", "shell.py"))
~~~~









