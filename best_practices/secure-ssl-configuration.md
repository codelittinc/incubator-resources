# Getting an A+ SSL Labs Score with Nginx and OpenSSL on Ubuntu
========

This doc will detail the steps for getting an A+ SSL rating using Nginx on Ubuntu.

## Generate a certificate

The first step in securing your server with SSL is to generate an SSL certificate. At this time, the only way to get a verified certificate that will be trusted across most Internet browsers is to pay for a certificate. 
Some good providers include:

* [GoDaddy](https://godaddy.com/web-security/ssl-certificate)
* [RapidSSL](https://www.rapidssl.com/)

```
testing
```

## Installing the certificate

### # TODO


## Installing the packages

Let's start with [OpenSSL](https://www.openssl.org/):

```
sudo apt-get install openssl
```

Next step is to get [Nginx](https://www.nginx.com/) installed and running. You can either install it using a pre-built package or compile it yourself (to perform some fine-tunnings):

```
sudo apt-get install nginx
```

Note: Check [Nginx instructions](https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/) to see how to compile it from source.

## Disable SSLv3

By default Nginx still enables SSLv31, which has been vulnerable to the POODLE attack since October 2014. The only browser that doesn’t support newer protocols out of the box is IE6, and even it can be configured to use TLSv1, so there’s no reason to support SSLv3 anymore. So keep in mind that disabling the SSLv3 will make your server incompatible for IE6. Add the following nginx config:

```
# support only known-secure cryptographic protocols
# SSLv3 is broken by POODLE as of October 2014
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
```

## Ciphersuite Configuration

The goal of cipher suite configuration is to ensure compatibility with as many browsers as possible, without compromising security or, to a lesser extent, performance.

This will be done by setting a configuration string that OpenSSL understands in our Nginx configuration. To keep thing simple here’s the relevant nginx configuration lines:

```
# make the server choose the best cipher instead of the browser
# Perfect Forward Secrecy(PFS) is frequently compromised without this
ssl_prefer_server_ciphers on;

# support only believed secure ciphersuites using the following priority:
# 1.) prefer PFS enabled ciphers
# 2.) prefer AES128 over AES256 for speed (AES128 has completely adequate security for now)
# 3.) Support DES3 for IE8 support
#
# disable the following ciphersuites completely
# 1.) null ciphers
# 2.) ciphers with low security
# 3.) fixed ECDH cipher (does not allow for PFS)
# 4.) known vulnerable ciphers (MD5, RC4, etc)
# 5.) little-used ciphers (Camellia, Seed)
ssl_ciphers 'kEECDH+ECDSA+AES128 kEECDH+ECDSA+AES256 kEECDH+AES128 kEECDH+AES256 kEDH+AES128 kEDH+AES256 DES-CBC3-SHA +SHA !aNULL !eNULL !LOW !kECDH !DSS !MD5 !EXP !PSK !SRP !CAMELLIA !SEED';
```

## Generate new dhparams

With Forward Secrecy, if an attacker gets a hold of the server's private key, it will not be able to decrypt past communications. The private key is only used to sign the DH handshake, which does not reveal the pre-master key. Diffie-Hellman ensures that the pre-master keys never leave the client and the server, and cannot be intercepted by a MITM.

All versions of Nginx as of 1.4.4 rely on OpenSSL for input parameters to Diffie-Hellman (DH). Unfortunately, this means that Ephemeral Diffie-Hellman (DHE) will use OpenSSL's defaults, which include a 1024-bit key for the key-exchange. Since we're using a 2048-bit certificate, DHE clients will use a weaker key-exchange than non-ephemeral DH clients.

We need generate a stronger DHE parameter:

```
$ cd /etc/ssl/certs
$ openssl dhparam -out dhparam.pem 4096
```

And then tell Nginx to use it for DHE key-exchange:

```
ssl_dhparam /etc/ssl/certs/dhparam.pem;
```

## Enable HSTS

[HTTP Strict Transport Security (HSTS)](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security) instructs browsers to communicate with your website only over SSL.

```
# Enable HSTS
add_header Strict-Transport-Security 'max-age=63072000; includeSubDomains;'

# Do not allow this site to be displayed in iframes
add_header X-Frame-Options DENY;

# Do not permit Content-Type sniffing.
add_header X-Content-Type-Options nosniff;
```

## Tweaks on performance

### Set up OCSP Stapling

```
# allow Nginx to send OCSP results during the connection process
ssl_stapling on;
```

### Support SSL Session Caching

```
# Cache SSL Sessions for up to 30 minutes
# This improves performance by avoiding the costly session negotiation process where possible
ssl_session_cache builtin:1000 shared:SSL:30m;
# ssl_session_timeout 5m; # this is a default, but can be changed
```