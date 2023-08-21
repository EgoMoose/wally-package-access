--!strict

local Packages = game.ReplicatedStorage.Packages
local MergeIntoPackages = require(script.MergeIntoPackages) :: any

MergeIntoPackages(script:WaitForChild("WallyPackageAccess"), Packages, "egomoose_wallypackageaccess@test_dev")

local WallyPackageAccess = require(Packages:WaitForChild("WallyPackageAccess")) :: any

print(WallyPackageAccess)