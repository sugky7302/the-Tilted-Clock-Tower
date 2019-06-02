local function RegexTest()
    local s1 = "|cff99ccff動物|r|n豺狼守望者 |n|cffff0000小頭目|r"
    local s2 = "|cff99ccff動物|r|n豺狼偷獵者 "
    local s3 = "|cff99ccff動物|r|n豺狼人 "

    local regex = 'n(.+)%s'
    local match = string.match
    print(match(s1, regex))
    print(match(s2, regex))
    print(match(s3, regex))
end

return RegexTest