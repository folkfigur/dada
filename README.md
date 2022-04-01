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
curl -X POST --data @queries/population-query.json -H "Content-type: application/json" http://api.scb.se/OV0104/v1/doris/en/ssd/BE/BE0101/BE0101A/BefolkningNy
```

