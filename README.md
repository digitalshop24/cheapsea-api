# Start
`rake app:reset` drops database, creates database, runs migration, seeds, import

# Import
## All
`rake import:all`
## Airlines: 
`rake import:airlines`
runs the task but checks if airline existed
## City codes
`rake import:airlines`
doesn't run the task if there are any city codes in database

# Deploy

```
sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs "/home/deploy/apps/appname/current/config/nginx.conf" "/etc/nginx/sites-enabled/appname"
cap production deploy
```

# Sidekiq

`sidekiq -q critical,2 -q default`

## Workers
`Import::CheapOffersWorker.perform_async` import cheap offers
