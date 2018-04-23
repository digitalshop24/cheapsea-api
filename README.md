# Start
`rake app:reset` drops database, creates database, runs migration, seeds, import

# Import
## All
`rake import:all` runs all imports
## Airlines: 
`rake import:airlines`
runs the task but checks if airline existed
## City codes
`rake import:airlines`
doesn't run the task if there are any city codes in database
## Offers
### Two sides the cheapest offers
  `rake import:two_sides_cheapest_offers` import the cheapest offers for two sides
### One side the cheapest offers
  `rake import:one_side_cheapest_offers` import the cheapest offers for one side

# Deploy

```
sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs "/home/deploy/apps/appname/current/config/nginx.conf" "/etc/nginx/sites-enabled/appname"
cap production deploy
```

# Sidekiq

`sidekiq -q critical,2 -q default`

`sidekiq -e production` for production

## Workers
`Import::TwoSidesCheapestOffersWorker.perform_async` import cheap offers
