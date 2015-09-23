-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc


require('global_values')
require('internal/util')
require('gamemode')
require('popups')
  
function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
  --PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
  --PrecacheResource("particle_folder", "particles/test_particle", context)

  -- Models can also be precached by folder or individually
  -- PrecacheModel should generally used over PrecacheResource for individual models
  --PrecacheResource("particle_folder", "particles/heroes/", context)
  --PrecacheModel("models/props_structure/good_barracks_melee001.vmdl", context)
  --PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
  --PrecacheModel("models/heroes/viper/viper.vmdl", context)
--  PrecacheResource("model_folder", "models/heroes/", context)

  -- Sounds can precached here like anything else
  --PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  --PrecacheItemByNameSync("example_ability", context)
  --PrecacheItemByNameSync("item_example_item", context)

  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  --PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
  --PrecacheUnitByNameSync("npc_dota_hero_enigma", context)

  --General precache--

  PrecacheResource(particle, "particles/units/heroes/hero_bristleback/bristleback_quill_spray_ring_dust.vpcf", context)
  PrecacheResource(particle, "particles/econ/courier/courier_trail_international_2013/courier_international_2013.vpcf", context)
  PrecacheResource(soundevents, "soundevents/game_sounds_creeps.vsndevts", context)

  --race 2 precache-- (humans)
  PrecacheUnitByNameSync("race_2_king", context)
  PrecacheUnitByNameSync("race_2_building_placer", context)
  PrecacheUnitByNameSync("race_2_tower_placer", context)
  PrecacheUnitByNameSync("race_2_tower_1", context)
  PrecacheUnitByNameSync("race_2_melee_tier_1_footman", context) 
  PrecacheUnitByNameSync("race_2_special_tier_1_healer", context) 
  PrecacheUnitByNameSync("race_2_range_tier_1_mortar", context) 
  PrecacheUnitByNameSync("race_2_barracks", context)
  PrecacheUnitByNameSync("race_2_melee_building_1", context)
  PrecacheUnitByNameSync("race_2_range_building_1", context)
  PrecacheUnitByNameSync("race_2_special_building_1", context)
  PrecacheUnitByNameSync("race_2_melee_tier_2_footman", context) 
  PrecacheUnitByNameSync("race_2_special_tier_2_healer", context) 
  PrecacheUnitByNameSync("race_2_range_tier_2_mortar", context) 



  --race 3 precache-- (outlands)
  PrecacheUnitByNameSync("race_3_king", context)
  PrecacheUnitByNameSync("race_3_building_placer", context)
  PrecacheUnitByNameSync("race_3_tower_placer", context)
  PrecacheUnitByNameSync("race_3_tower_1", context)
  PrecacheUnitByNameSync("race_3_melee_tier_1_footman", context) 
  PrecacheUnitByNameSync("race_3_range_tier_1_hexer", context) 
  PrecacheUnitByNameSync("race_3_special_tier_1_shaman", context) 
  PrecacheUnitByNameSync("race_3_barracks", context)
  PrecacheUnitByNameSync("race_3_melee_building_1", context)
  PrecacheUnitByNameSync("race_3_range_building_1", context)
  PrecacheUnitByNameSync("race_3_special_building_1", context)
  PrecacheUnitByNameSync("race_3_melee_tier_2_footman", context) 
  PrecacheUnitByNameSync("race_3_range_tier_2_hexer", context) 
  PrecacheUnitByNameSync("race_3_special_tier_2_shaman", context) 

  --race 6 precache -- (undeads)
  PrecacheUnitByNameSync("race_6_king", context)
  PrecacheUnitByNameSync("race_6_building_placer", context)
  PrecacheUnitByNameSync("race_6_tower_placer", context)
  PrecacheUnitByNameSync("race_6_tower_1", context)
  PrecacheUnitByNameSync("race_6_melee_tier_1_footman", context) 
  PrecacheUnitByNameSync("race_6_range_tier_1_viper", context) 
  PrecacheUnitByNameSync("race_6_special_tier_1_succubus", context) 
  PrecacheUnitByNameSync("race_6_barracks", context)
  PrecacheUnitByNameSync("race_6_melee_building_1", context)
  PrecacheUnitByNameSync("race_6_range_building_1", context)
  PrecacheUnitByNameSync("race_6_special_building_1", context)
  PrecacheUnitByNameSync("race_6_melee_tier_2_footman", context) 
  PrecacheUnitByNameSync("race_6_range_tier_2_viper", context) 
  PrecacheUnitByNameSync("race_6_special_tier_2_succubus", context) 


  -- race 7 precache -- (smallfolk)
  PrecacheUnitByNameSync("race_7_king", context)
  PrecacheUnitByNameSync("race_7_building_placer", context)
  PrecacheUnitByNameSync("race_7_tower_placer", context)
  PrecacheUnitByNameSync("race_7_tower_1", context)
  PrecacheUnitByNameSync("race_7_melee_tier_1_footman", context) 
  PrecacheUnitByNameSync("race_7_range_tier_1_sniper", context) 
  PrecacheUnitByNameSync("race_7_special_tier_1_morph", context) 
  PrecacheUnitByNameSync("race_7_barracks", context)
  PrecacheUnitByNameSync("race_7_melee_building_1", context)
  PrecacheUnitByNameSync("race_7_range_building_1", context)
  PrecacheUnitByNameSync("race_7_special_building_1", context)
  PrecacheUnitByNameSync("race_7_melee_tier_2_footman", context) 
  PrecacheUnitByNameSync("race_7_range_tier_2_sniper", context) 
  PrecacheUnitByNameSync("race_7_special_tier_2_morph", context) 

 --race 8 precache -- (guardians of nature)
 PrecacheUnitByNameSync("race_8_king", context)
 PrecacheUnitByNameSync("race_8_building_placer", context)
 PrecacheUnitByNameSync("race_8_tower_placer", context)
 PrecacheUnitByNameSync("race_8_tower_1", context)
 PrecacheUnitByNameSync("race_8_melee_tier_1_footman", context) 
 PrecacheUnitByNameSync("race_8_range_tier_1_runner", context) 
 PrecacheUnitByNameSync("race_8_special_tier_1_tree", context) 
 PrecacheUnitByNameSync("race_8_barracks", context)
 PrecacheUnitByNameSync("race_8_melee_building_1", context)
 PrecacheUnitByNameSync("race_8_range_building_1", context)
 PrecacheUnitByNameSync("race_8_special_building_1", context)
 PrecacheUnitByNameSync("race_8_melee_tier_2_footman", context) 
 PrecacheUnitByNameSync("race_8_range_tier_2_runner", context) 
 PrecacheUnitByNameSync("race_8_special_tier_2_tree", context) 

end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
end
