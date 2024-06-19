_addon.name = 'NMTracker'
_addon.version = '1.12'
_addon.author = 'Gweivyth - https://github.com/Gweivyth'
_addon.commands = {'nmtracker', 'nmt'}

-- Reqs.
require('logger')
require('chat')
texts = require('texts')

-- Array to store timers.
local timers = {}
-- Array to store the last expired timer. (for //rmt repeat)
local last_expired_timer = nil

-- Welcome message on-load.
local function log_command_syntax()
    log('Welcome to NMTracker! You can use //nmt or //nmtracker for command entry.')
    log('//nmt start <name> <duration_in_seconds> [message] - Start a new timer.')
    log('//nmt delete <name> - Delete an existing timer.')
    log('//nmt repeat - Repeat the last expired timer.')
end

-- On Screen Display.
local display = texts.new({
    pos = {x = 500, y = 100},
    text = {font = 'Arial', size = 12, stroke = {width = 2}},
    bg = {visible = true, alpha = 150},
    flags = {draggable = true},
})

-- Default message if user doesn't define.
local default_message = '%s is about to pop!'

-- Update display.
local function update_display()
    local current_time = os.time()
    local text = 'Active Timers:\n'
    local has_active_timers = false
    for name, timer in pairs(timers) do
        local remaining = timer.end_time - current_time
        text = text .. name .. ': ' .. remaining .. 's\n'
        has_active_timers = true
    end
    display:text(text)
    display:visible(has_active_timers)
end

-- New timer.
local function start_timer(name, duration, message)
    local lower_name = name:lower()
    if timers[lower_name] then
        log('Timer for ' .. name .. ' is already running.')
        return
    end
    
    local end_time = os.time() + duration
    timers[lower_name] = {end_time = end_time, message = message or default_message}
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

-- Repeat the last expired timer.
local function repeat_last_expired_timer()
    if last_expired_timer then
        local name = last_expired_timer.name
        local duration = last_expired_timer.duration
        local message = last_expired_timer.message
        start_timer(name, duration, message)
    else
        log('This command is only to repeat the most recently expired timer.  Use //nmt start to set a timer before using this!')
    end
end

-- Help Command.
local function display_commands()
    log('Available commands:')
    log('//nmt start <name> <duration_in_seconds> [message] - Start a new timer.')
    log('//nmt delete <name> - Delete an existing timer.')
    log('//nmt repeat - Repeat the last expired timer.')
    log('//nmt commands - Display this list of commands.')
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
            log('Usage: //nm start <name> <duration_in_seconds> [message]')
        end
    elseif command:lower() == 'delete' then
        local name = args[1]
        if name then
            delete_timer(name)
        else
            log('Usage: //nm delete <name>')
        end
    elseif command:lower() == 'repeat' then
        repeat_last_expired_timer()
    elseif command:lower() == 'commands' then
        display_commands()
    else
        log('Unknown command. Use //nm commands to see available commands.')
    end
end)

-- Tick timers.
windower.register_event('time change', function(new_time, old_time)
    local current_time = os.time()
    for name, timer in pairs(timers) do
        if current_time >= timer.end_time then
            local message = string.format(timer.message, name)
            windower.send_command('input /p ' .. message)
            log('Timer for ' .. name .. ' has expired! Message sent: ' .. message)
            timers[name] = nil
        end
    end
    update_display()
end)

-- Log messages.
local function log(msg)
    windower.add_to_chat(207, _addon.name .. ': ' .. msg)
end

update_display()
log_command_syntax()
