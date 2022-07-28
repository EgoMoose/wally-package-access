local MergeIntoPackages = require(script.MergeIntoPackages)
local WallyPackageAccess = script:WaitForChild("WallyPackageAccess")
local Packages = game.ReplicatedStorage.Packages

MergeIntoPackages(WallyPackageAccess, Packages, "egomoose_wallypackageaccess@test_dev")

print(require(Packages.WallyPackageAccess))