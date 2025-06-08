-- Debug
-- Thanks to hookenz on SO for this one.
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function get_file_extension(str)
	local pos = (str:reverse()):find("%.")
	local pos2 = (str:reverse()):find("/")
	if pos == nil then
		return ""
	elseif pos2 == nil or pos > pos2 then
		return ""
	end
	return str:sub(-pos+1, -1)
end

function get_file_name(str)
	if str == nil then
		return ""
	end
	local pos = (str:reverse()):find("/")
	if pos == nil then
		return str
	end
	return str:sub(-pos+1, -1)
end

function get_file_path(str)
	if str == nil then
		return ""
	end
	local pos = (str:reverse()):find("/")
	if pos == nil then
		return str
	end
	return str:sub(1,-pos)
end

function merge_into(a,b)
	for k,v in pairs(a) do
		a[k] = v
	end
end

function includes(table, entry)
	for k, v in pairs(table) do
		--print(v.." =? "..entry)
		if v == entry then
			return true
		end
	end
	return false
end

return {}
