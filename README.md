Provides access to other wally dependencies as instances instead of requiring them

### Example

If my dependencies are:
```
[dependencies]
Knit = "sleitnick/knit@1.5.1"
StudioComponents = "sircfenner/studiocomponents@0.1.1"
WallyPackageAccess = "egomoose/wally-package-access@0.1.1"
```

I could get access to the contents of these packages by doing the following:

```Lua
type DependencyContent = {
	name: string,
	content: Instance,
}

type WallyPackageAccess = {
	packages: Folder,
	contents = {
		[string]: {
			name: string,
			content: Instance,
			dependencies: {DependencyContent}
		}
	},
}

local WallyPackageAccess = require(Packages.WallyPackageAccess)
local Knit = WallyPackageAccess.contents.Knit.content
```

