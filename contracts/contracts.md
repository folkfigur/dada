# Folkfigur contract

## Deployment
The Folkfigur test contract is deployed on Goerli <https://goerli.etherscan.io/address/0xb0a3B8505752A790EEB4fc84Ca2b31510c3D25bA>

## Query
For getting the Folkfigur character, one calls method `getFolkfigurByIndex` on the contract, with the id of the NFT.
It returns an array of two elements, the first element is the JSON file (the same produced by the API live endpoint), the second is the id.

```
# in web3.py
abi = json.load(open('Folkfigur.abi.json'))
contract = w3.eth.contract(address=w3.toChecksumAddress("0xb0a3B8505752A790EEB4fc84Ca2b31510c3D25bA"), abi=abi)
contract.functions.getFolkfigurByIndex(5).call()
# returns
['{\n    "folkfigur_water_temperature": "18.3",\n    "folkfigur_air_temperature": "12.7",\n    "folkfigur_pm25_particles": "1.449",\n    "folkfigur_listens_to": {\n        "song": "Hitkidd & Glorilla - F.N.F. (Let\'S Go)",\n        "short_int": 6\n    },\n    "folkfigur_eats": {\n        "menu": "Korv",\n        "short_int": 16\n    },\n    "folkfigur_surprise": {\n        "event": "Banarbete",\n        "short_int": 126\n    },\n    "folkfigur_train_with": {\n        "operator": "SJ",\n        "short_int": 73\n    },\n    "last_electricity_data_in_megawatt": "14519",\n    "ascii_art": "{_-_=---==_____-_=___===-__=-=_-=-=-=--=}"\n}', 5]
```

## Metadata

An example metadata file is in `metadata.json`.
