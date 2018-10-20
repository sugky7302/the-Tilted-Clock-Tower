Base.ids1 = {}
Base.ids2 = {}

function Base._id(a)
    local r = ('>I4'):pack(a)
    Base.ids1[a] = r
    Base.ids2[r] = a
    return r
end

function Base.Id2String(a)
    return Base.ids1[a] or Base._id(a)
end

function Base.__id2(a)
    local r = ('>I4'):unpack(a)
    Base.ids2[a] = r
    Base.ids1[r] = a
    return r
end

function Base.String2Id(a)
    return Base.ids2[a] or Base.__id2(a)
end