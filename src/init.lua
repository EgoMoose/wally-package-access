local PathCreator = script:WaitForChild("PathCreator")

local function generateLookups(packages)
	local packagesCopy = packages:Clone()

	for _, folder in ipairs(packagesCopy._Index:GetChildren()) do
		for _, child in ipairs(folder:GetChildren()) do
			local newChild = PathCreator:Clone()
			newChild.Name = child.Name
			newChild.Parent = folder

			child:Destroy()
		end
	end

	local lookups = {}
	for _, module in ipairs(packagesCopy:GetChildren()) do
		if module:IsA("ModuleScript") then
			local path = require(module)

			if path and path[1] and path[2] then
				local folder = packages._Index:FindFirstChild(path[1])
				local content = folder and folder:FindFirstChild(path[2])

				if content then
					lookups[module.Name] = content
				end
			end
		end
	end

	packagesCopy:Destroy()

	return lookups
end

return generateLookups(script.Parent.Parent.Parent)