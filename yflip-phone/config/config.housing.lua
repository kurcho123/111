Config = Config or {}

Config.Housing = "qb-houses"
--[[
    The housing script you use.
    If yours is not supported you can follow these steps to integrate it.
    1. Rename the `your_housing.lua` file in both `(client/server)\apps\framework\home` with the name of your housing script. ex: qb-houses.lua.
    2. Check `client\apps\framework\home\home.lua` what is the expected property object. (array of properties)
    3. Implement the functions according to your housing. You can use the `qb-houses.lua` as an example.
    4. Change `Config.Housing` to the name of your housing script.
    5. If you want open a ticket and contribute the integration so other people can use it as well.
    Supported:
        * qb-houses - https://github.com/qbcore-framework/qb-houses
        * ps-housing - https://github.com/Project-Sloth/ps-housing
        * flight-housing - https://forum.cfx.re/t/qb-esx-custom-flight-housing/5056323
        * bcs_housing - https://masbagus.tebex.io/package/5090952
        * nolag_properties - https://store.nolag.dev/package/5734217
]]
