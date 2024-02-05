if GetResourceState('qbx_garages') ~= 'started' then return end

Garage = {

  ---@param model string The vehicle model
  getVehicleName = function(model)
    local v = exports.qbx_core:GetVehicleByHash(model)
    return v and v.name or model
  end
}