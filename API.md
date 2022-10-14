# One API endpoint serves a JSON data file

## Example

```json
{
    "folkfigur_water_temperature": "25",
    "folkfigur_air_temperature" : "12",
    "folkfigur_pm25_particles" : "0.6",
    "folkfigur_listens_to": {
        "song" : "Trilogy - Echoes Of Silence      Utgiven:  2012",
        "short_int" : 3
    },
    "folkfigur_eats" : {
        "food" : "Potatis och purjolökssoppa",
        "short_int" : 4
    },
    "folkfigur_surprise" : {
        "event" : "Djur i spåret",
        "short_int" : 5
    },
    "folkfigur_train_with" : {
        "operator" : "Skånetrafiken",
        "short_int" :6
    }           
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

The Folkfigur web client has a "mint" button.

Clicking this button triggers the following procedure

1. the client generates a JSON file that contains the folkfigir JSON data, as well as the metamask signature, and a IPFS id pointing to the JSON metadata file for this folkfigur. The folkfigur JSON has been retrieved by the client from the endpoint described above. The address and signature are provided by the client's metamask. The generated JSON can look like:
```json
{
  "folkfigur_json" : {....},
  "name": "Jane Doe",
  "address": "0xeabbbbe...",
  "signature": {...},
  "IPFS_id":"0x..."
}
```
2. send back the generated JSON to the folkfigur API. For example curl -X POST --data "{"folkfigur_json" : {....},..}" https://api42.folkfigur.se/v1/wait
3. In the backend, the JSON file is added to the waiting list of NFTs to be minted. For now, the file is stored on the folkfigur server. Should eventually be on IPFS
4. The API sends back the position of this piece in the minting queue
```json
{"queue": 2}
```



