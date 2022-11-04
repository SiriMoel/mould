dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "mould"
mod_settings_version = 1 
mod_settings = {
	{
		id = "name",
		ui_name = "Player Name",
		ui_description = "Self explanatory.",
		value_default = "Kaksijalkaa",
		text_max_length = 20,
		scope = MOD_SETTING_SCOPE_RUNTIME,
		change_fn = mod_setting_change_callback,
	},
	{
		id = "difficulty",
		ui_name = "Difficulty",
		ui_description = "How \"fun\" you want your experience to be. Must be set at the beginning of a run.\n Sunlight. (cringe) (only for weak gamers)\n Twilight. (normal difficulty)\n Midnight. (skillful)\n Abyssal. (now i am become death) (some special item drops)",
		value_default = "normal",
		values = { {"easy","Sunlight"}, {"normal","Twilight"}, {"hard","Midnight"}, {"expert", "Abyssal"} },
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end


function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end