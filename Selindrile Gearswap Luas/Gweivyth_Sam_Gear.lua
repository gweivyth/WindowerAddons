-- Setup vars that are user-dependent.
function user_job_setup()
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
    state.RangedMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal')
	state.Weapons:options('Freestyle','Masamune','Dojikiri','ShiningOne','Norifusa')

	gear.ws_jse_back = {name="Smertrios's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.stp_jse_back = {name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    -- Additional local binds
	send_command('bind !@^` gs c cycle Stance')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote +3",back=gear.ws_jse_back}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +3"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +3"}
	
    sets.precast.Step = { }
    sets.precast.JA['Violent Flourish'] = { }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = { }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",hands="Leyline Gloves"}
	   
    -- Ranged snapshot gear
    sets.precast.RA = {}
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Nyame Mail",
        hands="Kasuga Kote +3",
        legs="Nyame Flanchard",
        feet="Kas. Sune-Ate +3",
        neck="Samurai's Nodowa +2",
        waist="Eschan Stone",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Cornelia's Ring",
        right_ring="Karieyh Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
       }

    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {feet="Wakido Sune. +3"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {head="Wakido Kabuto +3",body="Sakonji Domaru +3",feet="Wakido Sune. +3"})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {head="Wakido Kabuto +3",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",body="Sakonji Domaru +3",hands="Wakido Kote +3",ring1="Ramuh Ring +1",feet="Wakido Sune. +3"})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Proc = { }
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Tachi: Mumei'] = set_combine(sets.precast.WS, {waist="Sailfi Belt +1"})
    
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {waist="Sailfi Belt +1"})
    sets.precast.WS['Tachi: Fudo'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {head="Nyame helm",body="Nyame Mail",hands="Nyame Gauntlets",legs="Nyame Flanchard",feet="Nyame Sollerets",right_ear="Frimosi Earring",left_ear="Moonshade Earring",waist="Eschan Stone"})
    sets.precast.WS['Tachi: Jinpu'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Jinpu'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Jinpu'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Jinpu'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Thrud Earring",
        right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
        left_ring="Cornelia's Ring",
        right_ring="Mephitas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
    }
    sets.precast.WS['Aeolian Edge'].SomeAcc = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Thrud Earring",
        right_ear="Frimosi Earring",
        left_ring="Cornelia's Ring",
        right_ring="Mephitas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
    }
    sets.precast.WS['Aeolian Edge'].Acc = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Thrud Earring",
        right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
        left_ring="Cornelia's Ring",
        right_ring="Mephitas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
    }
    sets.precast.WS['Aeolian Edge'].FullAcc = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Thrud Earring",
        right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
        left_ring="Cornelia's Ring",
        right_ring="Mephitas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
    }
    sets.precast.WS['Aeolian Edge'].Fodder = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Thrud Earring",
        right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
        left_ring="Cornelia's Ring",
        right_ring="Mephitas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Shoha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Kasha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Gekko'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Yukikaze'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {waist="Sailfi Belt +1"})
    sets.precast.WS['Impulse Drive'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Impulse Drive'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Impulse Drive'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {waist="Sailfi Belt +1", ring1="Metamorph Ring", ring2="Cornelia's Ring"})
    sets.precast.WS['Tachi: Ageha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {waist="Sailfi Belt +1", ring1="Metamorph Ring", ring2="Cornelia's Ring"})
    sets.precast.WS['Tachi: Ageha'].Acc = set_combine(sets.precast.WS.Acc, {waist="Sailfi Belt +1", ring1="Metamorph Ring", ring2="Cornelia's Ring"})
    sets.precast.WS['Tachi: Ageha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {waist="Sailfi Belt +1", ring1="Metamorph Ring", ring2="Cornelia's Ring"})
    sets.precast.WS['Tachi: Ageha'].Fodder = set_combine(sets.precast.WS.Fodder, {waist="Sailfi Belt +1", ring1="Metamorph Ring", ring2="Cornelia's Ring"})
		
    sets.precast.WS['Tachi: Hobaku'] = set_combine(sets.precast.WS, {waist="Eschan Stone"})
    sets.precast.WS['Tachi: Hobaku'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {waist="Eschan Stone"})
    sets.precast.WS['Tachi: Hobaku'].Acc = set_combine(sets.precast.WS.Acc, {waist="Eschan Stone"})
    sets.precast.WS['Tachi: Hobaku'].FullAcc = set_combine(sets.precast.WS.FullAcc, {waist="Eschan Stone"})
    sets.precast.WS['Tachi: Hobaku'].Fodder = set_combine(sets.precast.WS.Fodder, {waist="Eschan Stone"})
		
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs="Nyame Flanchard",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear={ name="Kasuga Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
        left_ring="Cornelia's Ring",
        right_ring="Metamorph Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
    })
    
    if state.Weapons.value == "Dojikiri" then
        sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {
            legs="Kasuga Haidate +3"
        })
    end
    
    sets.precast.WS['Tachi: Jinpu'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Jinpu'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Jinpu'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Jinpu'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    -- Use these earrings instead of TP is 3000.
	sets.MaxTP = {left_ear="Kasuga Earring +1", right_ear="Thrud Earring"}
	sets.AccMaxTP = {left_ear="Kasuga Earring +1", right_ear="Thrud Earring"}
	sets.AccDayMaxTPWSEars = {left_ear="Kasuga Earring +1", right_ear="Thrud Earring"}
	sets.DayMaxTPWSEars = {left_ear="Kasuga Earring +1", right_ear="Thrud Earring"}
	sets.AccDayWSEars = {left_ear="Kasuga Earring +1", right_ear="Thrud Earring"}
	sets.DayWSEars = {left_ear="Kasuga Earring +1", right_ear="Thrud Earring"}
	
    -- Midcast Sets
    sets.midcast.FastRecast = { }
		
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, { })
	
		
    -- Ranged gear
    sets.midcast.RA = { }

    sets.midcast.RA.Acc = { }

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        neck="Sanctity Necklace",
        right_ear="Infused Earring",
        body="Hiza. Haramaki +2",
        right_ring="Chirich Ring +1"
       }
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Town = {    ammo="Coiste Bodhar",
    head="Wakido Kabuto +3",
    body="Kasuga Domaru +3",
    hands="Wakido Kote +3",
    legs="Kasuga Haidate +3",
    feet="Kas. Sune-Ate +3",
    neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear="Schere Earring",
    right_ear="Cessance Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Chirich Ring +1",
    back={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", ammo="Perfect Lucky Egg"})
	sets.Skillchain = {}
	
    sets.idle = {
        head        ="Wakido Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ="Kas. Sune-Ate +3",
        neck        ="Loricate Torque",
        waist       ="Platinum Moogle Belt",
        left_ear    ="Infused Earring",
        right_ear   ="Dawn Earring",
        left_ring   ="Gelatinous Ring +1",
        right_ring  ="Chirich Ring +1",
        back        ="Shadow Mantle",
   }
		
    sets.idle.Weak = {
        head        ="Wakido Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ="Danzo Sune-ate",
        neck        ="Loricate Torque",
        waist       ="Platinum Moogle Belt",
        left_ear    ="Infused Earring",
        right_ear   ="Dawn Earring",
        left_ring   ="Gelatinous Ring +1",
        right_ring  ="Chirich Ring +1",
        back        ="Shadow Mantle",
   }
		
	sets.DayIdle = {left_ear="Dawn Earring", right_ear="Infused Earring"}
	sets.NightIdle = {left_ear="Intruder Earring", right_ear="Infused Earring"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Nyame Mail",hands="Wakido Kote +3",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonlight Cape",waist="Ioskeha Belt",legs="Wakido Haidate +3",feet="Nyame Sollerets"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.defense.MEVA = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Sailfi Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }

    -- Used by adjust_for_status to swap gear that you want to have equipped specifically under Hasso or Seigan.
    -- Uses the base sets.engaged set and replaces the specified items below dynamically.
    sets.engaged.Hasso = {
    hands       ="Wakido Kote +3",
    legs        ="Kasuga Haidate +3",
}

    sets.engaged.Seigan = {
    hands       ="Mpaca's Gloves",
    legs        ="Mpaca's Hose",
}

-- Don't use Schere Earring if we're subbed DRK, we need that mana.
function customize_melee_set(meleeSet)
    if player.sub_job == 'DRK' or player.sub_job == 'RUN' then
        meleeSet.right_ear = "Mache Earring +1"
-- Tell Gearswap that if we aren't subbed one of the above sub jobs that it needs to keep Schere Earring on.
    else
        meleeSet.right_ear = "Schere Earring"
    end

    return meleeSet
end

-- Overrides for equipment sets depending on our weapon mode.
function adjust_for_weapon(meleeSet)
    -- What weapon do we have on?
    if state.Weapons.value == "Masamune" then
        meleeSet = set_combine(meleeSet, sets.engaged.Masamune)
    elseif state.Weapons.value == "Dojikiri" then
        meleeSet = set_combine(meleeSet, sets.engaged.Dojikiri)
    elseif state.Weapons.value == "ShiningOne" then
        meleeSet = set_combine(meleeSet, sets.engaged.ShiningOne)
    elseif state.Weapons.value == "Norifusa" then
        meleeSet = set_combine(meleeSet, sets.engaged.Norifusa)
    else
        -- Error handling for freestyle mode.
        meleeSet = meleeSet
    end

    return meleeSet
end

-- Engage swaps for weapon detection function.
    sets.engaged.Masamune = {

}

    sets.engaged.Dojikiri = {

}

    sets.engaged.ShiningOne = {

}

    sets.engaged.Norifusa = {
        head = "Mpaca's Cap",
        body = "Mpaca's Doublet",
        hands = "Mpaca's Gloves",
        legs = "Mpaca's Hose",
        feet = "Mpaca's Boots",
        waist = "Tempus Fugit",
        ring1 = "Flamma Ring",
        ring2 = "Chirich Ring +1",
        right_ear = "Kasuga Earring +1",
        left_ear = "Dignitary's Earring",

}

-- This function will adjust your engaged gearset depending on whether you're in Hasso or Seigan.
function adjust_for_status(meleeSet)
    -- Figure out which stance we're in.
    if buffactive['Hasso'] then
        meleeSet = set_combine(meleeSet, sets.engaged.Hasso)
    elseif buffactive['Seigan'] then
        meleeSet = set_combine(meleeSet, sets.engaged.Seigan)
    else
        -- Error handling - if we're in neither stance tell Gearswap to just use the base engaged set.  This prevents errors.
        meleeSet = meleeSet
    end

    return meleeSet
end

-- Use pre/midcast logic to dynamically pull info to make informed decisions regarding our engaged set.
function job_handle_equipping_gear(playerStatus, eventArgs)
    if playerStatus == 'Engaged' then
        local adjustedSet = sets.engaged

        -- Check weapon mode, apply logic.
        adjustedSet = adjust_for_weapon(adjustedSet)
        
        -- Hasso/Seigan logic detection.
        adjustedSet = adjust_for_status(adjustedSet)
        
        -- Subjob specific logic detection.
        adjustedSet = customize_melee_set(adjustedSet)
        
        -- Do the thing.
        equip(adjustedSet)
        eventArgs.handled = true
    end
end

-- Wrap it up.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        equip(customize_melee_set(sets.engaged))
    end
end

    sets.engaged.SomeAcc = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.Acc = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.FullAcc = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.Fodder = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.PDT = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.SomeAcc.PDT = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.Acc.PDT = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.FullAcc.PDT = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.Fodder.PDT = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
	sets.engaged.DTLite = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.SomeAcc.DTLite = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.Acc.DTLite = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.FullAcc.DTLite = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }
    sets.engaged.Fodder.DTLite = {
        ammo        ="Coiste Bodhar",
        head        ="Kasuga Kabuto +3",
        body        ="Kasuga Domaru +3",
        hands       ="Wakido Kote +3",
        legs        ="Kasuga Haidate +3",
        feet        ={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck        ="Samurai's Nodowa +2",
        waist       ="Windbuffet Belt +1",
        left_ear    ="Cessance Earring",
        right_ear   ="Schere Earring",
        left_ring   ="Niqmaddu Ring",
        right_ring  ="Chirich Ring +1",
        back        ={ name="Smertrios's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
   }

	-- Weapons sets
    sets.weapons.Freestyle = { }
    sets.weapons.Masamune = {main="Masamune",sub="Utu Grip"}
	sets.weapons.Dojikiri = {main="Dojikiri Yasutsuna",sub="Utu Grip"}
    sets.weapons.ShiningOne = {main="Shining One",sub="Utu Grip"}
    sets.weapons.Norifusa = {main="Norifusa +1",sub="Utu Grip"}
	
	-- Buff sets
	sets.Cure_Received = {legs="Flamma Dirs +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
    sets.buff.Sekkanoki = {hands="Kasuga Kote +3"}
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +3"}
    sets.buff['Meikyo Shisui'] = { }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
        send_command('wait 1;input /lockstyleset 2;')
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 2)
        send_command('wait 1;input /lockstyleset 1;')
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 2)
        send_command('wait 1;input /lockstyleset 1;')
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 2)
        send_command('wait 1;input /lockstyleset 1;')
    elseif player.sub_job == 'DRG' then
        set_macro_page(1, 2)
        send_command('wait 1;input /lockstyleset 1;')
    else
        set_macro_page(1, 2)
        send_command('wait 1;input /lockstyleset 1;')
    end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end