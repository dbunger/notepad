
# How to limit bandwidth system wide on MacOS

Inspired by (https://blog.leiy.me/post/bw-throttling-on-mac/) ...

## Enable firewall

It's pf, the BSD firewall.

```
sudo pfctl -E
```

Disable it again with

```
sudo pfctl -d
```

## Change /etc/pf.conf

First backup ...

```
cp /etc/pf.conf ~
```

then add anchor ...

```
sudo vi /etc/pf.conf

dummynet-anchor ts
anchor ts
```

Then reload ...

```
sudo pfctl -f /etc/pf.conf
```

## Create the traffic shaper

```ts``` above stands for _traffic shaper_ ...

```
sudo dnctl pipe 1 config bw 3000Kbit/s queue 10
```

## Define the rules

```
vi rules.txt

dummynet out proto tcp from any to any pipe 1
dummynet out proto tcp from any to any pipe 1
```

This is for all traffic ... if you want to do per port =>

```
dummynet out proto tcp from any to any port 8080 pipe 1
dummynet out proto tcp from any port 8080 to any pipe 1
```

Load the rules ...

```
sudo pfctl -a ts -f rules.txt
```

## Check it

```
sudo dnctl show
```

Shows the traffic shaper, the bandwidth limit and later the open conections ...

