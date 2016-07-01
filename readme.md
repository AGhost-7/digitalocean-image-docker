# Digital Ocean Docker
Packer configuration for Digital Ocean droplet provisioned with docker and
docker-compose pre-installed. This will only build a Digital Ocean image.
After building you can go into the Digital Ocean image administration page;
you will find the built packer image there. Under "more" you can create a
new droplet.

## How to use
```
packer build -var 'api_token=YOUR API TOKEN' template.json
```

## Using the docker registry remotely
Since by default the docker registry only accepts local connections, you
can set up an ssh tunnel and just push your images without additional setup:

```
ssh -f -N -L 5000:localhost:5000 user@server
docker push localhost:5000/app-image
```

You can check the docker documentation if you want to use tls instead:

https://docs.docker.com/registry/deploying/#/running-a-domain-registry

## Setting up SSL
Since the LetsEncrypt SSL certificate can't be generated during the build,
you'll need to generate it manually.

It is recommended to use the standalone certification method.
```
certbot-auto certonly --standalone -d www.example.com -d example.com
```

After that you can just run `certbot-cron` to enable the auto-renew.

source: https://certbot.eff.org/#ubuntutrusty-other

