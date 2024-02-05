Submix = {}

function Submix:new(name, output)
    self.__index = self

    local submix = CreateAudioSubmix(name)
    AddAudioSubmixOutput(submix, output)

    local left = 1.0
    local right = 1.0

    return setmetatable({submix = submix, output = output}, self)
end

function Submix:setEffectParamInt(param, value)
    SetAudioSubmixEffectParamInt(self.submix, self.output, GetHashKey(param), value)
end

function Submix:setEffectParamFloat(param, value)
    SetAudioSubmixEffectParamFloat(self.submix, self.output, GetHashKey(param), value)
end

function Submix:setEffectRadioFx()
    SetAudioSubmixEffectRadioFx(self.submix, self.output)
end

function Submix:storeBalance(left, right)
    self.left = left
    self.right = right

    self:setBalance(self.left, self.right)
end

function Submix:setBalance(left, right)
    SetAudioSubmixOutputVolumes(self.submix, 0, left, right, left, right, left, right)
end

function Submix:resetBalance()
    self:setBalance(self.left, self.right)
end

function Submix:connect(serverId)
    MumbleSetSubmixForServerId(serverId, self.submix)
end
