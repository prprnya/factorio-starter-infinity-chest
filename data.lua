local util = require("util")

local prototype_name = "starter-infinity-chest"

local source_entity = data.raw["infinity-container"]["infinity-chest"]
local source_item = data.raw.item["infinity-chest"]

local entity = util.table.deepcopy(source_entity)
entity.name = prototype_name
entity.gui_mode = "all"
entity.hidden = true
entity.minable = {
  mining_time = source_entity.minable and source_entity.minable.mining_time or 0.1,
  result = prototype_name
}

local item = util.table.deepcopy(source_item)
item.name = prototype_name
item.hidden = true
item.place_result = prototype_name
item.stack_size = 1

data:extend({entity, item})
