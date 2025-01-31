function ListDirectory(directory)
    -- Open a pipe to the 'ls' command to list the files in the directory
    local p = io.popen('ls "' .. directory .. '"')
    if p == nil then return {} end
    local files = {}
    for file in p:lines() do table.insert(files, file) end
    p:close()
    return files
end

function LoadImageSafely(filename)
    local info = love.filesystem.getInfo(filename)

    if info then
        return love.graphics.newImage(filename)
    else
        local errorStr = string.format("Error: Image file %s does not exists",
                                       filename)
        print(errorStr)
        return nil
    end
end
