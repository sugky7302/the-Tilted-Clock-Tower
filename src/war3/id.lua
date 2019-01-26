-- 這個module為轉換256進位制整數

Base.ids1 = {}
Base.ids2 = {}

local function _id(a)
    local floor = math.floor 

    local s1 = floor(a/256/256/256)%256
    local s2 = floor(a/256/256)%256
    local s3 = floor(a/256)%256
    local s4 = a%256
    local r = string.char(s1, s2, s3, s4)
    Base.ids1[a] = r
    Base.ids2[r] = a
    return r
end

function Base.Id2String(a)
    return Base.ids1[a] or _id(a)
end

local function _id2(a)
    local byte = string.byte

    local n1 = byte(a, 1) or 0
    local n2 = byte(a, 2) or 0
    local n3 = byte(a, 3) or 0
    local n4 = byte(a, 4) or 0
    local r = n1 * 256^3 + n2 * 256^2 + n3 * 256 + n4
    Base.ids2[a] = r
    Base.ids1[r] = a
    return r
end

function Base.String2Id(a)
    return Base.ids2[a] or _id2(a)
end