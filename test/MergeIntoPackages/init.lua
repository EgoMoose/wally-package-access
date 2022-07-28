return function(moduleToMerge, packages, folderName)
	local folder = Instance.new("Folder")
	folder.Name = folderName
	folder.Parent = packages._Index

	local forwarder = script.Forwarder:Clone()
	forwarder:SetAttribute("Path", folderName .. "/" .. moduleToMerge.Name)
	forwarder.Name = moduleToMerge.Name
	forwarder.Parent = packages

	moduleToMerge:Clone().Parent = folder
end