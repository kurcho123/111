if GetResourceState('es_extended') ~= 'started' then return end

Garage = {

  ---@param hash number The vehicle model hash
  getVehicleName = function(hash)
    local name = GetDisplayNameFromVehicleModel(tonumber(hash))

    return name == 'CARNOTFOUND' and hash or name
  end
}