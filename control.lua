local prototype_name = "starter-infinity-chest"

local function is_starter_chest(entity)
  return entity and entity.valid and entity.name == prototype_name
end

local function register_freeplay_starting_item()
  local freeplay = remote.interfaces["freeplay"]
  if not freeplay or not freeplay.get_created_items or not freeplay.set_created_items then
    return
  end

  local created_items = remote.call("freeplay", "get_created_items")
  created_items[prototype_name] = 1
  remote.call("freeplay", "set_created_items", created_items)
end

script.on_init(register_freeplay_starting_item)
script.on_configuration_changed(register_freeplay_starting_item)

script.on_event(defines.events.on_gui_opened, function(event)
  if is_starter_chest(event.entity) then
    -- It may be freely mined and moved until its first use. Once opened,
    -- prevent mining or deconstruction from returning another usable copy.
    event.entity.minable_flag = false
  end
end)

script.on_event(defines.events.on_gui_closed, function(event)
  if is_starter_chest(event.entity) then
    event.entity.destroy()
  end
end)
