import os
import glob
import xmltodict
from pymongo import MongoClient

BASE_DIR = "E:\\stackexchange_Extracted"

client = MongoClient('localhost', 27017)


def parse_xml(path, topic_name):
    xml_name = os.path.basename(path).replace(".xml", "")
    db = client[topic_name.replace(".", "_")]
    with open(path, 'r') as fin:
        for line in fin:
            if "Id" not in line:
                continue
            parsed_line = xmltodict.parse(line)
            db[xml_name].insert(parsed_line['row'])

dirs = os.listdir(BASE_DIR)
for dirr in dirs:  # each community
    print dirr
    path = os.path.join(BASE_DIR, dirr, '*.xml')
    files = glob.glob(path)
    for fl in files:  # Badges.xml, Comments.xml, PostHistory.xml, PostLinks.xml, Posts.xml,Tags.xml,Users.xml,Votes.xml
        parse_xml(path=fl, topic_name=dirr)
