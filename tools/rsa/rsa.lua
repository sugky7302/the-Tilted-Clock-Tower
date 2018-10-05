(function()
	local exepath = package.cpath:sub(1, package.cpath:find(';')-6)
	package.path = package.path .. ';' .. exepath .. '..\\..\\?.lua'
end)()

require 'filesystem'

local bignum = require 'rsa.bignum'
local _sha1 = require 'rsa.sha1'

local rootpath = fs.get(fs.DIR_EXE):parent_path():parent_path():parent_path()
local rsa_dir = rootpath / 'rsa'

local function load_public(str)
    local tbl = {}
    for line in str:gmatch '[^\r\n]+' do
        tbl[#tbl+1] = line
    end
    return tbl[1], tbl[2]
end

local function str2bn(str)
    local bn = {}
    for i = #str / 2, 1, -1 do
        local x = str:sub(i*2-1, i*2)
        bn[#bn+1] = load('return 0x'..x)()
    end
    return string.char(table.unpack(bn))
end

local function bn2str(bn)
    local str = {}
    for i = #bn, 1, -1 do
        str[#str+1] = ('%02X'):format(bn:sub(i, i):byte())
    end
    return table.concat(str)
end

local function sha1(str)
    local str = _sha1(str)
    local bn = {}
    for i = 1, #str / 2 do
        local x = str:sub(i*2-1, i*2)
        bn[#bn+1] = load('return 0x'..x)()
    end
    return string.char(table.unpack(bn))
end

local rsa = {}

function rsa:init(e, n, d)
    self.e_bn = bignum(str2bn(e))
    self.n_bn = bignum(str2bn(n))
    self.d_bn = bignum(str2bn(d))
end

function rsa:encrypt(c)
    local c_bn = bignum(c)
    local m_bn = c_bn:powmod(self.e_bn, self.n_bn)
    return tostring(m_bn)
end

function rsa:decrypt(m)
    local m_bn = bignum(m)
    local c_bn = m_bn:powmod(self.d_bn, self.n_bn)
    return tostring(c_bn)
end

--生成簽名
--	文本
function rsa:get_sign(content)
	return self:decrypt(content)
end

--驗證簽名
--	文本
--	簽名
function rsa:check_sign(content, sign)
	return content == self:encrypt(sign)
end

function io_load(path)
    local f = io.open(path:string(), 'rb')
    if f then
        local content = f:read 'a'
        f:close()
        return content 
    end
end

function io_save(path, content)
    local f = io.open(path:string(), 'wb')
    if f then
        f:write(content)
        f:close()
    end
end

local function main()
    if not arg[1] then
        print('把要簽名的文件拖到bat中')
        return
    end

    local d = io_load(rsa_dir / 'ppk')
    if not d then
        print('沒有私鑰')
        return
    end

    local e, n = load_public(io_load(rsa_dir / 'pub'))
    print('e =', e)
    print('n =', n)
    print('d =', d)

    rsa:init(e, n, d)

    local filepath = fs.path(arg[1])
    local m = io_load(filepath)
    if not m then
        print('文件讀取失敗', filepath:string())
        return
    end

    print('測試sha1算法')
    if sha1('156498461560') == str2bn('E200BE0024B7173A7C0145E573338FF6942DCA98') then
        print('測試通過')
    else
        print('sha1算法錯誤')
        print(bn2str(sha1('156498461560')))
        return
    end

    print('')
    print('')
    print('輸入文件的sha1如下')
    local sha1 = sha1(m)
    print(bn2str(sha1))

    print('')
    print('')
    print('開始計算簽名')
    local sign = rsa:get_sign(sha1)
    print('簽名計算完畢')
    print(bn2str(sign))

    print('')
    print('')
    print('開始驗證簽名')
    print(rsa:check_sign(sha1, sign))

    print('')
    print('')
    print('生成簽名')
    io_save(fs.path(filepath:string() .. '.sign'), sign)
    print('用時', os.clock(), '秒')
end

main()



