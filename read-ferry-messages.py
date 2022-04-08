# Test reading ferry announcements  
  
import json
import glob
import os

def printOneFerry(fName):
	baldessari = json.load(fName)
	#print(baldessari["RESPONSE"]["RESULT"])
	for john in baldessari["RESPONSE"]["RESULT"]:
		for boring in john['FerryAnnouncement']:
			print("from "+boring["FromHarbor"]["Name"]+" to "+boring["ToHarbor"]["Name"]+" planned at "+boring["DepartureTime"])


directory = './data/trafikverket-20220408/'

for filename in glob.glob(directory+"Ferry*"):
	f = open(filename,)
	printOneFerry(f)
	f.close()


  

