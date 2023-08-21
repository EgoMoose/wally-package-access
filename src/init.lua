--!strict

local PathCreator = script:WaitForChild("PathCreator")

local function followPath(parent: Instance, path: {string}): Instance
	local found = parent :: Instance
	for i = 1, #path do
		found = found:FindFirstChild(path[i]) :: Instance
	end
	return found
end

local function getPath(parent: Instance, descendant: Instance): {string}
	assert(descendant:IsDescendantOf(parent), `Cannot find path because {descendant.Name} is not a descendant of {parent.Name}`)
	
	local path = {}
	while descendant ~= parent do
		table.insert(path, 1, descendant.Name)
		descendant = descendant.Parent :: Instance
	end
	
	return path
end

local function findContent(packages: Folder, targetModulePath: {string})
	local allWithPath = {}
	local queue = {targetModulePath}
	
	while #queue > 0 do
		local packagesCopy = packages:Clone()
		local packagesCopyIndex = packagesCopy:FindFirstChild("_Index") :: Folder
		
		local path = table.remove(queue) :: {string}
		local found = followPath(packagesCopy, path)
		
		for _, contentParent in packagesCopyIndex:GetChildren() do
			for _, potentialContent in contentParent:GetChildren() do
				if potentialContent ~= found then
					local pathModule = PathCreator:Clone()
					pathModule.Name = potentialContent.Name
					pathModule.Parent = contentParent

					potentialContent:Destroy()
				end
			end
		end
		
		local contentPath = require(found) :: {string}
		local content = followPath(packagesCopy, contentPath)
		local contentParent = content.Parent :: Instance
		
		for _, potentialDependancy in contentParent:GetChildren() do
			if potentialDependancy ~= content then
				table.insert(queue, getPath(packagesCopy, potentialDependancy))
			end
		end
		
		table.insert(allWithPath, {
			name = path[#path],
			path = contentPath,
		})
		
		packagesCopy:Destroy()
	end
	
	local allWithContent = {}
	for i, entry in allWithPath do
		allWithContent[i] = {
			name = entry.name,
			content = followPath(packages, entry.path),
		}
	end
	
	local main = table.remove(allWithContent, 1)
	
	return main, allWithContent
end

local function findAll(packages: Folder)
	local all = {}
	for _, moduleInstance in packages:GetChildren() do
		if moduleInstance:IsA("ModuleScript") and not moduleInstance:GetAttribute("DebugPackage") then
			local main, dependencies = findContent(packages, {moduleInstance.Name})
			
			if main then
				all[moduleInstance.Name] = {
					name = main.name,
					content = main.content,
					dependencies = dependencies,
				}
			end
		end
	end
	return all
end


local packages = script.Parent.Parent.Parent
local all = findAll(packages)

return all