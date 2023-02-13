local function notify(message)
    local status_ok, n = pcall(require, 'notify')
    if not status_ok then
        return
    end
    n(message, 'error', {
        title = 'Settings',
        timeout = 2000,
    })
end

local function getprefix(filename)
    return string.format('[%s]', filename)
end

local function saferequire(modname, filename, pop)
    local status_ok, mod = pcall(require, modname)
    local isNotify = pop == nil and true or false

    if not status_ok then
        if isNotify and filename then
            notify(getprefix(filename) .. ' Unable to load ' .. modname)
        end
        return nil
    end
    return mod
end

return saferequire
