_addon.name = 'NMTracker'
_addon.version = '1.15'
_addon.author = 'Gweivyth - https://github.com/Gweivyth'
_addon.commands = {'nmtracker', 'nmt'}

-- Required libraries.
require('logger')
require('chat')
require('config')
texts = require('texts')

-- Default settings.
local settings = config.load({
    use_minutes = false,}) -- Defaults to seconds.
local timers = {}
local last_expired_timer = nil
local use_minutes = settings.use_minutes

-- Welcome message on load.
local function log_command_syntax()
    log('Welcome to NMTracker! Use //nmt or //nmtracker for commands.')
    log('Commands:')
    log('//nmt start <name> <duration> [message] - Start a new timer.')
    log('//nmt delete <name> - Delete an existing timer.')
    log('//nmt repeat - Repeat the last expired timer.')
    log('//nmt toggle - Toggle duration input between seconds and minutes.')
    log('//nmt commands - Display this command list.')
    log('Current mode: ' .. (use_minutes and 'Minutes' or 'Seconds'))
end

-- On Screen Display setup.
local display = texts.new({
    pos = {x = 500, y = 100},
    text = {font = 'Verdana', size = 12, stroke = {width = 2}},
    bg = {visible = true, alpha = 150},
    flags = {draggable = true},
})

-- Use MM:SS in on-screen display.
local function update_display()
    local current_time = os.time()
    local text = 'Notorious Monster Timers (MM:SS):\n'
    local has_active_timers = false

    for name, timer in pairs(timers) do
        local remaining = timer.end_time - current_time
        if remaining > 0 then
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60
            text = text .. string.format('%s: %02d:%02d\n', name, minutes, seconds)
            has_active_timers = true
        end
    end

    display:text(text)
    display:visible(has_active_timers)
end

-- Start a new timer.
local function start_timer(name, duration, message)
    local lower_name = name:lower()
    if timers[lower_name] then
        log('Timer for ' .. name .. ' is already running.')
        return
    end

    -- Convert duration to seconds if using minutes.
    if use_minutes then
        duration = duration * 60
    end

    local end_time = os.time() + duration
    timers[lower_name] = {end_time = end_time, message = message or default_message, duration = duration}
    log('Started timer for ' .. name .. ' for ' .. (use_minutes and (duration / 60) .. ' minutes.' or duration .. ' seconds.'))
    update_display()
end

-- Delete an active timer.
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
        start_timer(last_expired_timer.name, last_expired_timer.duration / (use_minutes and 60 or 1), last_expired_timer.message)
    else
        log('No expired timer to repeat. Use //nmt start to create a timer first.')
    end
end

-- Toggle between minutes and seconds.
local function toggle_input_mode()
    use_minutes = not use_minutes
    settings.use_minutes = use_minutes -- Update settings.
    config.save(settings) -- Save the updated settings.
    log('Duration input mode toggled to: ' .. (use_minutes and 'Minutes' or 'Seconds'))
end

-- Help Command.
local function display_commands()
    log('Available commands:')
    log('//nmt start <name> <duration> [message] - Start a new timer.')
    log('//nmt delete <name> - Delete an existing timer.')
    log('//nmt repeat - Repeat the last expired timer.')
    log('//nmt toggle - Toggle duration input between seconds and minutes.')
    log('//nmt commands - Display this list of commands.')
end

-- Command handling.
windower.register_event('addon command', function(command, ...)
    local args = {...}
    command = command and command:lower() or ''

    if command == 'start' then
        local name = args[1]
        local duration = tonumber(args[2])
        local message = table.concat({select(3, ...)}, ' ')
        if name and duration then
            start_timer(name, duration, message)
        else
            log('Usage: //nmt start <name> <duration> [message]')
        end
    elseif command == 'delete' then
        local name = args[1]
        if name then
            delete_timer(name)
        else
            log('Usage: //nmt delete <name>')
        end
    elseif command == 'repeat' then
        repeat_last_expired_timer()
    elseif command == 'toggle' then
        toggle_input_mode()
    elseif command == 'commands' then
        display_commands()
    else
        log('Unknown command. Use //nmt commands to see available commands.')
    end
end)

-- Tick timers.
windower.register_event('time change', function()
    local current_time = os.time()

    for name, timer in pairs(timers) do
        if current_time >= timer.end_time then
            local message = string.format(timer.message, name)
            windower.send_command('input /p ' .. message)
            log('Timer for ' .. name .. ' has expired! Message sent: ' .. message)

            -- Store as last expired timer.
            last_expired_timer = {name = name, duration = timer.duration, message = timer.message}
            timers[name] = nil
        end
    end
    update_display()
end)

-- Log messages.
local function log(msg)
    windower.add_to_chat(207, _addon.name .. ': ' .. msg)
end

-- Instructions on load.
update_display()
log_command_syntax()
