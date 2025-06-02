sit_api = {}

default = default or {}
default.player_attached = default.player_attached or {}
default.player_set_animation = default.player_set_animation or function(player, anim, speed)
                                                                    player:set_animation({x=0, y=79}, speed or 30, 0)
                                                                end

function sit_api.sit_player(player, pos, rot, style)
    if not player or not player:is_player() then return end

    local name = player:get_player_name()

    -- Плавно ставим игрока в нужную позицию
    player:set_pos(vector.add(pos or player:get_pos(), {x=0, y=0, z=-0.1}))
    player:set_eye_offset({x = 0, y = 0, z = 2}, {x = 0, y = 0, z = 0})
    player:set_physics_override({speed = 0, jump = 0, gravity = 0})
    default.player_attached[name] = true

    -- Устанавливаем анимацию
    if style == "write" then
        default.player_set_animation(player, "sit", 30)
        -- поднятие руки, если нет отдельной анимации
        player:set_bone_position("Arm_Right", {x = -3, y = 5, z = 0}, {x = -100, y = 0, z = -0})
    else
        default.player_set_animation(player, "sit", 30)
    end
end

function sit_api.unsit_player(player)
    local name = player:get_player_name()
    if not default.player_attached[name] then return end

    player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
    player:set_physics_override({speed=1, jump=1, gravity=1})
    player:set_bone_position("Arm_Right", {x=-3.20,y=5.25,z=0}, {x=180,y=0,z=0}) -- сброс позиции руки
    default.player_attached[name] = false
    default.player_set_animation(player, "stand", 30)
    player:set_detach()
end

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        if default.player_attached[name] then
            local ctrl = player:get_player_control()
            if ctrl.up or ctrl.down or ctrl.left or ctrl.right or ctrl.jump then
                sit_api.unsit_player(player)
            end
        end
    end
end)

minetest.register_chatcommand("handpos", {
    params = "<x> <y> <z> <rot_x> <rot_y> <rot_z>",
    description = "Set right arm bone position and rotation",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local args = {}
        for v in string.gmatch(param, "[^%s]+") do
            local num = tonumber(v)
            if not num then
                return false, "All parameters must be numbers"
            end
            table.insert(args, num)
        end

        if #args ~= 6 then
            return false, "Usage: /handpos x y z rot_x rot_y rot_z"
        end

        local pos = {x = args[1], y = args[2], z = args[3]}
        local rot = {x = args[4], y = args[5], z = args[6]}

        player:set_bone_position("Arm_Right", pos, rot)
        return true, ("Right arm bone set to pos=%.2f,%.2f,%.2f rot=%.2f,%.2f,%.2f"):format(
            pos.x, pos.y, pos.z, rot.x, rot.y, rot.z)
    end,
})

minetest.register_chatcommand("gethandpos", {
    description = "Get right arm bone position and rotation",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local pos, rot = player:get_bone_position("Arm_Right")
        if not pos or not rot then
            return false, "Could not get bone position. Maybe your model or engine doesn't support it."
        end

        return true, ("Right arm bone position: x=%.2f, y=%.2f, z=%.2f; rotation: x=%.2f, y=%.2f, z=%.2f")
        :format(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z)
    end,
})
