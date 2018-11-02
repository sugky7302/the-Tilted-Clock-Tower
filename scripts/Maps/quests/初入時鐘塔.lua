local mt = require 'quest' "初入時鐘塔"
{
    detail = "黑淵的封印即將消退，惡魔即將從黑淵竄出。時鐘塔非常需要你們的支援。",
    required = {"擊殺物品測試員", "擊殺10名物品測試員"},
    demands = {'nbrg', {'nbrg', 10}},
    talk = "您好，勇士。我是紅時鐘塔奧格林分會會長|cffffcc00庫拉特|r，非常感謝您的協助。",
    rewards = {"70金幣"}, 
}

function mt:on_reward()
    self.receiver.owner:add("黃金", 70)
end