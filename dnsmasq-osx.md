* https://passingcuriosity.com/2013/dnsmasq-dev-osx/
* https://www.stevenrombauts.be/2018/01/use-dnsmasq-instead-of-etc-hosts/
* https://gist.github.com/radut/3e45e016cdfb622597437e5c376df2b4


```
brew install dnsmasq

mkdir -pv $(brew --prefix)/etc/


echo 'proxy-dnssec' >> $(brew --prefix)/etc/dnsmasq.conf
echo 'address=/.dev/127.0.0.1' >> $(brew --prefix)/etc/dnsmasq.conf
echo 'server=/consul/127.0.0.1#8600' >> $(brew --prefix)/etc/dnsmasq.conf
echo 'server=/cluster.local/10.96.0.10' >> $(brew --prefix)/etc/dnsmasq.conf
echo 'server=1.1.1.1' >> $(brew --prefix)/etc/dnsmasq.conf


sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/cluster.local'


sudo launchctl stop homebrew.mxcl.dnsmasq
sudo launchctl start homebrew.mxcl.dnsmasq
```

## fix resolv.conf if you modified it
```
sudo rm /etc/resolv.conf
sudo ln -s /var/run/resolv.conf /etc/resolv.conf
```



### other config 
```
# Tell dnsmasq to get its DNS servers from this config file only
no-resolv
# Add alternate DNS servers
server=1.1.1.1

```


#### change dns from cmd line
```
networksetup -setdnsservers Wi-fi 1.1.1.1
## check dns settings
scutil --dns
```
