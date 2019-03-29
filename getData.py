import requests
from pprint import pprint
import pickle

def downloadData():

	r = requests.get("https://3f0cb70c.ngrok.io/games/pull")
	data = r.json()

	with open('filename.pickle', 'wb') as handle:
	    pickle.dump(data, handle)

with open('filename.pickle', 'rb') as handle:
    b = pickle.load(handle)

print(b)