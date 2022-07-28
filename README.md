Provides access to other wally dependencies as instances instead of requiring them

To be clear you probably shouldn't be using this module unless you want some quick and hacky code. I'll give some context on why I decided to write this package anyways...

### The Story

Lately I've been using this [package](https://github.com/sircfenner/StudioComponents). At the time of writing there's no public access to any of the constants. If I want to write a component that builds on top of this package I am unable to to use the same constants as the package. This left me with two options:

1. Make a duplicate of the constants module and put it in my own project.
2. Fork the repository, make the constants public, and publish my own version of the package.

Suffice to say, I wasn't thrilled about doing either.

### This package

This package helps solve that problem b/c it provides a dictionary of all the wally packages in the same folder where the key leads to the package as an instance instead of what's returned by require.

For example,

If my dependencies are:
```
[dependencies]
StudioComponents = "sircfenner/studiocomponents@0.1.1"
WallyPackageAccess = "egomoose/wally-package-access@0.1.1"
```

I could get access to the constants module now by doing the following:

```Lua
local WallyPackageAccess = require(Packages.WallyPackageAccess)
local StudioComponentsModule = WallyPackageAccess.StudioComponents

local Constants = require(StudioComponentsModule.Constants)
```

