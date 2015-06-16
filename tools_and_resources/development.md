# Development tools and resources

## Chrome plugins

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
