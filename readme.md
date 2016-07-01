# Digital Ocean Docker
Packer configuration for Digital Ocean droplet provisioned with docker and
docker-compose pre-installed. This will only build a Digital Ocean image.
After building you can go into the Digital Ocean image administration page;
you will find the built packer image there. Under "more" you can create a
new droplet.

## How to use
```
packer build -var 'api_token=YOUR API TOKEN' -var 'region=REGION TO DEPLOY' template.json
```
