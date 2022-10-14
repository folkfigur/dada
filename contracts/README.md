# Folkfigur contract

## Deployment

The Folkfigur test contracts is deployed:
* on Ropsten <https://ropsten.etherscan.io/token/0x79e700fe3B4E514b47c24Fc5FC9633aCb860C540>
* on Rinkeby <https://rinkeby.etherscan.io/token/0x6ea8da9c46da2f7259ef9fc5dc4510ca25d7cce6>
* on Goerli  <https://goerli.etherscan.io/token/0xb0a3B8505752A790EEB4fc84Ca2b31510c3D25bA>

Opensea link: <https://testnets.opensea.io/collection/folkfigur>

## ABI

The Application Binary Interface (ABI) is in `Folkfigur.abi.json`.

### Query Folkfigur data
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

### Minting Folkfigur data

To mint, one calls method `mintFolkFigur(string calldata piece, string calldata ipfs)` where the first argument is a JSON file according to the Folkfigur schema, and the second argument is an IPFS identifier pointing to the metadata JSON (incl. description field and image snapshot).

For Opensea, an example metadata file pushed to IPFS is in `metadata.json`.

## Minting costs

On Goerli, a minting costs approx 580000 gas, see https://goerli.etherscan.io/tx/0x057f8b678ea4487ce4225f7e86f8731088b0514ea48d76c1e39ea7abac6bee42.

Under an conservative estimation of a price per gas of 40GWEI (see https://www.blocknative.com/gas-estimator), a single minting costs `0.024` ETH.

With a budget of 10 ETH, this makes 500 NFTs.



