local prototype_name = "starter-infinity-chest"

local function is_starter_chest(entity)
  return entity and entity.valid and entity.name == prototype_name
end

script.on_event(defines.events.on_player_created, function(event)
  if not remote.interfaces["freeplay"] then
    return
  end

  local player = game.get_player(event.player_index)
  if player then
    player.insert({name = prototype_name, count = 1})
  end
end)

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
