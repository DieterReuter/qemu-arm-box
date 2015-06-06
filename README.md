

## Requirements for Vagrant
You'll need `vagrant` and the `vagrant-digitalocean` plugin on your host machine to create a Digital Ocean droplet. For a detailed description of this plugin, just visit the GH repo https://github.com/smdahlen/vagrant-digitalocean.

```
brew install vagrant
vagrant plugin install vagrant-digitalocean
```

Some usefull Vagrant commands for DigitalOcean:
```
vagrant digitalocean-list -r images $DIGITAL_OCEAN_TOKEN
```

DR, 2015