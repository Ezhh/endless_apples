
-- override default apple
minetest.override_item("default:apple", {
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			minetest.set_node(pos, {name = "endless_apples:apple_mark"})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end
	end,
})

-- air node to mark apple pos
minetest.register_node("endless_apples:apple_mark", {
	description = "Air!",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_timer = function(pos, elapsed)
		if not minetest.find_node_near(pos, 1, "default:leaves") then
			minetest.remove_node(pos)
		elseif minetest.get_node_light(pos) < 13 then
			minetest.get_node_timer(pos):start(200)
		else 
			minetest.set_node(pos, {name = "default:apple"})
		end
	end
})
