# Start
`rake app:reset` drops database, creates database, runs migration, seeds, import

# Import
`rake import:countries` import cities if there are no in the database

`rake import:airlines` import airlines and synchronized with new records

`rake import:cities` import countries if there are no in the database

`rake import:airports` import airports if there are no in the database

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
#### google_place_ids_cache
contains google_id as a key and data from Google Map API
```
.5.1 :004 > JSON.parse(ReadCache.redis.hget('google_place_ids_cache', 'ChIJOwg_06VPwokRYv534QaPC8g'))
 => {"results"=>[{"address_components"=>[{"long_name"=>"Нью-Йорк", "short_name"=>"Нью-Йорк", "types"=>["locality", "political"]}, {"long_name"=>"Нью-Йорк", "short_name"=>"NY", "types"=>["administrative_area_level_1", "political"]}, {"long_name"=>"Соединенные Штаты Америки", "short_name"=>"US", "types"=>["country", "political"]}], "formatted_address"=>"Нью-Йорк, США", "geometry"=>{"bounds"=>{"northeast"=>{"lat"=>40.9175771, "lng"=>-73.70027209999999}, "southwest"=>{"lat"=>40.4773991, "lng"=>-74.25908989999999}}, "location"=>{"lat"=>40.7127753, "lng"=>-74.0059728}, "location_type"=>"APPROXIMATE", "viewport"=>{"northeast"=>{"lat"=>40.9175771, "lng"=>-73.70027209999999}, "southwest"=>{"lat"=>40.4773991, "lng"=>-74.25908989999999}}}, "place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g", "types"=>["locality", "political"]}], "status"=>"OK"}
```

#### google_place_names_cache
contains name as a key and data from Google Map API

```
2.5.1 :006 > JSON.parse(ReadCache.redis.hget('google_place_names_cache', 'Нью-Йорк'))
 => {"predictions"=>[{"description"=>"Нью-Йорк, NY, USA", "id"=>"7eae6a016a9c6f58e2044573fb8f14227b6e1f96", "matched_substrings"=>[{"length"=>8, "offset"=>0}], "place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g", "reference"=>"CjQwAAAAp6yJ4kLgWdZYCCIFvaf1FcZN-zq6TKa6Ca4-4J_i9MCwbbTcsJfUaA_qS2W95x04EhD0ir-upL9YNxjFbFKgNq7_GhQmRfSD3bTndf8ZAO1VGVK9P_LtOg", "structured_formatting"=>{"main_text"=>"Нью-Йорк", "main_text_matched_substrings"=>[{"length"=>8, "offset"=>0}]
```

#### user_info_cache
contains user_id as a key and data

# Trello
## Task names
`BN1` - BackendNew{number} - for new features

`BF1` - BackendFix{number}- for fixes

`BR1` - BackendRefactoring{number} - for refactoring