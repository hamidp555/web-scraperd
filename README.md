# web-scraperd
# To run system: skaffold dev

# To run spiders add starting urls and schedule jobs
## Examples:
## lpush crichd:start_urls https://hd.crichd.com/crichd-home
## curl http://localhost:6800/schedule.json -d project=scraperapp -d spider=crichd



# Commands for troubleshooting scraperd

## scraperd
### kubectl port-forward --namespace default service/scrd-web-scraperd 6800:6800
### curl http://localhost:6800/listprojects.json
### curl http://localhost:6800/listjobs.json?project=scraperapp
### curl http://localhost:6800/listspiders.json?project=scraperapp
### curl http://localhost:6800/daemonstatus.json

## Redis
### kubectl port-forward --namespace default service/redis-master 6379:6379 
### docker run --rm --name redis-commander -p 8081:8081 --env REDIS_HOST=host.docker.internal --env REDIS_PASSWORD=redispassword  rediscommander/redis-commander:latest 
### auth <redispassword>

## Splash
## kubectl port-forward --namespace default service/sps-web-splash 8050:8050
