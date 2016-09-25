# Stack_Exchange_Data_Explore

#### Database 
The whole database of StackExchange can be found <a href="https://archive.org/details/stackexchange">here</a>. 
After I downloaded the 7z file, I unziped it and use the script "to_mongo.py" to save it into a mongodb database. 
If you are using PyCharm, there is a awesome plugin for mongodb which is called "mongo4idea". 
You can download <a href="https://github.com/dboissier/mongo4idea/raw/master/snapshot/mongo4idea-0.8.0-idea2016-distribution.zip">it</a> 
from <a href="https://github.com/dboissier/mongo4idea">mongo4idea</a> and put it under the "PyCharm Community Edition\plugins" directory.


#### How to get started  
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
client <- mongo(collection=<collection_name>, db=<database_name>, url="mongodb://<username>:<password>@<ngrok_address>/admin")
~~~~

Note: For R users, it seems that you can only connect to one database at a time. 