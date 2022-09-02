One API endpoint serves a JSON data file

# Example

```
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

# DocumentationNaturvårdsverket 

The data file is a mashup extracted from several public APIs provided by Swedish public services, as documented below.

## folkfigur_water_temperature

The temperature is probed in the Mälaren lake, in [Södertälje](https://www.openstreetmap.org/node/30097996). It is provided through this [endpoint](https://sodertalje.eu-gb.mybluemix.net/getwatertemp).

## folkfigur_air_temperature

We collect the temperature measured in [Arvidsjaurs](https://www.openstreetmap.org/relation/935667), by [SMHI](https://www.smhi.se/data/oppna-data). It is provided through this [endpoint](https://opendata-download-metobs.smhi.se/api/version/1.0/parameter/1/station/159880/period/latest-day/data.json).

## folkfigur_pm25_particles

The level of [pm2.5 fine particles](https://en.wikipedia.org/wiki/Particulates) is measured throughout Sweden by [Naturvårdsverket](https://www.naturvardsverket.se/). For folkfigur, we pick one value at a random location. The data is provided through this [endpoint](https://www.naturvardsverket.se/data-och-statistik/luft/realtidsdata/partiklar-pm25-halter-i-luft-de-senaste-24-timmarna.json). 

## folkfigur_listens_to

[Sveriges radio](https://sverigesradio.se/radiosweden) provides its track list in realtime, through this [endpoint](http://api.sr.se/api/v2/playlists/rightnow?channelid=2576&format=json).

## folkfigur_eats

We fetch the food of the day in the school menu of [Hassle skola](https://skolmaten.se/hassle-skola/), in [Mariestad](https://www.openstreetmap.org/node/27430678). It is provided through this [endpoint](https://skolmaten.se/hassle-skola/rss/days/?limit=7).

## folkfigur_surprise

The surprise event is a train message displayed anywhere in Sweden and collected by [Trafikverket](https://www.trafikverket.se/). It is provided in the [TrainAnnouncement](https://api.trafikinfo.trafikverket.se/API/Model) at this [endpoint]( 'https://api.trafikinfo.trafikverket.se/data.json).

## folkfigur_train_with

This is one of Sweden'e [train operators](https://en.wikipedia.org/wiki/Rail_transport_in_Sweden#Operators) collected by [Trafikverket](https://www.trafikverket.se/). It is provided in the [TrainMessage](https://api.trafikinfo.trafikverket.se/API/Model) at this [endpoint]( 'https://api.trafikinfo.trafikverket.se/data.json).
   
