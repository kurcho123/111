Logger = { }
Logger.__index = Logger

local _logColors = {
	['Info'] = '7',
	['Error'] = '1',
	['Warning'] = '3',
}

local log = nil
if IsDuplicityVersion() then
	log = function(level, name, message)
		Citizen.Trace('^4['..os.date('%c')..'] ^2['..name..'] ^'.._logColors[level]..'['..level..'] '..tostring(message)..'\n')
	end
else
	log = function(level, name, message)
		Citizen.Trace('['..name..'] ['..level..'] '..tostring(message)..'\n')
	end
end

function Logger.New(name)
	local self = { }
	setmetatable(self, Logger)

	self._name = name

	return self
end

function Logger:info(message)
    if Config.Debug then
        log('Info', self._name, message)
    end
end

function Logger:err(message)
    if Config.Debug then
	    log('Error', self._name, message)
    end
end

function Logger:warn(message)
    if Config.Debug then
        log('Warning', self._name, message)
    end
end
