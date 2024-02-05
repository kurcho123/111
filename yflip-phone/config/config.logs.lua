Config = Config or {}

Config.Logs = {}         -- The webhook that will be used to send the posts to the discord channel.
Config.Logs.Timeout = 60 -- The amount of time in seconds that the logs will be queued before being sent to the discord channel.
Config.Logs.Webhooks = {
    ['instashots'] = 'https://discord.com/api/webhooks/1197821443925348352/sXLnHhnRibPCUg4tmmRP-6mV8hipqoXQlM6lgCx5Z_pVrzCWcQTGeNpdZMjqdqi8Tv0P',
    ['y'] = 'https://discord.com/api/webhooks/1197821604885966878/GLdvs458FnWfVsuuZmVqBo8kShKKO9iiPOU7AK1WaU7eUQDUu3XWjdJfM4tGujs_LIaU',
    ['ypay'] = 'https://discord.com/api/webhooks/1197821678357585972/I89lnB6LNCBBM-UwJecYV8Rk-Cd8Cdn1RRT8dJUaLBAnZFWFgmQ4W4GjkBPIyWtcwkf1',
    ['ybuy'] = 'https://discord.com/api/webhooks/1197821787317223514/LLD-m3iR7bm6asM0L9L_kYrNAhVpLnAUG49m0-S_QBL04uafBxEQEPrtZ-xw0sXFskYM'

}
Config.Logs.Avatars = {
    ['instashots'] =
    'https://cdn.discordapp.com/attachments/1096003897270751292/1185616123547361331/instashots.png?ex=6590420f&is=657dcd0f&hm=b09d8e7d9553a44f314069c3846413b560b05faf9eb8accff6ca2164fe5b9c69&',
    ['y'] =
    'https://cdn.discordapp.com/attachments/1096003897270751292/1185616124147142797/y.png?ex=6590420f&is=657dcd0f&hm=ce8d1072a0b0f35569669fa1600c9d056b7aa7b519c281efe7cf16c0ed9e5087&',
    ['ypay'] =
    'https://cdn.discordapp.com/attachments/1096003897270751292/1185690680312483850/ypay.png?ex=6590877f&is=657e127f&hm=7b2b2792f173435f4a2852ba2590fa5a4f03d8b7041d5ff4761f942c0b038520&',
    ['ybuy'] =
    'https://cdn.discordapp.com/attachments/1096003897270751292/1191304598141542530/ybuy.png?ex=65a4f3dd&is=65927edd&hm=be54b480c32e968913236924a54e6305313b8e1a8cf8fe444992dd9af749b21b&'
}

Config.Logs.Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 1940464,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
    ['instashots'] = 15884387,
    ['y'] = 1940464,
    ['ypay'] = 431319,
    ['ybuy'] = 15020857
}
