Your First 10 Minutes on a Server
=========

[My First 5 Minutes on a Server](http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers), by Bryan Kennedy, is an amazing primer into securing a server against most attacks. It is a must read. We have a few modifications to his approach that we wanted to document as part of our efforts of externalizing our processes and best practices. We also wanted to spend a bit more time explaining a few things that newer guys may have to pull Googlefu out for.

I check our logwatch email every morning and thoroughly enjoy watching several hundreds (sometimes 1000s) of attempts at gaining access with little prevail. This general overview works for Debian/Ubuntu servers which are our personal favourite choice. These usually only serve as hosts for docker containers, but principles still apply

On large scale, you'll be better off with a full automated setup using something like [Shipyard](https://shipyard-project.com/) however sometimes you're just creating a single server which is what this is meant to cover. Similar practices can be applied to setting up docker hosts or with deployment/management tools like Chef/Puppet.

####First things first

We don't even have a password for our root user. We'll want to select something random and complex. We use a password manager's password generater set to the most difficult setting. The PW manager saves the password and it is encrypted with access only given by a long master password. A couple of redundancies are provided here (long, complex, random password + password is stored behind encryption/another long password). You'll only need this if you can't SSH in or lose your sudo password. 

`# passwd`

Next you'll need to update the repositories and upgrade your system applying the latest patches. We'll have a section for how to automate security upgrades later on. 

    # apt-get update
    # apt-get upgrade

####Add your user

You should never be logging on to a server as root. We follow a similar convention as Bryan in our user name, but you could use whatever convention you'd like. With a small team, having one login user hasn't been an issue for us, but with a larger team best practice would dictate that different users would be setup with different levels of permission only granting sudo permissions to a select few. 

    useradd deploy
    mkdir /home/deploy
    mkdir /home/deploy/.ssh
    chmod 700 /home/deploy/.ssh 

Remember `chmod 700` means that owner can read, write, execute. We're still root but in a minute we'll recursively `chown` this folder for the deploy user and deploy group. Only this user should have access to do anything with the .ssh folder.

####Require ssh key authentication

We tend to avoid passwords for logging into servers. There was a lot of [discussion](https://news.ycombinator.com/item?id=5316691) around this after Bryan's original guide came out, but I tend to fall into this camp as well. Here are a few notes on this:

1. ssh keys are better than passwords only because they contain and require more information.
2. Passwords can be brute forced. Guessing a public key is so essentially impossible that they can be considered perfectly secure
3. What about a stolen machine? Yes, they have your private key, but expiring an ssh-key is easy, just remove the public key from authorized_keys. You should also have your private key protected by a secure and long passphrase. See next point.
4. All of this works, AS LONG AS YOU HAVE A LONG AND SECURE PASSPHRASE PROTECTING YOUR KEY. Repeated because it's bloody important. 

So let's make password authentication a thing of the past on our server. Copy the contents of your `id_rsa.pub`[^1] on your local machine to your servers authorized keys file. 

    vim /home/deploy/.ssh/authorized_keys

Let's set the right permissions based on the Linux security [principal of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege):

    # chmod 400 /home/deploy/.ssh/authorized_keys
    # chown deploy:deploy /home/deploy -R

`chmod 400` sets permissions so that the file can be read by owner. The second command, `chown` makes the user deploy and group deploy owners (recursively) of their home directory. We referenced this earlier in when setting read/write/execute permissions to owner for this directory.

We're going to come back in a second after we've properly tested our deploy user and sudo to disable logging in as the root user and enforce ssh key logins only. 

####Test `deploy` user and setup sudo

We're going to test logging in as deploy, while keeping our ssh connection as `root` open just in case. If it works, we'll use our open connection as `root` user to set a password for deploy. Since we're disabling password logins, this password will be used when sudo-ing. Again we use a pw manager to create a complex and random password, saving it behind an encrypted wall, and sharing it among the team (syncing the encrypted pw file). 

    passwd deploy


Setting up sudo is simple. Open up the sudo file with:

    visudo 

Add the `deploy` user below the `root` user as shown below. Make sure to comment out any other users and groups with a `#`. Most fresh installs won't have any there, but just make sure. This will give `deploy` access to sudo after entering the password we just created. 

    root    ALL=(ALL) ALL
    deploy  ALL=(ALL) ALL



####Enforce ssh key logins

ssh configuration for the machine is stored here:

    # vim /etc/ssh/sshd_config

You'll want to add these lines to the file. I think they're pretty self-explanatory. You'll want to add the IP that you use to connnect. We have a company VPN setup with OpenVPN with cryptographic authentication so in order to connect to a server, you must also be authenticated and connected to the VPN. 

    PermitRootLogin no
    PasswordAuthentication no
    AllowUsers deploy@(your-VPN-or-static-IP)

Enable all these rules by restarting the ssh service. You'll probably need to reconnect (do so by using your deploy user!) 
    # service ssh restart


####Setting up a firewall

There are usually two camps. Those who use IPtables directly and those who use a handy interface called `ufw` which is a layer on top of IPtables meant to simplify things. Simple is generally better with security. The [DigitalOcean ufw](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server) is really good and goes over the basics.

`ufw` is installed by default on Ubuntu and is just an `apt-get install ufw` away on Debian. 

By default `ufw` should deny all incoming connections and allow all outgoing connections, however, it won't be running (because otherwise how would you be connected?). We'll go through and explicitly allow the connections that we deem okay. 

First we'll want to make sure that we are supporting IPv6. Just open up the config file. 

    $ vim /etc/default/ufw

Set IPv6 to yes. 

    IPV6=yes 

For the rest of the ports that we're going to open up, we can just use the ufw tool from command line which is very handy.

    $ ufw allow from {your-ip} to any port 22
    $ ufw allow 80
    $ ufw allow 443
    $ ufw disable
    $ ufw enable

The first one is a redundancy measure that makes sure that only connections from our IP can connect via SSH (standard SSH port).[^2] While the second and third open up http and https traffic. 



####Automated security updates

####fail2ban

![Banned gif](http://knowyourmeme.com/photos/254517-downvoting-roman-commodus-thumbsdown)

**fail2ban** is a great package that actively blocks suspicious activity as it occurs. From their [wiki](http://www.fail2ban.org/wiki/index.php/Main_Page) Fail2ban scans log files (e.g. `/var/log/apache/error_log`) and bans IPs that show the malicious signs -- too many password failures, seeking for exploits, etc...Out of the box Fail2Ban comes with filters for various services (apache, courier, ssh, etc).

    apt-get install fail2ban


####2 Factor Authentication

2FA

####Logwatch 

This is really more of a simple pleasure and a monitoring tool that helps you see what's going on after the fact. 

------
[^1]: Make sure it's `.pub`. This seems to be very simple, but I've seen two people (both not members of my organization. Quick way to get a pink slip.) in my career, send me their private key (`id_rsa` without the .pub extension) when asking for their public keys. 

[^2]: There's a couple camps on whether to keep your SSH connection on a standard or non-standard port. See [here](https://www.adayinthelifeof.nl/2012/03/12/why-putting-ssh-on-another-port-than-22-is-bad-idea/) and [here](https://major.io/2013/05/14/changing-your-ssh-servers-port-from-the-default-is-it-worth-it/) for opposing sides.
