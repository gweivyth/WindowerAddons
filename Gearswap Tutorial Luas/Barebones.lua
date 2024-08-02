 function get_sets()
 
-- Fashionable stuff.  This doesn't do anything with the current lua but you can keep track of your lockstyle stuff here for now.
   sets.fashion = {
--[[     main            ="Masamune",
    sub             ="Nepenthe Grip",
    ammo            ="Coiste Bodhar", ]]
    head            ="Kasuga Kabuto +3",
    body            ="Nyame Mail",
    hands           ="Wakido Kote +3",
    legs            ="Hiza. Hizayoroi +2",
    feet            ="Kas. Sune-Ate +2",
    neck            ="Sanctity Necklace",
    waist           ={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear        ="Cessance Earring",
    right_ear       ={ name="Kasuga Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
    left_ring       ="Flamma Ring",
    right_ring      ="Warp Ring",
    back            ={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
   }

-- Idle set.
-- The best thing you can do to get your "sets" is to go in-game, equip all the gear you want in your set, then use //gs export.
-- Gearswap will create an export file of all of the gear you're wearing, including all of the augments on it and dump it into a text file.
-- These text files can be found in windower/addons/gearswap/data/export
-- The file name will show up as your character's name followed by a timestamp of the date and time.  You can delete them after you copy your gearset out of it.
-- If you don't want gearswap to swap your weapons around for you so you don't lose TP, you can comment them out or leave those slots out all together.
    sets.idle = {
--[[         ammo        ="Coiste Bodhar", ]]
        head        ="Wakido Kabuto +2",
        body        ="Nyame Mail",
        hands       ="Nyame Gauntlets",
        legs        ="Kasuga Haidate +2",
        feet        ="Nyame Sollerets",
        neck        ="Loricate Torque",
        waist       ={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear    ="Cessance Earring",
        right_ear   ={ name="Kasuga Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
        left_ring   ="Gelatinous Ring",
        right_ring  ="Flamma Ring",
        back        ="Shadow Mantle",
   }

-- TP Engaged.
        sets.engaged = {
--[[         ammo        ="Coiste Bodhar", ]]
        head        ="Kasuga Kabuto +3",
        body        ="Mpaca's Doublet",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +2",
        feet        ="Kas. Sune-Ate +2",
        neck        ="Sanctity Necklace",
        waist       ={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear    ="Cessance Earring",
        right_ear   ={ name="Kasuga Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
        left_ring   ="Ilabrat Ring",
        right_ring  ="Flamma Ring",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }

-- Weapon Skill set.
   sets.ws = {
--[[     ammo            ="Knobkierrie", ]]
    head            ="Mpaca's Cap",
    body            ="Nyame Mail",
    hands           ="Nyame Gauntlets",
    legs            ="Nyame Flanchard",
    feet            ="Kas. Sune-Ate +2",
    neck            ="Sanctity Necklace",
    waist           ="Eschan Stone",
    left_ear        ="Cessance Earring",
    right_ear       ={ name="Kasuga Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
    left_ring       ="Ilabrat Ring",
    right_ring      ="Flamma Ring",
    back            ={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
   }
    
-- Meditate tick set.  This will equip gear that augments your Meditate ability when you use Meditate.
   sets.meditate = {
       head        = "Wakido Kabuto +2",
       hands       = "Sakonji Kote +1"
   }
    
end

-- Equip functions.

-- Idle set.  This equips your idle set when you're not in combat.  You usually want gear that makes you take less damage in this set.  It calls the "Idle" set.
function equip_idle()
    windower.add_to_chat(8,'[Idle]')
   equip(sets.idle)
end

-- Engaged set.  This set is the gear that you will use when you're auto attacking.  You want to put your TP gear here.
function equip_engaged()
   windower.add_to_chat(8,'[Engaged]')
   equip(sets.idle,sets.engaged)
end

-- WS set.  The gear you'll equip when performing a weapon skill.  In a future tutorial I will also add functions to add different sets based on which weapon skill you're using.
function equip_ws()
   windower.add_to_chat(8,'[Weapon Skill]')
   equip(sets.idle,sets.engaged,sets.ws)
end

-- Meditate set.  Calls your meditate augmenting gear when the ability Meditate is used.
function equip_meditate()
   windower.add_to_chat(8,'[Meditate]')
   equip(sets.meditate)
end

-- Use choose_set to figure out whether we are engaged or not.  This allows Gearswap to tell us that we're engaged, so it switches to our "Engaged" set.
function choose_set()
   if player.status == "Engaged" then
       equip_engaged()
   else
        equip_idle()
   end
end

-- Checks for abilities.  This is the function that picks up when we use abilities and tells gearswap to use the appropriate set.
function precast(spell)
    if spell.type == 'WeaponSkill' then
       equip_ws()
   elseif spell.name == 'Meditate' then
       equip_meditate()
   end
end

-- If you're playing a job that casts spells, this is where you'd want to have it equip your "casting" set.
function midcast(spell)
end

-- After an ability, put on engage or idle set.
function aftercast(spell)
    choose_set()
end

-- When we do stuff, make sure we update gear.
function status_change(new,old)
   choose_set()
end

-- Initial Job setup.
-- Sort out consumables.
--  Puts away ninja tools and echo drops, grabs remedies.
-- Relies on the addon "Itemizer" to use these functions.  This is just to sort my bags for me when I swap to this job.
-- Since I don't need ninja tools for this job, I put all of my ninja tools into my mog case.
-- Then I grab things I will need for this job, like remedies and echo drops.
-- The final line stacks up all the items properly within the bags so there aren't loose ones.
send_command('put toolbag (inoshishinofuda) case all');
send_command('put toolbag (shihei) case all');
send_command('put toolbag (shikanofuda) case all');
send_command('put toolbag (chonofuda) case all');
send_command('put chonofuda case all');
send_command('put inoshishinofuda case all');
send_command('put shikanofuda case all');
send_command('wait 1');
send_command('get remedy case all');
send_command('put echo drops case all');
send_command('stack');

-- Lockstyle our gear when we swap jobs.
-- This is how you look cool and keep your character from blinking constantly when you swap gear.
send_command('wait 1;input /lockstyleset 19;')