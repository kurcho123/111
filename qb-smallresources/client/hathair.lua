local switched = false
local originalHair = {}

RegisterCommand("hathair", function(source,args)
  local ply = PlayerPedId()
  if not switched then
    originalHair.drawableId = GetPedDrawableVariation(ply, 01)
    originalHair.textureId = GetPedTextureVariation(ply, 2)
    originalHair.paletteId = GetPedPaletteVariation(ply, 2)
    SetPedComponentVariation(ply, 2, -1, 0, 0)
    switched = true
  else
    SetPedComponentVariation(ply, 2, originalHair.drawableId, originalHair.textureId, originalHair.paletteId)
    switched = false
  end
end)