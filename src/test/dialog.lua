function DialogText()
    local _Init = require 'timer.init'.Init
    _Init()

    local Timer = require 'timer.core'
    Timer(1, false, function()
        local Dialog = require 'dialog'
        local cj = require 'jass.common'

        local dialog = Dialog(cj.Player(0))
        dialog:AddButton("測試", "test")
        dialog:SetTitle "正在測試中"
        dialog:Show(true)

        
        Timer(1, false, function()
            dialog:Show(false)
            dialog:Remove()
        end)
    end)
end

return DialogText