local function printv(str)
  print(vim.inspect(str))
end

-- Split on / character:
--   local parts = utils.split(path, '([^/]+)')
local function split(inputStr, pattern)
  local parts = {}
  for part in string.gmatch(inputStr, pattern) do
    table.insert(parts, part)
  end
  return parts
end

local function splitOnSlash(inputStr)
  return split(inputStr, '([^/]+)')
end

local function smartTruncate(opts, path)
  local pathLength = string.len(path)
  local maxLength = 42
  if pathLength > maxLength then
    local parts = splitOnSlash(path)
    local letters = {}
    for index, value in ipairs(parts) do
      local shifted = {unpack(parts, index+1)}
        local short = table.concat(shifted, '/')
        table.insert(letters, string.sub(value, 1, 1))
        local smartShortPath = table.concat(letters, '/')..'/'..short
        if string.len(smartShortPath) < maxLength then
          return smartShortPath
        end
    end
  end
  return path
end

return {
  split = split,
  printv = printv,
  splitOnSlash = splitOnSlash,
  smartTruncate = smartTruncate,
}
