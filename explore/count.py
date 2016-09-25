import re


def findUser(line):
    found = re.search("UserId=\"(.+?)\"", line)
    if found:
        return (found.group(1), 1)
    else:
        return ('0', 0)


textFile = sc.textFile("Posts.xml")
wordCounts = textFile.map(findUser).reduceByKey(lambda a, b: a + b).sortBy(lambda (word, count): count)
# wordCounts.collect()
wordCounts.coalesce(1).saveAsTextFile("out2")
