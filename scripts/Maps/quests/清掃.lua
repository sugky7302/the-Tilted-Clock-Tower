local mt = require 'quest' "清掃"
{
    detail = "菜鳥，你的好日子到了。外頭有幾隻小傢伙給你練手練手，好好享受你的第一次殺戮吧！",
    required = {"擊殺2隻豺狼人", "擊殺2隻豺狼人偷獵者"},
    demands = {{'ngno', 2}, {'ngna', 2}},
    talk = "還行。",
    rewards = {"180金幣"}, 
}

function mt:on_reward()
    self.receiver.owner:add("黃金", 180)
end