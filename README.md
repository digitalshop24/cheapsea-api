Import airlines: `rake import:airlines`

**Deploy**

```
sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs "/home/deploy/apps/appname/current/config/nginx.conf" "/etc/nginx/sites-enabled/appname"
cap production deploy:initial
```