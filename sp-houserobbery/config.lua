Config = Config or {}

local StringCharset = {}
local NumberCharset = {}

Config.ZOffSet = 42.0

Config.HouseRewards = {
  [1] = { item = 'screwdriverset', amount = 1, chance = 15 },
  [2] = { item = 'advancedlockpick', amount = math.random(1,2), chance = 25 },
  [3] = { item = 'samsungphone', amount = 1, chance = 27 },
  [4] = { item = '10kgoldchain', amount = 1, chance = 27 },
  [5] = { item = 'plastic', amount = math.random(3,6), chance = 15 },
  [5] = { item = 'metalscrap', amount = math.random(6,9), chance = 25 },
  [6] = { item = 'rolex', amount = 1, chance = 30 },
  [7] = { item = 'tablet', amount = 1, chance = 30 },
  [8] = { item = 'iphone', amount = 1, chance = 33},
  [9] = { item = 'rubber', amount = math.random(1,2), chance = 20},
  [10] = { item = 'fitbit', amount = 1, chance = 20},
  [11] = { item = 'laptop', amount = 1, chance = 10}, 
  [12] = { item = 'advancedrepairkit', amount = 1, chance = 10}, 
  [13] = { item = 'maleseed', amount = math.random(1,3), chance = 25}, 
  [14] = { item = 'sns_handle', amount = 1, chance = 3}, 
  [15] = { item = 'sns_barrel', amount = 1, chance = 3}, 
}

Config.HouseRewardsReputation = {
  [1] = { item = 'screwdriverset', amount = 1, chance = 15 },
  [2] = { item = 'advancedlockpick', amount = math.random(1,2), chance = 25 },
  [3] = { item = 'samsungphone', amount = 1, chance = 27 },
  [4] = { item = '10kgoldchain', amount = 1, chance = 27 },
  [5] = { item = 'plastic', amount = math.random(3,6), chance = 15 },
  [5] = { item = 'metalscrap', amount = math.random(6,9), chance = 25 },
  [6] = { item = 'rolex', amount = 1, chance = 30 },
  [7] = { item = 'tablet', amount = 1, chance = 30 },
  [8] = { item = 'iphone', amount = 1, chance = 33},
  [9] = { item = 'rubber', amount = math.random(1,2), chance = 20},
  [10] = { item = 'fitbit', amount = 1, chance = 20},
  [11] = { item = 'laptop', amount = 1, chance = 10}, 
  [12] = { item = 'advancedrepairkit', amount = 1, chance = 10}, 
  [13] = { item = 'sandwich', amount = math.random(1,3), chance = 25}, 
  [14] = { item = 'sns_body', amount = 1, chance = 5}, 
  [15] = { item = 'sns_accessories', amount = 1, chance = 5}, 
  [16] = { item = 'weedkey', amount = 1, chance = 2}, 
}


Config.CopsNeeded = 4
Config.EnableOpeningHours = false -- Enable opening hours?
Config.MinimumTime = 21 -- From what hour should the pawnshop be open?
Config.MaximumTime = 7 -- From what hour should the pawnshop be closed?
Config.HouseLocations = {
  [1] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = -302.13,
      ['Y'] = 6326.95,
      ['Z'] = 32.89,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = -303.94,
          ['Y'] = 6315.27,
          ['Z'] = -5.64 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = -309.13,
          ['Y'] = 6325.26,
          ['Z'] = -2.40 -1,
        }  
      },
      [3] = {
        ['Stolen'] = false,
        ['Item'] = 'microwave',
        ['PropName'] = 'prop_micro_01',
        ['Coords'] = {
          ['X'] = 505.40936,
          ['Y'] = -1827.917,
          ['Z'] = -10.98015,
        }
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = -309.97,
         ['Y'] = 6327.54,
         ['Z'] = -7.09 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = -299.51,
        ['Y'] = 6330.83,
        ['Z'] = -6.69 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -291.24,
          ['Y'] = 6331.78,
          ['Z'] = -6.71 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -297.49,
          ['Y'] = 6324.67,
          ['Z'] = -2.46 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -307.71,
          ['Y'] = 6324.52,
          ['Z'] = -2.45 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -300.73,
          ['Y'] = 6315.41,
          ['Z'] = -2.62 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -305.82,
          ['Y'] = 6328.34,
          ['Z'] = -2.62 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -305.95,
          ['Y'] = 6319.33,
          ['Z'] = -2.91 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -306.96,
          ['Y'] = 6315.25,
          ['Z'] = -2.90 -1,
        },
      },
    },
  },
  [2] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] =  -191.434,
      ['Y'] = -2.38,
      ['Z'] = 52.37,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = -192.58,
          ['Y'] = -14.09,
          ['Z'] = 13.47 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = -198.57,
          ['Y'] = -4.11,
          ['Z'] = 17.08 -1
        }  
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = -199.33,
         ['Y'] = -1.91,
         ['Z'] = 12.27 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = -188.88,
        ['Y'] = 1.67,
        ['Z'] = 12.52 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -190.06,
          ['Y'] = -13.96,
          ['Z'] = 16.88 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -196.91,
          ['Y'] = -4.86,
          ['Z'] = 16.98 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -186.76,
          ['Y'] = -4.81,
          ['Z'] = 17.10 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -195.92,
          ['Y'] = 1.98,
          ['Z'] = 16.84 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -188.97,
          ['Y'] = -7.55,
          ['Z'] = 17.06 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -194.89,
          ['Y'] = -1.06,
          ['Z'] = 16.88 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -185.89,
          ['Y'] = 3.22,
          ['Z'] = 12.80 -1,
        },
      },
    },
  },
  [3] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = -371.63,
      ['Y'] = 343.35,
      ['Z'] = 109.94,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = -373.08,
          ['Y'] = 331.65,
          ['Z'] = 71.34 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = -378.72,
          ['Y'] = 341.62,
          ['Z'] = 74.58 -1,
        }  
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = -379.40,
         ['Y'] =  343.93,
         ['Z'] = 70.05 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = -375.18,
        ['Y'] = 344.62,
        ['Z'] = 74.45 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -376.11,
          ['Y'] = 347.28,
          ['Z'] = 74.42 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -377.03,
          ['Y'] = 341.09,
          ['Z'] = 74.54 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -375.54,
          ['Y'] = 335.89,
          ['Z'] = 74.11 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -376.44,
          ['Y'] = 331.71,
          ['Z'] = 74.12 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -370.18,
          ['Y'] = 331.69,
          ['Z'] = 74.45 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -360.87,
          ['Y'] = 347.97,
          ['Z'] = 70.39 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -366.03,
          ['Y'] = 348.78,
          ['Z'] = 70.41 -1,
        },
      },
    },
  },
  [4] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = -355.89,
      ['Y'] = 469.73,
      ['Z'] = 112.65,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = -357.41,
          ['Y'] = 458.02,
          ['Z'] = 74.05 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = -363.03,
          ['Y'] = 468.05,
          ['Z'] = 77.35 -1,
        }  
      },
      [3] = {
        ['Stolen'] = false,
        ['Item'] = 'microwave',
        ['PropName'] = 'prop_micro_01',
        ['Coords'] = {
          ['X'] = 505.40936,
          ['Y'] = -1827.917,
          ['Z'] = -10.98015,
        }
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = -366.03,
         ['Y'] = 348.78,
         ['Z'] = 70.41 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = -353.44,
        ['Y'] = 473.71,
        ['Z'] = 73.07 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -351.08,
          ['Y'] = 467.51,
          ['Z'] = 77.29 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -361.47,
          ['Y'] = 467.43,
          ['Z'] = 77.34 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -359.70,
          ['Y'] = 462.18,
          ['Z'] = 76.88 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -360.73,
          ['Y'] = 458.06,
          ['Z'] = 76.83 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -354.49,
          ['Y'] = 458.19,
          ['Z'] = 77.16 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -353.42,
          ['Y'] = 464.75,
          ['Z'] = 77.37 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -360.34,
          ['Y'] = 474.01,
          ['Z'] = 77.16 -1,
        },
      },
    },
  },
  [5] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = -305.07,
      ['Y'] = 430.97,
      ['Z'] = 110.48,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = -306.64,
          ['Y'] = 419.23,
          ['Z'] = 71.69 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = -312.08,
          ['Y'] = 429.27,
          ['Z'] = 75.13 -1,
        }  
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = -312.92,
         ['Y'] = 431.60,
         ['Z'] = 70.54 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = -302.63,
        ['Y'] = 434.89,
        ['Z'] = 70.90 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -294.33,
          ['Y'] = 435.56,
          ['Z'] = 70.92 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -310.49,
          ['Y'] = 428.65,
          ['Z'] = 75.15 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -300.36,
          ['Y'] = 428.68,
          ['Z'] = 75.11 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -309.92,
          ['Y'] = 419.27,
          ['Z'] = 74.65 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -308.99,
          ['Y'] = 423.42,
          ['Z'] = 74.67 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -303.72,
          ['Y'] = 419.21,
          ['Z'] = 74.93 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = -873.3132,
          ['Y'] = 425.73,
          ['Z'] = 75.12 -1,
        },
      },
    },
  },
  [6] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = 840.82,
      ['Y'] = -182.20,
      ['Z'] = 74.59,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = 839.13,
          ['Y'] = -193.93,
          ['Z'] = 36.01 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = 833.77,
          ['Y'] = -183.95,
          ['Z'] = 39.21 -1,
        }  
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = 832.96,
         ['Y'] = -181.62,
         ['Z'] = 34.57 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = 843.38,
        ['Y'] = -178.36,
        ['Z'] = 35.01 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 851.56,
          ['Y'] = -177.66,
          ['Z'] = 35.02 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 837.19,
          ['Y'] = -180.97,
          ['Z'] = 39.10 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 835.25,
          ['Y'] = -184.26,
          ['Z'] = 39.31 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 845.55,
          ['Y'] = -184.47,
          ['Z'] = 39.27 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 837.11,
          ['Y'] = -189.71,
          ['Z'] = 38.79 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 835.97,
          ['Y'] = -193.90,
          ['Z'] = 38.74 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 842.22,
          ['Y'] = -193.79,
          ['Z'] = 39.10 -1,
        },
      },
    },
  },
  [7] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = 886.86,
      ['Y'] = -608.23,
      ['Z'] = 58.45,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = 885.06,
          ['Y'] = -619.95,
          ['Z'] = 19.85 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = 879.81,
          ['Y'] = -609.95,
          ['Z'] = 23.04 -1,
        }  
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = 886.86,
         ['Y'] = -608.23,
         ['Z'] = 58.45 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = 889.40,
        ['Y'] = -604.18,
        ['Z'] = 18.84 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 897.59,
          ['Y'] = -603.59,
          ['Z'] = 18.90 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 891.45,
          ['Y'] = -610.51,
          ['Z'] = 23.14 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 881.33,
          ['Y'] = -610.43,
          ['Z'] = 23.15 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 883.18,
          ['Y'] = -606.83,
          ['Z'] = 22.94 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 882.33,
          ['Y'] = -603.74,
          ['Z'] = 22.99 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 882.84,
          ['Y'] = -615.95,
          ['Z'] = 22.66 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 888.23,
          ['Y'] = -619.83,
          ['Z'] = 22.96 -1,
        },
      },
    },
  },
  [8] = {
    ['Label'] = 'House',
    ['Opened'] = false,
    ['Tier'] = 3,
    ['Coords'] = {
      ['X'] = 1803.56,
      ['Y'] = 3913.95,
      ['Z'] = 37.06,
    },
    ['Extras'] = {
      [1] = {
        ['Stolen'] = false,
        ['Item'] = 'bigtv',
        ['PropName'] = 'apa_mp_h_str_avunits_01',
        ['Coords'] = {
          ['X'] = 1801.81,
          ['Y'] = 3902.22,
          ['Z'] = -1.73 -1,
        }
      },
      [2] = {
        ['Stolen'] = false,
        ['Item'] = 'computer',
        ['PropName'] = 'prop_laptop_01a',
        ['Coords'] = {
          ['X'] = 1796.55,
          ['Y'] = 3912.19,
          ['Z'] = 1.77 -1,
        }  
      },
      [3] = {
        ['Stolen'] = false,
        ['Item'] = 'microwave',
        ['PropName'] = 'prop_micro_01',
        ['Coords'] = {
          ['X'] = 505.40936,
          ['Y'] = -1827.917,
          ['Z'] = -10.98015,
        }
      },
    },
    ['Lockers'] = {
      [1] = {
       ['Busy'] = false,
       ['Opened'] = false,
       ['Coords'] = {
         ['X'] = 1795.43,
         ['Y'] = 3914.58,
         ['Z'] = -2.88 -1,
       },
     },
     [2] = {
      ['Busy'] = false,
      ['Opened'] = false,
      ['Coords'] = {
        ['X'] = 1806.16,
        ['Y'] = 3917.94,
        ['Z'] = -2.45 -1,
      },
      },
      [3] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1814.33,
          ['Y'] = 3918.54,
          ['Z'] = -2.45 -1,
        },
      },
      [4] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1808.21,
          ['Y'] = 3911.64,
          ['Z'] = 1.70 -1,
        },
      },
      [5] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1798.09,
          ['Y'] = 3911.71,
          ['Z'] = 1.65 -1,
        },
      },
      [6] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1799.92,
          ['Y'] = 3915.20,
          ['Z'] = 1.54 -1,
        },
      },
      [7] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1804.97,
          ['Y'] = 3902.39,
          ['Z'] = 1.57 -1,
        },
      },
      [8] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1806.29,
          ['Y'] = 3908.55,
          ['Z'] = 1.76 -1,
        },
      },
      [9] = {
        ['Busy'] = false,
        ['Opened'] = false,
        ['Coords'] = {
          ['X'] = 1798.69,
          ['Y'] = 3902.34,
          ['Z'] = 1.26 -1,
        },
      },
    },
  }
}

Config.ReputationHouses = {
  [1] = { -- Mid Tier Houses (Medium Sized)
    ['ReputationNeeded'] = 0,
    ['RequiredPlayers'] = 3,
    ['ReputationGives'] = 20,

    ['Locations'] = {
      [1] = {
        ['Label'] = 'Reputation House (Mid Tier) 1',
        ['CanEnter'] = false,
        ['CanHackGenerator'] = false,
        ['TokisLocations'] = {
          [1] = {
            ['HacksAmount'] = 1,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-1200.64, -1024.99, 2.15),
          },
          [2] = {
            ['HacksAmount'] = 1,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-1193.58, -1027.56, 2.15),
          },
        },
        ['MainGenerator'] = {
          ['HacksAmount'] = 3,
          ['HacksDone'] = 0,
          ['IsBeingHacked'] = false,
          ['IsHacked'] = false,
          ['Coords'] = vector3(-1202.85, -1029.65, 2.15),
        },
        ['Tier'] = 2,
        ['Coords'] = vector3(-1200.48, -1031.86, 2.15),
        ['CoordsTable'] = {
          ['x'] = -1200.48,
          ['y'] = -1031.86,
          ['z'] = 2.15
        },
        ['ExitCoords'] = vector3(-1210.92, -1029.24, -38.69),
        ['Extras'] = {
          [1] = {
            ['Stolen'] = false,
            ['Item'] = 'computer',
            ['PropName'] = 'prop_laptop_01a',
            ['Coords'] = {
              ['X'] = -1208.32,
              ['Y'] = -1033.39,
              ['Z'] = -34.10
            }  
          },
          [2] = {
            ['Stolen'] = false,
            ['Item'] = 'bigtv',
            ['PropName'] = 'apa_mp_h_str_avunits_01',
            ['Coords'] = {
              ['X'] = -1201.92,
              ['Y'] = -1042.90,
              ['Z'] = -38.01,
            }
          },
        },
        ['Lockers'] = {
          [1] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1208.27,
              ['Y'] = -1030.72,
              ['Z'] = -38.68
            },  
          },
          [2] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1197.26,
              ['Y'] = -1027.91,
              ['Z'] = -38.24
            },  
          },
          [3] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1190.62,
              ['Y'] = -1026.96,
              ['Z'] = -38.24
            },  
          },
          [4] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1201.01,
              ['Y'] = -1033.89,
              ['Z'] = -38.01
            }, 
          },
          [5] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1204.84,
              ['Y'] = -1041.31,
              ['Z'] = -38.01
            },  
          },
          [6] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1196.31,
              ['Y'] = -1034.14,
              ['Z'] = -34.10
            },  
          },
          [7] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1199.11,
              ['Y'] = -1042.76,
              ['Z'] = -34.10
            },   
          },
          [8] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1207.15,
              ['Y'] = -1036.51,
              ['Z'] = -34.10
            },   
          },
          [9] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1209.90,  
              ['Y'] = -1026.89,
              ['Z'] = -34.10
            },
          },
        },
      },
    }
  },
  [2] = { -- Mid Tier Houses (Medium Sized)
    ['ReputationNeeded'] = 50,
    ['RequiredPlayers'] = 3,
    ['ReputationGives'] = 20,

    ['Locations'] = {
      [1] = {
        ['Label'] = 'Reputation House (Mid Tier) 1',
        ['CanEnter'] = false,
        ['CanHackGenerator'] = false,
        ['TokisLocations'] = {
          [1] = {
            ['HacksAmount'] = 2,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-668.40, 904.09, 230.92),
          },
          [2] = {
            ['HacksAmount'] = 2,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-680.16, 907.89, 230.80),
          },
        },
        ['MainGenerator'] = {
          ['HacksAmount'] = 3,
          ['HacksDone'] = 0,
          ['IsBeingHacked'] = false,
          ['IsHacked'] = false,
          ['Coords'] = vector3(-672.72, 901.27, 231.19),
        },
        ['Tier'] = 2,
        ['Coords'] = vector3(-658.50, 886.10, 230.29),
        ['CoordsTable'] = {
          ['x'] = -658.50,
          ['y'] = 886.10,
          ['z'] = 230.29
        },
        ['ExitCoords'] = vector3(-668.94, 888.62, 189.45),
        ['Extras'] = {
          [1] = {
            ['Stolen'] = false,
            ['Item'] = 'computer',
            ['PropName'] = 'prop_laptop_01a',
            ['Coords'] = {
              ['X'] = -666.08,
              ['Y'] = 884.68,
              ['Z'] = 194.56
            }    
          },
          [2] = {
            ['Stolen'] = false,
            ['Item'] = 'bigtv',
            ['PropName'] = 'apa_mp_h_str_avunits_01',
            ['Coords'] = {
              ['X'] = -660.06,
              ['Y'] = 874.83,
              ['Z'] = 190.99
            }  
          },
        },
        ['Lockers'] = {
          [1] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -666.22,
              ['Y'] = 886.79,
              ['Z'] = 190.15
            },  
          },
          [2] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] =  -658.86,
              ['Y'] = 884.71,
              ['Z'] = 190.38
            },  
          },
          [3] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -663.32,
              ['Y'] = 880.54,
              ['Z'] = 191.10
            },  
          },
          [4] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -662.84,
              ['Y'] = 876.61,
              ['Z'] = 191.04
            }, 
          },
          [5] = {  
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -655.59,
              ['Y'] = 878.44,
              ['Z'] =  190.61
            },  
          },
          [6] = { 
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -656.13,
              ['Y'] = 890.05,
              ['Z'] = 190.26
            },  
          },
          [7] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -652.88,
              ['Y'] = 891.62,
              ['Z'] = 190.48
            },   
          },
          [8] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -647.68,
              ['Y'] = 890.69,
              ['Z'] = 190.59
            },   
          },
          [9] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -647.78,
              ['Y'] = 887.86,
              ['Z'] = 190.70
            },
          },
          [10] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -657.52,
              ['Y'] = 886.56,
              ['Z'] = 190.36
            },
          },
          [11] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -653.96,
              ['Y'] = 883.80,
              ['Z'] = 194.88
            },
          },
          [12] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -657.01,
              ['Y'] = 874.60,
              ['Z'] = 194.47
            },
          },
          [13] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -656.05,
              ['Y'] = 880.81,
              ['Z'] = 194.96
            },
          },
          [14] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -665.99,
              ['Y'] = 874.46,
              ['Z'] = 194.13
            },
          },
        },
      },
    }
  },
  [3] = { -- Mid Tier Houses (Medium Sized)
    ['ReputationNeeded'] = 50,
    ['RequiredPlayers'] = 3,
    ['ReputationGives'] = 20,

    ['Locations'] = {
      [1] = {
        ['Label'] = 'Reputation House (Mid Tier) 1',
        ['CanEnter'] = false,
        ['CanHackGenerator'] = false,
        ['TokisLocations'] = {
          [1] = {
            ['HacksAmount'] = 3,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-1060.53, -1659.48, 4.79),
          },
          [2] = {
            ['HacksAmount'] = 3,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-1060.87, -1663.07, 4.89),
          },
        },
        ['MainGenerator'] = {
          ['HacksAmount'] = 3,
          ['HacksDone'] = 0,
          ['IsBeingHacked'] = false,
          ['IsHacked'] = false,
          ['Coords'] = vector3(-1065.19, -1667.17, 5.08),
        },
        ['Tier'] = 2,
        ['Coords'] = vector3(-1058.40, -1657.42, 4.67),
        ['CoordsTable'] = {
          ['x'] = -1058.40,
          ['y'] = -1657.42,
          ['z'] = 4.67
        },
        ['ExitCoords'] = vector3(-1068.82, -1654.74, -36.17),
        ['Extras'] = {
          [1] = {
            ['Stolen'] = false,
            ['Item'] = 'computer',
            ['PropName'] = 'prop_laptop_01a',
            ['Coords'] = {   
              ['X'] = -1065.35,
              ['Y'] = -1658.86,
              ['Z'] = -31.13
            }    
          },
          [2] = { 
            ['Stolen'] = false,
            ['Item'] = 'bigtv',
            ['PropName'] = 'apa_mp_h_str_avunits_01',
            ['Coords'] = {
              ['X'] =  -1060.21,
              ['Y'] =  -1667.03,
              ['Z'] = -34.32
            }  
          },
        },
        ['Lockers'] = {
          [1] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1066.24,
              ['Y'] = -1656.86,
              ['Z'] = -36.00
            },  
          },
          [2] = {  
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1065.97,
              ['Y'] = -1652.07,
              ['Z'] = -35.89
            },  
          },
          [3] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1057.48,
              ['Y'] = -1657.02,
              ['Z'] = -35.62
            },  
          },
          [4] = {  
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1055.77,
              ['Y'] = -1653.53,
              ['Z'] = -35.40
            }, 
          },
          [5] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1052.92,
              ['Y'] = -1652.00,
              ['Z'] = -35.35
            },  
          },
          [6] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1048.55,
              ['Y'] = -1651.80,
              ['Z'] = -35.33
            },  
          },
          [7] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1047.54,
              ['Y'] =  -1655.82,
              ['Z'] = -35.31
            },   
          },
          [8] = {
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1058.85,
              ['Y'] = -1658.92,
              ['Z'] = -35.23
            },   
          },
          [9] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1063.15,
              ['Y'] = -1663.12,
              ['Z'] = -34.66
            },
          },
          [10] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1063.35,
              ['Y'] = -1666.90,
              ['Z'] = -34.86
            },
          },
          [11] = {          
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1053.82,
              ['Y'] = -1659.55,
              ['Z'] = -31.01
            },
          },
          [12] = {         
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1057.00,
              ['Y'] = -1668.87,
              ['Z'] = -31.22
            },
          },
          [13] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1062.23,  
              ['Y'] = -1664.93,
              ['Z'] = -31.28,
            },
          },
          [14] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1062.72,
              ['Y'] = -1653.03,
              ['Z'] = -31.28
            },
          },
          [15] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {   
              ['X'] = -1067.85,
              ['Y'] =  -1651.68,
              ['Z'] =  -31.57
            },
          },
          [16] = {        
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] =  -1061.93,
              ['Y'] = -1656.18,
              ['Z'] = -31.22
            },
          },
          [17] = {         
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1055.95,
              ['Y'] = -1662.68,
              ['Z'] = -31.12
            },
          },
        },
      },
    }
  },
  [4] = { -- Mid Tier Houses (Medium Sized)
    ['ReputationNeeded'] = 70,
    ['RequiredPlayers'] = 3,
    ['ReputationGives'] = 20,

    ['Locations'] = {
      [1] = {
        ['Label'] = 'Reputation House (Mid Tier) 1',
        ['CanEnter'] = false,
        ['CanHackGenerator'] = false,
        ['TokisLocations'] = {
          [1] = {
            ['HacksAmount'] = 3,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-1241.59, -1141.18, 8.21),
          },
          [2] = {
            ['HacksAmount'] = 3,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-1253.86, -1145.09, 8.65),
          },
        },
        ['MainGenerator'] = {
          ['HacksAmount'] = 3,
          ['HacksDone'] = 0,
          ['IsBeingHacked'] = false,
          ['IsHacked'] = false,
          ['Coords'] = vector3(-1254.67, -1146.59, 8.05),
        },
        ['Tier'] = 2,
        ['Coords'] = vector3(-1252.76, -1144.63, 8.51),
        ['CoordsTable'] = {
          ['x'] = -1252.76,
          ['y'] = -1144.63,
          ['z'] = 8.51
        },
        ['ExitCoords'] = vector3(-1263.19, -1141.92, -32.33),
        ['Extras'] = {
          [1] = {   
            ['Stolen'] = false,
            ['Item'] = 'computer',
            ['PropName'] = 'prop_laptop_01a',
            ['Coords'] = {   
              ['X'] = -1260.07,
              ['Y'] = -1146.13,
              ['Z'] = -27.18
            }    
          },
          [2] = {   
            ['Stolen'] = false,
            ['Item'] = 'bigtv',
            ['PropName'] = 'apa_mp_h_str_avunits_01',
            ['Coords'] = {
              ['X'] = -1254.32,
              ['Y'] = -1156.21,
              ['Z'] = -31.03
            }  
          },
        },
        ['Lockers'] = {
          [1] = {     
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1260.56,
              ['Y'] = -1144.03,
              ['Z'] = -32.08
            },  
          },
          [2] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1260.45,
              ['Y'] = -1139.58,
              ['Z'] = -32.10
            },  
          },
          [3] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1251.76,
              ['Y'] = -1144.30,
              ['Z'] = -31.80
            },  
          },
          [4] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1250.10,
              ['Y'] = -1140.74,
              ['Z'] = -31.39
            }, 
          },
          [5] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1247.14,
              ['Y'] = -1139.22,
              ['Z'] = -31.41
            },  
          },
          [6] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1242.96,
              ['Y'] = -1139.18,
              ['Z'] = -31.40
            },  
          },
          [7] = {     
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1242.08,
              ['Y'] = -1142.96,
              ['Z'] = -31.33
            },   
          },
          [8] = {  
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1244.70,
              ['Y'] = -1146.85,
              ['Z'] = -31.31
            },   
          },
          [9] = {        
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1253.22,
              ['Y'] = -1146.26,
              ['Z'] = -31.27
            },
          },
          [10] = { 
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1257.35,
              ['Y'] = -1150.30,
              ['Z'] = -30.86
            },
          },
          [11] = {           
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1257.68,
              ['Y'] = -1152.27,
              ['Z'] = -30.83
            },
          },
          [12] = {           
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1257.17,
              ['Y'] = -1154.16,
              ['Z'] = -30.78
            },
          },
          [13] = {        
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -1248.23,
              ['Y'] = -1146.96,
              ['Z'] = -27.28
            },
          },
          [14] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1250.46,
              ['Y'] = -1150.37,
              ['Z'] = -26.97
            },
          },
          [15] = {         
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {   
              ['X'] = -1251.39,
              ['Y'] = -1156.06,
              ['Z'] = -27.32
            },
          },
          [16] = {         
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1252.14,
              ['Y'] = -1153.49,
              ['Z'] = -27.42
            },
          },
          [17] = {           
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1256.71,
              ['Y'] = -1152.06,
              ['Z'] = -27.53
            },
          },
          [18] = {           
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] =  -1257.59,
              ['Y'] = -1156.39,
              ['Z'] = -27.67
            },
          },
          [19] = {             
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1260.33,
              ['Y'] = -1156.00,
              ['Z'] = -27.55
            },
          },
          [20] = {           
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1258.36,
              ['Y'] = -1146.93,
              ['Z'] = -27.33
            },
          },
          [21] = {               
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1256.63,
              ['Y'] = -1143.44,
              ['Z'] = -27.26
            },
          },
          [22] = {              
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -1257.86,
              ['Y'] =  -1140.04,
              ['Z'] = -27.31
            },
          },
        },
      },
    }
  },
  [5] = { -- Mid Tier Houses (Medium Sized)
    ['ReputationNeeded'] = 30,
    ['RequiredPlayers'] = 3,
    ['ReputationGives'] = 20,

    ['Locations'] = {
      [1] = {
        ['Label'] = 'Reputation House (Mid Tier) 1',
        ['CanEnter'] = false,
        ['CanHackGenerator'] = false,
        ['TokisLocations'] = {
          [1] = {
            ['HacksAmount'] = 3,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-971.70, -1118.87, 2.54),
          },
          [2] = {
            ['HacksAmount'] = 3,
            ['HacksDone'] = 0,
            ['IsBeingHacked'] = false,
            ['IsHacked'] = false,
            ['Coords'] = vector3(-964.01, -1113.50, 2.45),
          },
        },
        ['MainGenerator'] = {
          ['HacksAmount'] = 3,
          ['HacksDone'] = 0,
          ['IsBeingHacked'] = false,
          ['IsHacked'] = false,
          ['Coords'] = vector3(-969.54, -1122.63, 2.66),
        },
        ['Tier'] = 2,
        ['Coords'] = vector3(-970.49, -1120.95, 2.17),
        ['CoordsTable'] = {
          ['x'] = -970.49,
          ['y'] = -1120.95,
          ['z'] = 2.17
        },
        ['ExitCoords'] = vector3(-980.84, -1118.41, -38.67),
        ['Extras'] = {
          [1] = {   
            ['Stolen'] = false,   
            ['Item'] = 'computer',
            ['PropName'] = 'prop_laptop_01a',
            ['Coords'] = {   
              ['X'] = -977.85,
              ['Y'] = -1122.62,
              ['Z'] = -33.57
            }    
          },
          [2] = {   
            ['Stolen'] = false,  
            ['Item'] = 'bigtv',
            ['PropName'] = 'apa_mp_h_str_avunits_01',
            ['Coords'] = {
              ['X'] = -971.91,
              ['Y'] = -1132.64,
              ['Z'] = -37.43
            }  
          },
        },
        ['Lockers'] = {   
          [1] = {     
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -978.28,
              ['Y'] = -1120.43,
              ['Z'] = -38.23
            },  
          },
          [2] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -969.52,
              ['Y'] = -1120.48,
              ['Z'] = -38.11
            },  
          },
          [3] = {     
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -967.92,
              ['Y'] = -1117.03,
              ['Z'] = -37.92
            },  
          },
          [4] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -965.04,
              ['Y'] = -1115.67,
              ['Z'] = -37.77
            }, 
          },
          [5] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -959.94,
              ['Y'] = -1116.34,
              ['Z'] = -37.59
            },  
          },
          [6] = {     
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -959.46,
              ['Y'] = -1119.32,
              ['Z'] = -37.66
            },  
          },
          [7] = {      
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -970.77,
              ['Y'] = -1122.70,
              ['Z'] = -37.80
            },   
          },
          [8] = {    
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -965.78,
              ['Y'] = -1123.25,
              ['Z'] = -33.57
            },   
          },
          [9] = {        
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -968.12,  
              ['Y'] = -1126.36,
              ['Z'] = -33.36
            },
          },
          [10] = {   
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -969.01,
              ['Y'] = -1132.41,
              ['Z'] = -33.60
            },
          },
          [11] = {            
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -974.55,
              ['Y'] = -1128.36,
              ['Z'] = -33.77
            },
          },
          [12] = {             
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -975.31,
              ['Y'] = -1132.52,
              ['Z'] = -33.98
            },
          },
          [13] = {          
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {
              ['X'] = -976.19,
              ['Y'] = -1123.24,
              ['Z'] = -33.87
            },
          },
          [14] = {       
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {  
              ['X'] = -975.10,
              ['Y'] = -1116.64,
              ['Z'] = -33.58
            },
          },
          [15] = {           
            ['Busy'] = false,
            ['Opened'] = false,
            ['Coords'] = {   
              ['X'] = -979.90,
              ['Y'] = -1115.25,
              ['Z'] = -33.78
            },
          },
        },
      },
    }
  },
}

Config.MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
  }
  
  Config.FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
  if length > 0 then
    return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
  else
    return ''
  end
end

Config.RandomInt = function(length)
  if length > 0 then
    return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
  else
    return ''
  end
end