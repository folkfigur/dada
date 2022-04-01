# dada
data collection for generative art

## SCB API:

Ref documentation: https://www.scb.se/contentassets/79c32c72783a4f67b202ad3189f921b9/api_description.pdf

Examples:

```
curl http://api.scb.se/OV0104/v1/doris/en/ssd/BE/BE0401/BE0401B

```

When you GET you get the metadata, when you POST you get the values

```
# BE means population database
# BE0101 is 'Demographic Analysis (Demography)'
curl -X POST --data @queries/population-query.json -H "Content-type: application/json" http://api.scb.se/OV0104/v1/doris/en/ssd/BE/BE0101/BE0101A/BefolkningNy
```

general idea, get a category of data, eg `BE/BE0101/BE0101A/BefolkningNy` and then write a query

there is a rate-limit of [10 call-ups in a 10-second period from an IP address](https://www.scb.se/en/services/open-data-api/).

## Libraries

Python: https://github.com/kirajcg/pyscbwrapper/ (in pip)

Java: https://github.com/dannil/scb-java-client

## Databases

### BE population

```
[{'id': 'BE0001', 'type': 'l', 'text': 'Name statistics'},
 {'id': 'BE0401', 'type': 'l', 'text': 'Population projections'},
 {'id': 'BE0701', 'type': 'l', 'text': 'Demographic Analysis (Demography)'},
 {'id': 'BE0101', 'type': 'l', 'text': 'Population statistics'}]

```

## Website

This link [https://www.statistikdatabasen.scb.se/pxweb/en/ssd/](https://www.statistikdatabasen.scb.se/pxweb/en/ssd/) is handy to manually explore all data available at SCB.

## Other data

### Trafikverket

- Documentation about the APIs at Trafikverket: https://www.trafiklab.se/
- [Python module for communicating with the swedish trafikverket api](https://github.com/endor-force/pytrafikverket)
- HTML UI <https://www.trafikverket.se/trafikinformation/meddelanden/?Counties=14&Filtertype=trainMessage&>

Requests:

```
# seems we can also have RoadMessage and FerryMessage
curl 'https://api.trafikinfo.trafikverket.se/data.json' -X POST -H 'Content-Type: text/xml' --data-raw '<REQUEST><LOGIN authenticationkey="openapiconsolekey" /><QUERY objecttype="TrainMessage" schemaversion="1.3"><INCLUDE>StartDateTime</INCLUDE><INCLUDE>LastUpdateDateTime</INCLUDE><INCLUDE>ExternalDescription</INCLUDE><INCLUDE>ReasonCodeText</INCLUDE></QUERY></REQUEST>'
```

Image of the road: <https://api.trafikinfo.trafikverket.se/v1/Images/RoadConditionCamera_39635662.Jpeg?type=fullsize>
