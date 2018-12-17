# Digital Ocean Packer Images

Packer configuration for Digital Ocean droplet with the following baked in:
- docker
- docker-compose
- docker-gc for cleanup of unused images
- strict default firewall rules
- minimal netdata configuration with 2 hours data retention of to the second
metrics.

After building you can go into the Digital Ocean image administration page;
you will find the built packer image there. Under "more" you can create a
new droplet.

## How to use
```
packer build -var 'api_token=YOUR API TOKEN' template.json
```

## Kubernetes
The kubernetes image comes with `kubeadm`, which is a tool that makes setting
up a custom cluster easier.

On the master:
```
kubeadm init --ignore-preflight-errors Swap --pod-network-cidr=10.244.0.0/16
```

Setup flannel:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
```

On a node:
```
kubeadm join ...
```

