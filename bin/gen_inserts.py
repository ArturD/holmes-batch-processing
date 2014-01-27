import sys
import json

batch  = []

def printBatch(batch):
	if len(batch) > 0:
		print "INSERT INTO  `article_types` (wiki_id, page_id, type)", " VALUES", ",".join(batch) , " ON DUPLICATE KEY UPDATE type=values(type);";
	
i = 0

for line in sys.stdin:
	page = json.loads(line)
	cls = "\"" + page["classification"]["singleClass"] + "\""
	if cls == "\"other\"":
		continue
		cls = "NULL"
	batch.append("".join(["(", str(page["wikiId"]), ", " , str(page["pageId"]) , ",", cls,")"]))
	i+=1
	if i > 49:
		printBatch(batch)
		batch = []
		i = 0
if len(batch) > 0:
	printBatch(batch)
