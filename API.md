# One API endpoint serves a JSON data file

## Example

```json
{
 "water": "25",
 "air": "12",
 "pm25": "0.6",
 "listens": {
  "song": "Trilogy - Echoes Of Silence      Utgiven:  2012",
   "int": 3
  },
 "eats": {
  "food": "Potatis och purjolökssoppa",
  "int": 4
 },
 "surprise": {
  "event": "Djur i spåret",
  "int": 5
 },
 "train": {
  "operator": "Skånetrafiken",
  "int":6
 },
 "elec": "12966"
}
```

## Documentation 

The data file is a mashup extracted from several public APIs provided by Swedish public services, as documented below.

### folkfigur_water_temperature

The temperature is probed in the Mälaren lake, in [Södertälje](https://www.openstreetmap.org/node/30097996). It is provided through this [endpoint](https://sodertalje.eu-gb.mybluemix.net/getwatertemp).

### folkfigur_air_temperature

We collect the temperature measured in [Arvidsjaurs](https://www.openstreetmap.org/relation/935667), by [SMHI](https://www.smhi.se/data/oppna-data). It is provided through this [endpoint](https://opendata-download-metobs.smhi.se/api/version/1.0/parameter/1/station/159880/period/latest-day/data.json).

### folkfigur_pm25_particles

The level of [pm2.5 fine particles](https://en.wikipedia.org/wiki/Particulates) is measured throughout Sweden by [Naturvårdsverket](https://www.naturvardsverket.se/). The data is provided through this [endpoint](https://www.naturvardsverket.se/data-och-statistik/luft/realtidsdata/partiklar-pm25-halter-i-luft-de-senaste-24-timmarna.json). 

For folkfigur, we pick pm2.5 measurement at a random location. 

### folkfigur_listens_to

[Sveriges radio](https://sverigesradio.se/radiosweden) provides its track list in realtime, through this [endpoint](http://api.sr.se/api/v2/playlists/rightnow?channelid=2576&format=json).

### folkfigur_eats

We fetch the food of the day in the school menu of [Hassle skola](https://skolmaten.se/hassle-skola/), in [Mariestad](https://www.openstreetmap.org/node/27430678). It is provided through this [endpoint](https://skolmaten.se/hassle-skola/rss/days/?limit=7).

For folkfigur, we pick one random dish in the week's menu.

### folkfigur_surprise

The surprise event is a train message displayed anywhere in Sweden and collected by [Trafikverket](https://www.trafikverket.se/). It is provided in the [TrainMessage](https://api.trafikinfo.trafikverket.se/API/Model) at this [endpoint]( 'https://api.trafikinfo.trafikverket.se/data.json).

For folkfigur, we pick one random message among all messages displayed in the train stations in Sweden.

### folkfigur_train_with

This is one of Sweden's [train operators](https://en.wikipedia.org/wiki/Rail_transport_in_Sweden#Operators) collected by [Trafikverket](https://www.trafikverket.se/). It is provided in the [TrainAnnouncement](https://api.trafikinfo.trafikverket.se/API/Model) at this [endpoint]( 'https://api.trafikinfo.trafikverket.se/data.json).

For folkfigur, we pick one random operator among all operators running a train  in Sweden. Possible values are:

```perl
"Länstrafiken Kronoberg"
"Mälardalstrafik AB"
"Mälartåg Kundservice"
null
"Öresundståg"
"SJ"
"Skånetrafiken"
"SL"
"Västtrafik"
"VY"
```
### last_electricity_data_in_megawatt

This data comes from [Svenska kraftnät](https://www.svk.se/) collected through the [control room](https://www.svk.se/om-kraftsystemet/kontrollrummet/) ([endpoint](https://www.svk.se/services/controlroom/v2/production?date=2022-09-09&countryCode=SE)). The number represents the total electricity production over all types of power plants. 

# One API endpoint to handle the minting waiting list

The Folkfigur web client has a "Enter the minting waitinlist" button.

Clicking this button triggers the following procedure:

1. The client asks the person for a name and email address. The email address will be used to send a notification when the NFT has been minted
2. Then, the client generates a JSON file for the minting waiting list, which contains:

- the JSON metadata file. The folkfigur JSON has been retrieved by the client from the endpoint described above. 
- the metamask signature of the folkfigur JSON.  For generating the signature, see example script in `src/signFolkfigurJson.js`.
- IPFS id pointing to the JSON metadata file for this folkfigur. The metadata file contains fields `name`, `description`, `image` and the folkfigur JSON file. Example metadata: <https://github.com/folkfigur/dada/blob/main/data/example-metadata-ipfs.json>, <https://ipfs.io/ipfs/QmfJAKTWcpuJgxfwabaVdDv6GtPG9xpsGhzhg7XUGQvaQf>
-  The address the minter's wallet,  provided by the client's metamask.
-  The name and email address of the person who wishes to mint a folkfigur.

The generated JSON looks like, see complete example in `data/example-json-for-waiting-list.json`:
```json
{
  "folkfigur_json" : {....},
  "name": "Jane Doe",
  "email" : "jane.doe@rick.roll"
  "address": "0xeabbbbe...",
  "signature": {...},
  "IPFS_id":"0x..."
}
```

2. send this JSON to the folkfigur API for being in the waiting list. 

    curl -X POST --data @data/example-json-for-waiting-list.json https://api42.folkfigur.se/v1/wait

3. In the backend, the JSON file is added to the waiting list of NFTs to be minted. For now, the file is stored on the folkfigur server. Should eventually be on IPFS
4. The API sends back the position of this piece in the minting queue
```json
{"queue": 2}
```
If the minter has already entered the waiting list with the same wallet, the API sends back an error message
```json
{"error": "You are already in the waiting list with this wallet. You can receive only one FolkFigur NFT per wallet."}
```

# Complete workflow for a citizen to get a FolkFigur NFT

<img src="https://github.com/folkfigur/dada/blob/main/folkfigur-workflow.png" alt="folkfigur workflow" title="The workflow from a citizen connecting to folkfigur.se to a folkfigur art piece minter" width="666"/>


The figure abover summarizes the architecture of folkfigur, as well as the general workflow when a citizen wants to mint a folkfigur NFT. The key components of the architecture are 
- the folkfigur server (FF server), which collects data, serves json files to generate art pieces and stores requests for minting
- the folkfigur client (FF client), which runs in the browser. It  generates and renders an artpiece, handles the connection with the user's wallet, orchestrates the interactions with pinata and the FF server to prepare the minting.
- the minter, a human in charge of manually minting folkfigur art pieces.

- 1 The user connects her wallet
- 2 The user connects to [https://folkfigur.se/home](https://folkfigur.se/home)
- 3 A new piece is generated
  - 3.1. the FF server sends a folkfigur json file to the browser
  - 3.2. the FF client side generates a unique artpiece with the json file and displays it in the browser
- 4 the user clicks the "mint" button (specified above), which triggers the following actions:
  - 4.1 the FF client receive the 'mint' event
  - 4.2 the FF client asks the wallet to sign the folkfigur json
  - 4.3 the wallet returns a signature.
  - 4.4 the FF client takes a snapshot of the folfigur art piece and sends an image file to pinata, which stores the file on IPFS
  - 4.5 pinata return the IPFS id of the image to the FF client
  - 4.6 the FF client generates a metadata file that includes the IPFS is of the image ([example](https://github.com/folkfigur/dada/blob/main/data/example-metadata-ipfs.json)) and sends the file to pinata, which stores the file on IPFS
  - 4.7 pinata returns the IPFS id of the metadata file
  - 4.8 the FF client generates a json file for waiting list ([example](data/example-json-for-waiting-list.json)), with the signature, the IPFS id of the metadata, the folkfigur json file and other information
  - 4.9 the FF server adds this file in the waiting list
- 5 A minter agent manually mints a NFT
  - 5.1 the minter fetches a file in the waiting list
  - 5.2 the FF server sends back a file
  - 5.3 the minter agent runs some checks on the folkfigur json and then mints it on the blockchain


