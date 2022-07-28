local path = script:GetAttribute("Path"):split("/")

return require(script.Parent._Index[path[1]][path[2]])