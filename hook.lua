-- require: turn off VAC
local obs = obslua
local bit = require("bit")
local ffi = require("ffi")
local ntdll = ffi.load("ntdll.dll")
local usr32 = ffi.load("user32.dll")
local krnl32 = ffi.load("kernel32.dll")

-- ENV Address 
local env_address = 0x5FD21070

function script_load()
	-- OBS Addr
	local magic = 0x0D0820
	attach(magic)
	
	-- attach後 read_i32(addr)でcs2のメモリデータ読み込み可
  -- VAC止めないとVAC BAN不可避
end

function attach(addr)
	local magic = 0x42C1
	local offset = 1
	local krnl_magic = 4
	local address_content = 0
	local cap = krnl32.GetModuleHandleA("win-cap.dll") + magic + offset
	return krnl32.WriteProcessMemory(offset, env_address, ffi.new("int[1]", cap), krnl_magic, address_content)
end

function read_i32(addr)
	local buffer = ffi.new("uint32_t[1]", 0)
	local max_length = 8
	ntdll.NtReadVirtualMemory(env_address, addr, buffer, max_length, 0)
	return buffer[0]
end
