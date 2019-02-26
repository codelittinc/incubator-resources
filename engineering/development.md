# Development tools and resources

## Git

Git is one of the most important tools we use at Codelitt Incubator. It's very likely if you're reading this that you've had some level of exposure to it. Git is very easy to use and has many powerful features under the hood that will make your life much better. 

- **[15 Minute Interactive Intro to Git from Github](https://try.github.io)**
- **[More in-depth look at Git](https://git-scm.com/book/en/v2)**

## Docker

Docker is becoming more and more important every day at Codelitt. All of our deployments rely on Docker and our engineers use it for setting up their environments. Docker and containers reduce the footprint required by virtualization and are a key component to building applications that deploy using continuous delivery techniques. Using the public cloud, teams can exploit Docker technologies to effectively manage continuous delivery pipelines. Docker containers are NOT VMs. They share the kernel with the host. Think of Docker containers as persistent processes and services rather; where you can connect many of them to achieve a desired environment. 

- **[A great intro to Docker](http://blog.scottlowe.org/2014/03/11/a-quick-introduction-to-docker/)**

## Command Line

Command line is a powerful tool and require knowledge for any engineer at Codelitt. Fluency in command line empowers you, improves your workflow, and opens up access to many more tools than without. 

- **[The art of command line](https://github.com/jlevy/the-art-of-command-line)** - As you go through this, Google is your friend. This is not a tutorial, but a laundry list of tools you should know how to use


## Chrome plugins

- [RailsPanel](https://github.com/dejan/rails_panel)

- [React Developer Tools](https://github.com/facebook/react-devtools)

**[jQuery Audit](https://chrome.google.com/webstore/detail/jquery-audit/dhhnpbajdcgdmbbcoakfhmfgmemlncjg)**

- A pretty useful tool for tracking events for DOM elements
- Click on an element and see a list of events and their namespaces
- You can see if you're adding leaks by leaving dangling events after a view closes (please use `listenTo`!)

**[Backbone Debugger](https://github.com/Maluen/Backbone-Debugger)**

- Helpful for checking out your views, routers, models and collections
- Check out which events are triggered for each router
- Inspect views by clicking on [object Object]
- Access view objects via `__backboneAgent.getAppComponentInfoByIndex("View", 0).component` (change View and the index to access different components)

## Great reads

####[The Art of Command Line](https://github.com/jlevy/the-art-of-command-line)

A really great resource for Bash and command line in general. Fluency in the command line is a necessity for any engineer. An engineer will be severely limited and handicapped without it. This article is not just for beginners. It covers some of the more obscure features in bash and command line. 
