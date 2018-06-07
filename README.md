# Start
`sudo kill -9 $(sudo lsof -t -i:3001)`

`rake app:reset` drops database, creates database, runs migration, seeds, import

# Import
`rake import:countries` import cities if there are no in the database

`rake import:airlines` import airlines and synchronized with new records

`rake import:cities` import countries if there are no in the database

`rake import:airports` import airports if there are no in the database

## ElasticSearch indices
### All
`rake elastic_import:all`

### 
`rake elastic_import:cities`

`rake elastic_import:airports`

`rake elastic_import:airlines`

`rake elastic_import:offers`

## Offers
### Cheapest
`rake import:two_sides_cheapest_offers` two sides

`rake import:one_side_cheapest_offers` one side

# Deploy

```
sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs "/home/deploy/apps/appname/current/config/nginx.conf" "/etc/nginx/sites-enabled/appname"
cap production deploy
```

# Sidekiq

`sidekiq -q critical,2 -q default`

`sidekiq -e production -d -L log/sidekiq.log` for production

## Workers
### Cheapest
`Import::TwoSidesCheapestOffersWorker.perform_async` two sides

`Import::OneSideCheapestOffersWorker.perform_async` one side

# Redis
## Cache
### Using
Access to redis cache provides ReadCache module, for example: `ReadCache.redis.hget('google_place_names_cache', input)`

### Keys
#### user_info_cache
contains user_id as a key and data

# Trello
## Task names
`BN1` - BackendNew{number} - for new features

`BF1` - BackendFix{number}- for fixes

`BR1` - BackendRefactoring{number} - for refactoring
