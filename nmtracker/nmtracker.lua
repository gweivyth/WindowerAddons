_addon.name = 'NMTracker'
_addon.version = '1.17'
_addon.author = 'Gweivyth - https://github.com/Gweivyth'
_addon.commands = {'nmtracker', 'nmt'}

require('logger')
require('chat')
texts = require('texts')

-- Load settings.
settings = {use_minutes = true}
local timers = {}

local function log(msg)
    windower.add_to_chat(207, _addon.name .. ': ' .. msg)
end

local display = texts.new({
    pos = {x = 500, y = 100},
    text = {font = 'Arial', size = 12, stroke = {width = 2}},
    bg = {visible = true, alpha = 150},
    flags = {draggable = true},
})

-- Default message.
local default_message = '%s is about to pop!'

-- Update display.
local function update_display()
    local current_time = os.time()
    local text = 'Current NM Timers:\n'
    local has_active_timers = false
    for name, timer in pairs(timers) do
        local remaining = timer.end_time - current_time
        local display_time = settings.use_minutes and string.format('%02d:%02d', math.floor(remaining / 60), remaining % 60) or string.format('%d s', remaining)
        text = text .. name .. ': ' .. display_time .. '\n'
        has_active_timers = true
    end
    display:text(text)
    display:visible(has_active_timers)
end

-- Convert input based on mode.
local function parse_duration(input_duration)
    local duration = tonumber(input_duration)
    if not duration then
        log('Invalid duration input: ' .. tostring(input_duration))
        return
    end
    if settings.use_minutes then
        return duration * 60
    else
        return duration
    end
end

-- Start a timer.
local function start_timer(name, duration, message)
    local lower_name = name:lower()
    if timers[lower_name] then
        log('Timer for ' .. name .. ' is already running.')
        return
    end

    -- Use default if user doesn't specify.
    if not message or message == "" then
        message = default_message
    end

    local end_time = os.time() + parse_duration(duration)
    timers[lower_name] = {end_time = end_time, message = message}
    log('Started timer for ' .. name .. ' for ' .. duration .. ' seconds.')
    update_display()
end

-- Delete a timer.
local function delete_timer(name)
    local lower_name = name:lower()
    if timers[lower_name] then
        timers[lower_name] = nil
        log('Deleted timer for ' .. name .. '.')
        update_display()
    else
        log('No active timer found for ' .. name .. '.')
    end
end

-- Toggle between MM:SS or :SS only.
local function toggle_time_mode()
    settings.use_minutes = not settings.use_minutes
    log('Display mode switched to: ' .. (settings.use_minutes and 'Minutes.' or 'Seconds.'))
    update_display()
end

-- Command handling.
windower.register_event('addon command', function(command, ...)
    local args = {...}
    if command:lower() == 'start' then
        local name = args[1]
        local duration = tonumber(args[2])
        local message = table.concat({select(3, ...)}, ' ')
        if name and duration then
            start_timer(name, duration, message)
        else
            log('Usage: //nmt start <name> <duration_in_seconds> [message]')
        end
    elseif command:lower() == 'delete' then
        local name = args[1]
        if name then
            delete_timer(name)
        else
            log('Usage: //nmt delete <name>')
        end
    elseif command:lower() == 'toggle' then
        toggle_time_mode()
    else
        log('Unknown command. Use //nmt toggle to switch modes.')
    end
end)

-- Tick timers.
windower.register_event('time change', function(new_time, old_time)
    local current_time = os.time()
    for name, timer in pairs(timers) do
        if current_time >= timer.end_time then
            local message = string.format(timer.message, name)
            windower.send_command('input /p ' .. message)
            timers[name] = nil
        end
    end
    update_display()
end)

update_display()




-- I hate you Bugbear Strongman...
-- Oh yeah, feel free to steal any of this code that you want.  I guess this is normally where people put their licensing info.  I don't care.