local Hero = require 'hero'

require 'heros.冰霜秘術師.寒冰箭'
require 'heros.冰霜秘術師.暴風雪'
require 'heros.冰霜秘術師.霜之環'

return Hero.Create '冰霜秘術師' {
    id = 'Hamg',
    skillCounts = 4,
    skillNames = "寒冰箭 暴風雪 霜之環",
}