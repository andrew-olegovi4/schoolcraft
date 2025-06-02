minetest.register_node("school_furniture:table_teacher", {
    description = ("table_teacher"),
	drawtype = 'mesh',
	mesh = 'table_teacher.obj',
    tiles = {"table_teacher.png"},
	groups = {cracky=3,oddly_breakable_by_hand=3,torch=1,not_in_creative_inventory=0},
    selection_box = {type = 'fixed',fixed = {{-1.2, -0.5, -0.5, 1.2, 0.5, 0.3}, }},
	collision_box = {type = 'fixed',fixed = {{-1.2, -0.5, -0.5, 1.2, 0.5, 0.3}, }},

	paramtype = 'light',paramtype2 = 'facedir',
})

minetest.register_craft({output="school_furniture:table_teacher 1",
                         recipe= {{"group:wood","group:wood","group:wood"},
                                  {"default:steel_ingot","","default:steel_ingot"},
                                  {"default:steel_ingot","","default:steel_ingot"},}})


minetest.register_node("school_furniture:student_chair", {
    description = ("student_chair"),
    drawtype = "mesh",
    mesh = "student_chair.obj",
    tiles = {"table_teacher.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    paramtype = "light",
    paramtype2 = "facedir",
    selection_box = {type = "fixed", fixed = {{-0.3, -0.5, -0.4, 0.3, 0.2, 0.2}}},
    collision_box = {type = "fixed", fixed = {{-0.3, -0.5, -0.4, 0.3, 0.2, 0.2}}},

    on_rightclick = function(pos, node, clicker)
        local name = clicker:get_player_name()
        if default.player_attached[name] then
        sit_api.unsit_player(clicker)
        else
            local dir = minetest.facedir_to_dir(node.param2)
            local offset = vector.multiply(dir, -0.3)
            local sit_pos = vector.add(pos, {x = 0, y = 0.2, z = 0})
            sit_pos = vector.add(sit_pos, offset)

            local rot = {x = 0, y = -node.param2 * 90, z = 0}

            -- у ученического стула добавляем стиль "write" — рука на стол
            sit_api.sit_player(clicker, sit_pos, rot, "write")
        end
    end,
})

minetest.register_craft({output="school_furniture:student_chair 1",
                         recipe= {{"group:wood","group:wood","group:wood"},
                                  {"default:steel_ingot","","default:steel_ingot"},
                                  {"","",""},}})

minetest.register_node("school_furniture:teacher_chair", {
    description = ("teacher_chair"),
    drawtype = "mesh",
    mesh = "teacher_chair.obj",
    tiles = {"table_teacher.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    paramtype = "light",
    paramtype2 = "facedir",
    selection_box = {type = "fixed", fixed = {{-0.3, -0.5, -0.4, 0.3, 0.2, 0.2}}},
    collision_box = {type = "fixed", fixed = {{-0.3, -0.5, -0.4, 0.3, 0.2, 0.2}}},

    on_rightclick = function(pos, node, clicker)
        local name = clicker:get_player_name()
        if default.player_attached[name] then
        sit_api.unsit_player(clicker)
        else
            local dir = minetest.facedir_to_dir(node.param2)
            local offset = vector.multiply(dir, -0.3)
            local sit_pos = vector.add(pos, {x = 0, y = 0.2, z = 0})
            sit_pos = vector.add(sit_pos, offset)

            local rot = {x = 0, y = -node.param2 * 90, z = 0}

            -- без руки на столе
            sit_api.sit_player(clicker, sit_pos, rot, "normal")
        end
    end,
})

minetest.register_craft({output="school_furniture:teacher_chair 1",
                         recipe= {{"","","group:wood"},
                                  {"","group:wood","group:wood"},
                                  {"default:steel_ingot","","default:steel_ingot"},}})


minetest.register_node("school_furniture:steel_water_cooler", {    
    description = ("steel_water_cooler"),
	drawtype = 'mesh',
	mesh = 'steel_water_cooler.obj',
    tiles = {"steel_water_cooler.png"},
	groups = {cracky=3,oddly_breakable_by_hand=3,torch=1,not_in_creative_inventory=0},
    selection_box = {type = 'fixed',fixed = {{-0.3, -0.5, -0.3, 0.3, 0.7, 0.3}, }},
	collision_box = {type = 'fixed',fixed = {{-0.3, -0.5, -0.3, 0.3, 0.7, 0.3}, }},

	paramtype = 'light',paramtype2 = 'facedir',
})

minetest.register_craft({output="school_furniture:steel_water_cooler 1",
                         recipe= {{"default:steel_ingot","school_furniture:iron_faucet","default:steel_ingot"},
                                  {"default:steel_ingot","","default:steel_ingot"},
                                  {"default:steel_ingot","default:steel_ingot","default:steel_ingot"},}})

minetest.register_craftitem("school_furniture:iron_faucet", {
	description = ("iron_faucet"),
	inventory_image = "iron_faucet.png",
	stack_max = 1,
})

minetest.register_craft({output="school_furniture:iron_faucet 1",
                         recipe= {{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
                                  {"default:steel_ingot","","default:steel_ingot"},
                                  {"default:steel_ingot","",""},}})

local numbers = {
    {name = "0", texture = "edunumber_0.png"},
    {name = "1", texture = "edunumber_1.png"},
    {name = "2", texture = "edunumber_2.png"},
    {name = "3", texture = "edunumber_3.png"},
    {name = "4", texture = "edunumber_4.png"},
    {name = "5", texture = "edunumber_5.png"},
    {name = "6", texture = "edunumber_6.png"},
    {name = "7", texture = "edunumber_7.png"},
    {name = "8", texture = "edunumber_8.png"},
    {name = "9", texture = "edunumber_9.png"},
    {name = "add", texture = "edunumber_add.png", description = "Плюс"},
    {name = "decimalcomma", texture = "edunumber_decimalcomma.png", description = "Запятая"},
    {name = "decimaldot", texture = "edunumber_decimaldot.png", description = "Точка"},
    {name = "divide", texture = "edunumber_divide.png", description = "Деление"},
    {name = "equals", texture = "edunumber_equals.png", description = "Равно"},
    {name = "lessthan", texture = "edunumber_lessthan.png", description = "Меньше"},
    {name = "multiply", texture = "edunumber_multiply.png", description = "Умножение"},
    {name = "greaterthan", texture = "edunumber_over.png", description = "Больше"},
    {name = "percentage", texture = "edunumber_percentage.png", description = "Процент"},
    {name = "pi", texture = "edunumber_pi.png", description = "Пи"},
    {name = "subtract", texture = "edunumber_subtract.png", description = "Минус"}
}

for _, num in ipairs(numbers) do
    minetest.register_node("school_furniture:number_"..num.name, {
        description = num.description or "Цифра "..num.name,
        tiles = {num.texture.."^[transformR180"},
        inventory_image = num.texture,
        wield_image = num.texture.."^[resize:16x16",
        wield_scale = {x=1, y=1, z=1},
        paramtype = "light",
        paramtype2 = 'wallmounted',
        sunlight_propagates = true,
        walkable = false,
        drawtype = "nodebox",
        node_box = {
            type = 'wallmounted',
            wall_top    = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
            wall_bottom = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
            wall_side   = {0.49, -0.5, -0.49, 0.5, 0.5, 0.5}
            -- wall_side   = {0.49, -0.5, -0.5, 0.5, 0.5, 0.5},
        },
        groups = {dig_immediate = 3, not_in_creative_inventory = 0},
        selection_box = {
            type = 'wallmounted',
            wall_top    = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
            wall_bottom = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
            wall_side   = {0.49, -0.5, -0.49, 0.5, 0.5, 0.5},
            -- wall_side = {-0.5, -0.5, 0.46875, 0.5, 0.5, 0.5},
        },
        on_place = function(itemstack, placer, pointed_thing)
            if not pointed_thing or pointed_thing.type ~= "node" then
                return itemstack -- Не на что ставить
            end

            local under = pointed_thing.under
            local above = pointed_thing.above
            local dir = vector.subtract(above, under)

            local wdir = minetest.dir_to_wallmounted(dir)

            -- ЗАПРЕТ НА УСТАНОВКУ НА ПОЛ И ПОТОЛОК
            if wdir == 0 or wdir == 1 then
                local message = "Можно ставить только на стены!"
                if wdir == 0 then
                    message = "Нельзя ставить на пол! Только на стены."
                elseif wdir == 1 then
                    message = "Нельзя ставить на потолок! Только на стены."
                end

                if placer and placer:is_player() then
                    minetest.chat_send_player(placer:get_player_name(), message)
                end
                return itemstack -- Возвращаем предмет, не размещая его
            end

            -- Размещаем нод, если это стена
            minetest.add_node(above, {name = "school_furniture:number_"..num.name, param2 = wdir})

            if not placer or not placer:is_player() or not minetest.is_creative_enabled(placer:get_player_name()) then
                itemstack:take_item()
            end
            return itemstack
        end
    })
    end


-- Глобальная таблица для хранения текстов досок
blackboard_texts = {}

minetest.register_node("school_furniture:blackboard", {
    description = "Доска (ПКМ для редактирования)",
    drawtype = 'mesh',
    mesh = 'blackboard.obj',
    tiles = {"table_teacher.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 3, not_in_creative_inventory = 0},
    paramtype = 'light',
    paramtype2 = 'facedir',

    selection_box = {
        type = 'fixed',
        fixed = {{-2.4, -0.4, -0.1, 2.6, 1.2, 0.2}}
    },
    collision_box = {
        type = 'fixed',
        fixed = {{-2.4, -0.4, -0.1, 2.6, 1.2, 0.2}}
    },

    after_place_node = function(pos, placer)
        local pos_key = minetest.pos_to_string(pos)
        local initial_text = "Нажмите ПКМ для написания текста"
        blackboard_texts[pos_key] = initial_text

        local meta = minetest.get_meta(pos)
        meta:set_string("text", initial_text)
        meta:set_string("infotext", initial_text)

        minetest.log("action", "[Доска] Инициализирована новая доска на "..pos_key)

        save_blackboard_data()  -- сохраняем сразу после установки новой доски
    end,

    on_place = function(itemstack, placer, pointed_thing)
        if not pointed_thing or pointed_thing.type ~= "node" then
            return itemstack
        end

        local pos = pointed_thing.above
        local look_dir = placer:get_look_dir()
        local param2 = minetest.dir_to_facedir(look_dir)

        -- Поворачиваем доску к игроку
        param2 = (param2 + 2) % 4

        minetest.set_node(pos, {name = "school_furniture:blackboard", param2 = param2})

        local meta = minetest.get_meta(pos)
        local initial_text = "Нажмите ПКМ для написания текста"
        meta:set_string("text", initial_text)
        meta:set_string("infotext", initial_text)
        blackboard_texts[minetest.pos_to_string(pos)] = initial_text

        save_blackboard_data()

        if not minetest.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,

    on_rightclick = function(pos, node, clicker, itemstack)
        if not clicker or not clicker:is_player() then return itemstack end

        local meta = minetest.get_meta(pos)
        local current_text = meta:get_string("text") or "Нажмите ПКМ для написания текста"

        minetest.chat_send_player(clicker:get_player_name(), "[Доска] формспек вызван на "..minetest.pos_to_string(pos)..": "..current_text)

        minetest.show_formspec(
            clicker:get_player_name(),
            "school_furniture:blackboard_edit_"..minetest.pos_to_string(pos),
            "size[8,5]"..
            "label[0.5,0.5;Текст на доске:]"..
            "textarea[0.5,1;7,3;text;;"..minetest.formspec_escape(current_text).."]"..
            "button_exit[3,4.5;2,0.5;save;Сохранить]"
        )
        return itemstack
    end,

--     on_receive_fields = function(pos, formname, fields, sender)
--         if not formname then
--             minetest.chat_send_player(sender:get_player_name(), "[Доска] formname отсутствует")
--             return
--         end
--
--         if not formname:find("^school_furniture:blackboard_edit_") then
--             minetest.chat_send_player(sender:get_player_name(), "[Доска] форма не подходит: "..tostring(formname))
--             return
--         end
--
--         if not sender or not sender:is_player() then
--             minetest.chat_send_player(sender:get_player_name(), "[Доска] sender отсутствует или не игрок")
--             return
--         end
--
--         if fields.quit or fields.save then
--             local text = fields.text or ""
--             local pos_key = minetest.pos_to_string(pos)
--
--             text = string.sub(text, 1, 500)  -- ограничение длины
--
--             blackboard_texts[pos_key] = text
--             local meta = minetest.get_meta(pos)
--             meta:set_string("text", text)
--             meta:set_string("infotext", text)
--
--             minetest.chat_send_player(sender:get_player_name(), "[Доска] Текст сохранён на "..pos_key..": "..text)
--
--             save_blackboard_data()
--         end
--     end,

    on_punch = function(pos, node, puncher)
        if not puncher or not puncher:is_player() then return end

        local meta = minetest.get_meta(pos)
        local text = meta:get_string("text") or "Нет текста"
        minetest.chat_send_player(puncher:get_player_name(), "Текст на доске: "..text)
    end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if not formname:find("^school_furniture:blackboard_edit_") then
        return
    end

    local pos_str = formname:sub(string.len("school_furniture:blackboard_edit_") + 1)
    local pos = minetest.string_to_pos(pos_str)
    if not pos then return end

    if fields.save or fields.quit then
        local text = fields.text or ""
        text = string.sub(text, 1, 500)

        blackboard_texts[minetest.pos_to_string(pos)] = text
        local meta = minetest.get_meta(pos)
        meta:set_string("text", text)
        meta:set_string("infotext", text)

        minetest.log("action", "[Доска] Текст сохранён на "..minetest.pos_to_string(pos)..": "..text)
        minetest.chat_send_player(player:get_player_name(), "[Доска] Текст сохранён")
        save_blackboard_data()
    end
end)

-- Функция сохранения данных в файл
function save_blackboard_data()
    local save_data = minetest.serialize(blackboard_texts)
    minetest.safe_file_write(minetest.get_worldpath().."/blackboard_data.txt", save_data)
    minetest.log("action", "[Доска] Данные сохранены")
end

-- Функция загрузки данных с восстановлением метаданных
local function load_blackboard_data()
    local file = io.open(minetest.get_worldpath().."/blackboard_data.txt", "r")
    if file then
        local data = file:read("*a")
        file:close()
        if data and data ~= "" then
            blackboard_texts = minetest.deserialize(data) or {}
            minetest.log("action", "[Доска] Загружено "..table_size(blackboard_texts).." записей досок")

            for pos_key, text in pairs(blackboard_texts) do
                local pos = minetest.string_to_pos(pos_key)
                if pos then
                    local node = minetest.get_node_or_nil(pos)
                    if node and node.name == "school_furniture:blackboard" then
                        local meta = minetest.get_meta(pos)
                        meta:set_string("text", text)
                        meta:set_string("infotext", text)
                    end
                end
            end
        end
    else
        minetest.log("action", "[Доска] Файл данных не найден, будет создан новый")
    end
end

minetest.after(0, load_blackboard_data)

-- Помощь: считать количество записей в таблице
function table_size(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- Сохраняем данные при выходе (дополнительно)
minetest.register_on_shutdown(save_blackboard_data)
