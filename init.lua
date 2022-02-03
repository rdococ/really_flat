local ground = minetest.CONTENT_UNKNOWN 
local air = minetest.CONTENT_AIR

minetest.register_on_mods_loaded(function ()
	ground = minetest.get_content_id(minetest.settings:get("really_flat_node") or "default:stone") or minetest.CONTENT_UNKNOWN
end)

minetest.register_on_generated(function (minp, maxp, seed)
	local vm = VoxelManip(minp, maxp)
	local va = VoxelArea:new {MinEdge = minp, MaxEdge = maxp}
	
	local data = {}
	
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for y = minp.y, maxp.y do
				local index = va:index(x, y, z)
				data[index] = y <= 0 and ground or air
			end
		end
	end
	
	vm:set_data(data)
	vm:write_to_map()
end)