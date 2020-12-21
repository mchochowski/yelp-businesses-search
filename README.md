# Yelp Businesses Search

Simple wrapper for Yelp's business search and related endpoints.


### Usage

```
yelp = YelpBusinessesSearch::Client.new(api_key: '<your-api-key>')
yelp.lookup(query: 'coffee', location: '10025')
```
