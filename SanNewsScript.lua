require "lib.moonloader"
require "lib.sampfuncs"

local inicfg = require 'inicfg'
local path = getWorkingDirectory() .. "\\config\\openAngar.ini"
local inicfg = require 'inicfg'
local events = require 'lib.samp.events'
local vkeys = require 'vkeys'
local font_flag = require('moonloader').font_flag
local my_font = renderCreateFont('Verdana', 12 , font_flag.BOLD + font_flag.SHADOW)
local fStart = false
local fKik = false
local fKlav = false
local fVse = false
local fRevolver = false
local fRuletka = false
local fBega = false
local fRkick = false
local drop_list = { 43 }
local SE = require 'samp.events'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8



local array = {{}}
local timeOtkat = 20
local predArray = {{}}


local ini = inicfg.load({ global = { script_state = true} }, 'mayoRhelp.ini')

local MainIni = inicfg.load({
    Main = {
		fWriteMessageAngar = true
	}
}, path)
inicfg.save(MainIni,path)


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	


	sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}������ ��� ���������� | ����������: {FF0000}/shelp {FFFFFF}| ������: {FF0000}1.5",0xFFFFFF)

		onDirectoryCreated( { "config" }, path, MainIni, "\\openAngar.ini")
		while not isDirectoryCreated do wait(0) end
	sampRegisterChatCommand("poff", writeMessageAngar)
	sampRegisterChatCommand("shelp", func)
	sampRegisterChatCommand("sboi", sboi)
	sampRegisterChatCommand("scs", scs)
	sampRegisterChatCommand("ssv", ssv)
	sampRegisterChatCommand("ssvv", ssvv)
	sampRegisterChatCommand("stdm", stdm)
	sampRegisterChatCommand("ssval", ssval)
	sampRegisterChatCommand("ssvar", ssvar)
	sampRegisterChatCommand("payy", payy)
	sampRegisterChatCommand("gg", getClosestPlayerId)
	sampRegisterChatCommand("spvp", spvp)
	sampRegisterChatCommand("hstart", test)
	sampRegisterChatCommand("hkik", fkik)
	sampRegisterChatCommand("moneta", random1) -- ���. ���.
	sampRegisterChatCommand("pred", pred)
	sampRegisterChatCommand("remove", removePred)
	sampRegisterChatCommand("hklav", fklav)
	sampRegisterChatCommand("rull", function()
		fRuletka = not fRuletka
		sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}������ ��� {FFFF00}�� '���� �� ���������' | " .. (fRuletka and "{008000}�������" or "{FF0000}��������."), -1)
	end)
	sampRegisterChatCommand("bega", Bega)
	Dialog = lua_thread.create_suspended(DialogFunc)
	sampRegisterChatCommand("rrr", Revolver)
	Dialog = lua_thread.create_suspended(DialogFunc)
    sampRegisterChatCommand("rkick", function()
        fRkick = not fRkick
        if fRkick then
            sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}������� ���������� ��� {FFFF00}�� '������� �������' | {008000}�������.",0xFFFFFF)
        else
            sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}������� ���������� ��� {FFFF00}�� '������� �������' | {FF0000}��������.",0xFFFFFF)
        end
	end)
	sampRegisterChatCommand('sg',
	  function()
			ini.global.script_state = not ini.global.script_state
			if inicfg.save(ini, 'moonloader\\config\\mayoRhelp.ini') then
			  sampAddChatMessage(ini.global.script_state and '{FF0000}[mayoR*script] {FFFFFF}��������������� ������������. ������: {008000}������� '
				 or '{FF0000}[mayoR*script] {FFFFFF}��������������� ������������. ������: {FF0000}��������.', -1)

			end
		end)


	while true do


			if fStart then
                 renderFontDrawText(my_font, '{FF0000}����� ��� ��:\n{008000}/scs {FFFFFF}- CS\n{008000}/ssv {FFFFFF}- ��\n{008000}/ssva {FFFFFF}- �����.��������� (��������)\n{008000}/ssvv {FFFFFF}- �����.��������� (������)\n{008000}/ssvar {FFFFFF}- �����.��������� (�����)\n{008000}/sboi {FFFFFF}- ���\n{008000}/spvp {FFFFFF}- PVP\n{008000}/stdm {FFFFFF}- TDM' , 1025,590, 0xFFFFFFFF)

	        end
	        if fKik then
                 renderFontDrawText(my_font, '{FF0000}��� �� ������:\n{008000}������+H {FFFFFF}- ������� ���\n{008000}������+J {FFFFFF}- �������� ��\n{008000}������+K {FFFFFF}- ������� ��\n{008000}������+L {FFFFFF}- ��������� ������ ��' , 1025,605, 0xFFFFFFFF)

	        end
	        if fKlav then
                 renderFontDrawText(my_font, '������� �������:\n{008000}������� "O" {FFFFFF}- �������/������� �����.\n{008000}������� "P" {FFFFFF}- ����� �� ������\n{008000}������� "I" {FFFFFF}- �������/������� ���������.' , 980,665, 0xFFFFFFFF)

	        end
					wait(0)
        if not sampIsChatInputActive() then
					if fRevolver then
						if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_V) then
							local PlayerResult = false
							local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
							if PlayerResult then
								PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget)
								PlayerName = sampGetPlayerNickname(PlayerId)
								math.randomseed(os.time())
								local random = math.random(1, 6)
								if random == 1 or random == 3 then
									sampSendChat("/s �������� �������� �� "  .. PlayerName .. " | ����")
									if fRkick then
										wait(1500)
										sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}�� ��������� �������� �� {FF0000}" .. PlayerName .. " {FFFFFF}| �����.",0xFFFFFF)
										sampSendChat("/akick "..PlayerId.." �� �����. ���")
									end
								else
								    sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}�� ��������� �������� �� {FF0000}" .. PlayerName .. " {FFFFFF}| ���������.",0xFFFFFF)
									sampSendChat("/s �������� �������� �� "  .. PlayerName .. " | ��������")
								end
							end
						end
					end


          if isKeyJustPressed(vkeys.VK_O) then
              sampSendChat("/open")
							if MainIni.Main.fWriteMessageAngar then
									sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}�� ��������������� ��������{008000} 'O'. {FF0000}(����� /open)",0xffffff)
							end
        	end

					if isKeyJustPressed(vkeys.VK_P) then
					    sampSendChat("/exit")
							if MainIni.Main.fWriteMessageAngar then
								sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}�� ��������������� ��������{008000} 'P'. {FF0000}(����� /exit)",0xffffff)
							end
	        end
					if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_J) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_J) then
						PlayerName = sampGetPlayerNickname(PlayerId)
							sampSendChat("/akick "  .. PlayerId ..  " �� ���������. ���!")
							if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("�� ������� ������ {FF0000}" .. PlayerName .. " {ffffff}�� ������. �������: ��������. ", 0xffffff)
						    end
						end
					end
					if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_K) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_K) then
						PlayerName = sampGetPlayerNickname(PlayerId)
							sampSendChat("/akick "  .. PlayerId ..  " �� ��������. ����������!")
							if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("�� ������� ������ {FF0000}" .. PlayerName .. " {ffffff}�� ������. �������: ����������. ", 0xffffff)
						    end
						end
					end
					if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_L) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_L) then
						PlayerName = sampGetPlayerNickname(PlayerId)
							sampSendChat("/akick "  .. PlayerId ..  " ��������� ������ �����������.")
	 						if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("�� ������� ������ {FF0000}" .. PlayerName .. " {ffffff}�� ������. �������: ��������� ������ �����������. ", 0xffffff)
						    end
						end
					end
				    if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_H) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_H) then
						PlayerName = sampGetPlayerNickname(PlayerId)
	 						sampSendChat("/akick "  .. PlayerId .. " -")
							if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("�� ������� ������ {FF0000} " .. PlayerName .. " {ffffff}�� ������. ", 0xffffff)
						    end
						end
					end
                     if isKeyJustPressed(vkeys.VK_I) then
					    sampSendChat("/lock")
						if MainIni.Main.fWriteMessageAngar then
						sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}�� ��������������� ��������{008000} 'I'. {FF0000}(����� /lock)",0xffffff)
					    end
					end
                     if isKeyJustPressed(vkeys.VK_Y) then
					    sampSendChat("/unrentcar")
						if MainIni.Main.fWriteMessageAngar then
						sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}�� ��������������� ��������{008000} 'Y'. {FF0000}(����� /unrentcar)",0xffffff)
					    end
					end
				end
    end
end




function func()
    Dialog:run()
end


function DialogFunc()
sampShowDialog(10, "���������� �������", "{FFFF00}'/poff' {FFFFFF}- ��������� ���������� � ��������� ���������.\n{FFFF00}'/bega' {FFFFFF}- ��������/��������� ������ ��� �� '�������� ����'. \n{FFFF00}'/rull' {FFFFFF}- ��������/��������� ������ ��� �� '���� �� ���������'.\n{FFFF00}'/hstart' {FFFFFF}- ������� �� ����� ������� ��� �����a �����������.\n{FFFF00}'/hklav' {FFFFFF}- ������� �� ����� ������� ������� �������.\n{FFFF00}'/hkik' {FFFFFF}- ������� �� ����� ������� ��� ���� ������ �� ������.\n{FFFF00}'/sg' {FFFFFF}- ��������������� ������������.\n{FFFF00}'/payy [id] [�����]' {FFFFFF}- ������������� ������ ������ �������� �����.\n{FFFF00}'/rr' {FFFFFF}- ��������/��������� ������ ��� �� '������� �������'.\n{FFFF00}'/rkick' {FFFFFF}- ������� ������������ (������� �������).\n{FF0000}'������ �� ������ + V' {FFFFFF}- ��� ������� �������.\n{FF0000}'������ �� ������ + H' {FFFFFF}- ������� ��� � ������.\n{FF0000}'������ �� ������ + J' {FFFFFF}- ��� � ������ ������������.\n{FF0000}'������ �� ������ + K' {FFFFFF}- ��� � ������ ����������.\n{FF0000}'������ �� ������ + L' {FFFFFF}- ��� �� ��������� ������ ��.\n{008000}'������� O' {FFFFFF}- �������/������� �����.\n{008000}'������� P' {FFFFFF}- ����� �� ������.\n{008000}'������� I' {FFFFFF}- �������/������� ������ ���������.\n{008000}'������� Y' {FFFFFF}- ���������� �� ������ ����������.\n{FFFF00}'/scs' {FFFFFF}- ����� ��� CS.\n{FFFF00}'/ssv' {FFFFFF}- ����� ��� ��.\n{FFFF00}'/spvp' {FFFFFF}- ����� ��� PvP.\n{FFFF00}'/sboi' {FFFFFF}- ����� ��� ����.\n{FFFF00}'/stdm' {FFFFFF}- ����� ��� ���.\n{FFFF00}'/ssval' {FFFFFF}- ����������� ��������� (��������).\n{FFFF00}'/ssvv' {FFFFFF}- ����������� ��������� (������ �� ������).\n{FFFF00}'/ssvar' {FFFFFF}- ����������� ��������� (�����).\n                                                                                          � ������� �� mayoR","�������")
end

function ssval()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/c ����� ���� ������� � ��������.")
        wait(2000)
        sampSendChat("/me ������� ������� ����������")
        wait(2250)
		sampSendChat("/c ������ �� ��� ������ ����� ����� �� 0 �� 1000$.")
		wait(2000)
		sampSendChat("/c �����, ������� ������� ���������� ����� - ��������.")
		wait(1500)
		sampSendChat("/c �����, ������� ������� ���������� ����� - ��������.")
		wait(2000)
		sampSendChat("/c ��� ���� ����� � ���� � /pm!")
    end)
end

function random1() -- Cmd
    lua_thread.create(function()
    math.randomseed(os.time())
    local random = math.random(1, 2)
        if random == 1 then -- ���� ������ ����� 0, ��
		wait(100)
        sampSendChat("/s ������ ������ � ��������. | ���������: ����")
        elseif random == 2 then -- ���� 1, ��
		wait(100)
        sampSendChat("/s ������ ������ � ��������. | ���������: �����")
		end
    end)
end

function ssvv()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/c ����� ���� ������� � ��������.")
        wait(2000)
        sampSendChat("/me ������� ������� � ��������.")
        wait(2250)
		sampSendChat("/c ������ ������ ������� �����. ������� �� ������ ��� ���.")
		wait(2000)
		sampSendChat("/c ���� ��� ������ ����� ������ - ��� �������.")
		wait(1500)
		sampSendChat("/c ���� ���� ������� �����, � ������ ���, �� �� �������.")
		wait(2000)
		sampSendChat("/c ���� ��� ������ ���������� �� ����� - �������� ���.")
		wait(2000)
		sampSendChat("/c ��� ���� ������ � ���� � /pm. ����� �� ����!")
    end)
end

function scs()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Counter-Strike | ����� 20 ������ ����� ����� �����������.")
        wait(15000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 160")
        sampSendChat("/news Counter-Strike | �����. ����� �����!")
    end)
end


function ssv()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news ����������� ������� | ����� 20 ������ ����� ����� �����������.")
        wait(15000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 45")
        sampSendChat("/news C���������� ������� | �����. ����� �����!")
    end)
end

function sboi()

    lua_thread.create(function()
        PlayerName = sampGetPlayerNickname(PlayerId)
        sampSendChat("/news ��� | ���������, ������ �� �����. ����� ����� 10 ������")
        wait(5000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 100")
        sampSendChat("/s ��� | �����. ����� �����!")
    end)


end

function spvp()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Player vs Player | ����� 10 ������ ����� �����. ����������!")
        wait(5000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 160")
        sampSendChat("/s Player vs Player | �����. ����� �����!")
    end)
end

function removePred()
	for k,v in pairs(predArray) do
		--print(k .. " ")
		predArray[k] = nil
	end
end

function pred(param)
	if param ~= "" then

		if predArray[param] == nil then
			--table.insert(object, {param, 1})
			predArray[param] = 1
			sampSendChat("/news ����� ".. sampGetPlayerNickname(param) .." �������� ".. predArray[param] .."/3 ��������������. ")
			--print(predArray[param])
			--removePred()
		elseif predArray[param] == 1 then
			predArray[param] = 2
			sampSendChat("/news ����� ".. sampGetPlayerNickname(param) .." �������� ".. predArray[param] .."/3 ��������������. ")
		elseif predArray[param] == 2 then
			predArray[param] = 3
			lua_thread.create(function()
				sampSendChat("/news ����� ".. sampGetPlayerNickname(param) .." �������� ".. predArray[param] .."/3 ��������������. ")
				predArray[param] = nil
				wait(1500)
				sampSendChat("/akick " .. param .. " 3/3 ��������������")
			end)
		end
		print(predArray[param])

	end
end

function stdm()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Team Death Math | ����� 20 ������ ����� �����. ����������!")
        wait(15000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 160")
        sampSendChat("/s Team Death Math | �����. ����� �����!")
    end)
end

function ssvar()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/c ���������� � 3 �������. � ���� ������ ���� ������")
        wait(1500)
        sampSendChat("/c ����������� � ���, ��� ��� ����� �������� ��� � /pm")
        wait(1500)
        sampSendChat("/c ������ �� �����, ���������� ��� ������ ������� ������")
		wait(1500)
        sampSendChat("/� ���� ������ �����/����������, �� ����� ����������")
		wait(1500)
		sampSendChat("/� ������: ���������(��� ������) �� ID:0")
		wait(1500)
		sampSendChat("/c ���� �� ��������� ������, � �� ��������� - �� ���������")
		wait(1500)
		sampSendChat("/c ���� �� �������� �� ������, � �� �� �������� ��� - ���������")
		wait(1500)
		sampSendChat("/c ���� ��� ����� ������ - ��������� ���")
    end)
end

function payy(param)
    id, money = param:match("^(%d+)%s+(%d+)$")
    if id ~= nil and money ~= nil then
        nick = tonumber(id);
        money1 = tonumber(money)
        name1 = sampGetPlayerNickname(nick)

        colvo = 0
        lua_thread.create(function()
            local change
            repeat
                if (money1 - colvo) >= 1000000 then
                    change = 1000000
                else
                    change = money1 - colvo
                end
                sampSendChat("/pay " .. id .. " " .. change)
                colvo = colvo + change
                wait(5750)
            until colvo >= money1
            sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}�� �������� ������ {FFFF00}" .. name1 .." : {008000}" .. colvo .. "$", -1)
            colvo = 0
        end)
    else
        sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF} ������! �������� �����: {FF0000}/payy [id] [�����]", -1)
    end
end

function onDirectoryCreated(directory, path, a, v)
  for i = 1, #directory do
    local dir_path = getWorkingDirectory() .. "\\" .. directory[i]
    if not doesDirectoryExist(dir_path) then createDirectory(dir_path) end
  end

  if not doesFileExist(path) then
		inicfg.save(a, v)
  end

  isDirectoryCreated = true
end

function writeMessageAngar()
	MainIni.Main.fWriteMessageAngar = not MainIni.Main.fWriteMessageAngar
	inicfg.save(MainIni, path)
	if MainIni.Main.fWriteMessageAngar then
		sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}���������� � �������� ��������� ���� {008000}��������.", 0xffffff)
	else
		sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}���������� � �������� ��������� ���� {FF0000}���������.", 0xffffff)
	end
end

function events.onGivePlayerWeapon(weaponId, ammo)
        if ini.global.script_state then
		        for _, id in pairs(drop_list) do
			        if weaponId == id then return false end
		        end
	    end
end


function test()
    fStart = not fStart
end

function fkik()
    fKik = not fKik
end

function fklav()
    fKlav = not fKlav
end

function fvse()
    fVse = not fVse
end

function removeRecord()
	for i = #array, 1, -1 do
		table.remove(array, i)
	end
end

function Revolver()
	fRevolver = not fRevolver
    if fRevolver then
	    sampSendChat("/me ������ ��������� | �������� 2/6 ������")
	  else
	   	sampSendChat("/me ������ ���� � ����� ���������")
			removeRecord()
		end
end

function Bega()
	fBega = not fBega
    if fBega then
	    sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF} �� {008000}�������� {FFFFFF}������ ��� {FFFF00}�� '�������� ����'. ", 0xFFFFFF)
	  else
	   	sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF} �� {FF0000}��������� {FFFFFF}������ ��� {FFFF00}�� '�������� ����'. ", 0xFFFFFF)
			removeRecord()
		end
end

function fired(id)
	for i = 1, #array do
		if array[i][1] == id then
			return i
		end
	end
	return -1
end

function checkRecord(id)
	for i = 1, #array do
		if array[i][1] == id then
			if os.clock() - array[i][3] > timeOtkat then
				if array[i][2] == 2 then
					math.randomseed(os.time())
					array[i][4] = math.random(1, 6)
					--print("yacheika " .. array[i][4])
					array[i][3] = os.clock()
					array[i][2] = 0
					return 3
					--break
				else
					math.randomseed(os.time())
					array[i][4] = math.random(1, 6)
					--print("yacheika " .. array[i][4])
					array[i][2] = array[i][2] + 1
					return 2
					--break
				end
			else
				return 1
				--break
			end
		end
	end
	return 0
end

function events.onServerMessage(color, text)
	if (string.find(text,".+%[%d+%].+�������") or string.find(text,".+%[%d+%].+�������")) and fRuletka then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		--print(Nickname)

		lua_thread.create(function()
			math.randomseed(os.time())
			local random = math.random(1, 5)
			wait(100)
			if random == 1 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}�������� ������ ������ � ���������� � ��� ���.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", �� ��������� ������ ������ � ����������� ���")
			elseif random == 2 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}�������� � ��������� �����.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ����������, �� ��������� � ��������� �����")
			elseif random == 3 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}�������� �� �����������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", � ���������, �� ���������")
			elseif random == 4 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}�������� �� �� � �� ����� ��������� ������ ������ � ����. �����.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", �� ���������, �� ������ ��������� ...")
				wait(1200)
				sampSendChat("/s ������ ������ � ��������� �����")
			elseif random == 5 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}�������� ������ ������ ��� ���������������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", �� ������ ������� ������ ������ ...")
				wait(1200)
				sampSendChat("/s � �� ����� �������� �� ������.")
			end
		end)

	elseif (string.find(text,".+%[%d+%].+�������") or string.find(text,".+%[%d+%].+�������")) and fRevolver then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		local id = string.match(text,".+%[(%d+)%].+")
		local check = checkRecord(id)
		lua_thread.create(function()
			if check == 1 then
				wait(100)
				sampSendChat("/s " .. Nickname .. " �� ������������ ��� ��������� � ���� ������")
			elseif check == 2 or check == 3 then
				wait(100)
				sampSendChat("/s ����� " .. Nickname .. " ��������� ������� ����������")
			elseif check == 0 then
				--print(string.match(text,".+%[(%d+)%].+"))
				math.randomseed(os.time())
				table.insert(array, {string.match(text,".+%[(%d+)%].+"), 1, 0, math.random(1, 6)})
				--print("qq yacheika " .. math.random(1, 6))
				--print(array[#array][2])
				wait(100)
				sampSendChat("/s ����� " .. Nickname .. " ��������� ������� ����������")
			end
		end)

			--wait(100)
			--sampSendChat("/c " .. Nickname .. " �� ������������ ��� ��������� � ���� ������")
	elseif (string.find(text,".+%[%d+%].+�������") or string.find(text,".+%[%d+%].+�������")) and fRevolver then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		local id = string.match(text,".+%[(%d+)%].+")
		local check = fired(id)
		lua_thread.create(function()
			if check > 0 then
				if array[check][4] == 1 or array[check][4] == 3 then
					wait(50)
					sampSendChat("/s ����� " .. Nickname .. " ����� �� ����� | ����")
					table.remove(array, check)
					if fRkick then
						wait(100)
						sampSendChat("/akick " .. id .. " �� �����. ���")
						sampAddChatMessage("�� ������� ������ {FF0000}" .. Nickname .. " {ffffff}�� ������. �������: ����. ", 0xffffff)
					end
				else
					wait(50)
					sampSendChat("/s ����� " .. Nickname .. " ����� �� ����� | �������� ")
				end
				--print("record - " .. array[check][4])
			else
				math.randomseed(os.time())
				local random = math.random(1, 6)
				if random == 1 or random == 3 then
					wait(50)
					sampSendChat("/s ����� " .. Nickname .. " ����� �� ����� | ����")
					if fRkick then
						wait(100)
						sampSendChat("/akick " .. id .. " �� �����. ���")
						sampAddChatMessage("�� ������� ������ {FF0000}" .. Nickname .. " {ffffff}�� ������. �������: ����. ", 0xffffff)
					end
				else
					wait(50)
					sampSendChat("/s ����� " .. Nickname .. " ����� �� ����� | ������ ������")
				end
				--print("new - " .. random)
			end
		end)
	elseif (string.find(text,".+%[%d+%].+�������") or string.find(text,".+%[%d+%].+�������")) and fBega then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		--print(Nickname)

		lua_thread.create(function()
			math.randomseed(os.time())
			local random = math.random(1, 10)
			wait(100)
			if random == 1 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}����� 1 ������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ����� 1 ������. ���������")
			elseif random == 2 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 2 ������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 2 ������. ���������")
			elseif random == 3 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 3 ������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 3 ������. ���������")
			elseif random == 4 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 4 ������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 4 ������. ���������")
			elseif random == 5 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 5 �������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 5 �������. ���������")
			elseif random == 6 then
				sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 6 �������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 6 �������. ���������")
			elseif random == 7 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 7 �������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 7 �������. ���������")
			elseif random == 8 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 8 �������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 8 �������. ���������")
			elseif random == 9 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 9 �������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 9 �������. ���������")
			elseif random == 10 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}������ {ffff00}".. Nickname .." {ffffff}������ 10 �������.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", ��� ������ 10 �������. ���������")
			end
		end)
    elseif text:match('**�������� �������� Hanveetz') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Hanveetz') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Hanveetz") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Barbariska') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Barbariska') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Barbariska") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Volward') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Volward') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Volward") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Daiquiri') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Daiquiri') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Daiquiri") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Vadim_$okolov') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Vadim_$okolov') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Vadim_$okolov") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Soorek.') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Soorek.') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Soorek.") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Lia_France') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Lia_France') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Lia_France") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Kurt') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Kurt') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Kurt") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Esketit') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Esketit') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Esketit") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� Endeavour') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Endeavour') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Endeavour") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� Titarenko.') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Titarenko.') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Titarenko.") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� AndreykaDASADO') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� AndreykaDASADO') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� AndreykaDASADO") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� Doremi') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Doremi') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Doremi") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� Hashashin') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� Hashashin') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� Hashashin") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� RusicH') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� RusicH') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� RusicH") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� KpoJluK.') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� KpoJluK.') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "�������� �������� KpoJluK.") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str
    elseif text:match('**�������� �������� skuLL') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� skuLL') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "������������ ����� skuLL") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**������� w4lker') or text:match('**������� W4LKER')  then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**������� w4lker') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "������� �������� w4lker") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str	
    elseif text:match('**�������� �������� desire') then -- ����, � ����� �����������, ������ ���������, ������� ��������� ��� ���� �� ��� �����, ��������
        msg = text:match('**�������� �������� desire') -- �� ������� ��������, ��� ����� ����� ������������� ����, ����� ��������� ���������� ������ �����  '��� ����'
         str = string.gsub (text, msg, "ĳ������� desire") -- � ����� ������ �� �������� ��� ���� �� ���������� msg �� ��� ����� � ���������� ��������
        return {color, str} -- ������ text ���������� str			
	end		
end
