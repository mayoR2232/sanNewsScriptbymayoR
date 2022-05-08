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
	


	sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}Скрипт для репортеров | Функционал: {FF0000}/shelp {FFFFFF}| Версия: {FF0000}1.5",0xFFFFFF)

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
	sampRegisterChatCommand("moneta", random1) -- Рег. Кмд.
	sampRegisterChatCommand("pred", pred)
	sampRegisterChatCommand("remove", removePred)
	sampRegisterChatCommand("hklav", fklav)
	sampRegisterChatCommand("rull", function()
		fRuletka = not fRuletka
		sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Скрипт для {FFFF00}МП 'Игра на выбывание' | " .. (fRuletka and "{008000}включюн" or "{FF0000}выключен."), -1)
	end)
	sampRegisterChatCommand("bega", Bega)
	Dialog = lua_thread.create_suspended(DialogFunc)
	sampRegisterChatCommand("rrr", Revolver)
	Dialog = lua_thread.create_suspended(DialogFunc)
    sampRegisterChatCommand("rkick", function()
        fRkick = not fRkick
        if fRkick then
            sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}Автокик участников для {FFFF00}МП 'Русская рулетка' | {008000}включен.",0xFFFFFF)
        else
            sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}Автокик участников для {FFFF00}МП 'Русская рулетка' | {FF0000}выключен.",0xFFFFFF)
        end
	end)
	sampRegisterChatCommand('sg',
	  function()
			ini.global.script_state = not ini.global.script_state
			if inicfg.save(ini, 'moonloader\\config\\mayoRhelp.ini') then
			  sampAddChatMessage(ini.global.script_state and '{FF0000}[mayoR*script] {FFFFFF}Автовыкидывание фотоаппарата. Статус: {008000}включен '
				 or '{FF0000}[mayoR*script] {FFFFFF}Автовыкидывание фотоаппарата. Статус: {FF0000}выключен.', -1)

			end
		end)


	while true do


			if fStart then
                 renderFontDrawText(my_font, '{FF0000}Старт для МП:\n{008000}/scs {FFFFFF}- CS\n{008000}/ssv {FFFFFF}- СВ\n{008000}/ssva {FFFFFF}- Смерт.Вечеринка (алчность)\n{008000}/ssvv {FFFFFF}- Смерт.Вечеринка (Выборы)\n{008000}/ssvar {FFFFFF}- Смерт.Вечеринка (Арена)\n{008000}/sboi {FFFFFF}- Бои\n{008000}/spvp {FFFFFF}- PVP\n{008000}/stdm {FFFFFF}- TDM' , 1025,590, 0xFFFFFFFF)

	        end
	        if fKik then
                 renderFontDrawText(my_font, '{FF0000}Кик из ангара:\n{008000}Прицел+H {FFFFFF}- обычный кик\n{008000}Прицел+J {FFFFFF}- проиграл МП\n{008000}Прицел+K {FFFFFF}- выйграл МП\n{008000}Прицел+L {FFFFFF}- нарушение правил МП' , 1025,605, 0xFFFFFFFF)

	        end
	        if fKlav then
                 renderFontDrawText(my_font, 'Горячие клавиши:\n{008000}Клавиша "O" {FFFFFF}- открыть/закрыть ангар.\n{008000}Клавиша "P" {FFFFFF}- выйти из ангара\n{008000}Клавиша "I" {FFFFFF}- закрыть/открыть транспорт.' , 980,665, 0xFFFFFFFF)

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
									sampSendChat("/s Направил пистолет на "  .. PlayerName .. " | Убил")
									if fRkick then
										wait(1500)
										sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}Вы направили пистолет на {FF0000}" .. PlayerName .. " {FFFFFF}| Убили.",0xFFFFFF)
										sampSendChat("/akick "..PlayerId.." Вы убиты. Увы")
									end
								else
								    sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}Вы направили пистолет на {FF0000}" .. PlayerName .. " {FFFFFF}| Промазали.",0xFFFFFF)
									sampSendChat("/s Направил пистолет на "  .. PlayerName .. " | Промазал")
								end
							end
						end
					end


          if isKeyJustPressed(vkeys.VK_O) then
              sampSendChat("/open")
							if MainIni.Main.fWriteMessageAngar then
									sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Вы воспользовались клавишей{008000} 'O'. {FF0000}(Ввожу /open)",0xffffff)
							end
        	end

					if isKeyJustPressed(vkeys.VK_P) then
					    sampSendChat("/exit")
							if MainIni.Main.fWriteMessageAngar then
								sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Вы воспользовались клавишей{008000} 'P'. {FF0000}(Ввожу /exit)",0xffffff)
							end
	        end
					if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_J) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_J) then
						PlayerName = sampGetPlayerNickname(PlayerId)
							sampSendChat("/akick "  .. PlayerId ..  " Вы проиграли. Увы!")
							if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("Вы кикнули игрока {FF0000}" .. PlayerName .. " {ffffff}из ангара. Причина: проиграл. ", 0xffffff)
						    end
						end
					end
					if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_K) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_K) then
						PlayerName = sampGetPlayerNickname(PlayerId)
							sampSendChat("/akick "  .. PlayerId ..  " Вы выйграли. Поздравляю!")
							if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("Вы кикнули игрока {FF0000}" .. PlayerName .. " {ffffff}из ангара. Причина: победитель. ", 0xffffff)
						    end
						end
					end
					if isKeyDown(vkeys.VK_RBUTTON) and isKeyJustPressed(vkeys.VK_L) then
						local PlayerResult, PlayerTarget = getCharPlayerIsTargeting(PLAYER_HANDLE)
						if PlayerResult then PlayerResult, PlayerId = sampGetPlayerIdByCharHandle(PlayerTarget) end
						if PlayerResult and isKeyDown(VK_L) then
						PlayerName = sampGetPlayerNickname(PlayerId)
							sampSendChat("/akick "  .. PlayerId ..  " Нарушение правил мероприятия.")
	 						if MainIni.Main.fWriteMessageAngar then
							sampAddChatMessage("Вы кикнули игрока {FF0000}" .. PlayerName .. " {ffffff}из ангара. Причина: нарушение правил мероприятия. ", 0xffffff)
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
							sampAddChatMessage("Вы кикнули игрока {FF0000} " .. PlayerName .. " {ffffff}из ангара. ", 0xffffff)
						    end
						end
					end
                     if isKeyJustPressed(vkeys.VK_I) then
					    sampSendChat("/lock")
						if MainIni.Main.fWriteMessageAngar then
						sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Вы воспользовались клавишей{008000} 'I'. {FF0000}(Ввожу /lock)",0xffffff)
					    end
					end
                     if isKeyJustPressed(vkeys.VK_Y) then
					    sampSendChat("/unrentcar")
						if MainIni.Main.fWriteMessageAngar then
						sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Вы воспользовались клавишей{008000} 'Y'. {FF0000}(Ввожу /unrentcar)",0xffffff)
					    end
					end
				end
    end
end




function func()
    Dialog:run()
end


function DialogFunc()
sampShowDialog(10, "Функционал скрипта", "{FFFF00}'/poff' {FFFFFF}- отключить оповещения о сделанных действиях.\n{FFFF00}'/bega' {FFFFFF}- включить/выключить скрипт для МП 'Козлиные бега'. \n{FFFF00}'/rull' {FFFFFF}- включить/выключить скрипт для МП 'Игра на выбывание'.\n{FFFF00}'/hstart' {FFFFFF}- выводит на экран команды для стартa мероприятий.\n{FFFF00}'/hklav' {FFFFFF}- выводит на экран горячие клавиши скрипта.\n{FFFF00}'/hkik' {FFFFFF}- выводит на экран клавиши для кика игрока из ангара.\n{FFFF00}'/sg' {FFFFFF}- автовыкидывание фотоаппарата.\n{FFFF00}'/payy [id] [сумма]' {FFFFFF}- автоматически выдает деньги учитывая лимит.\n{FFFF00}'/rr' {FFFFFF}- включить/выключить скрипт для МП 'Русская Рулетка'.\n{FFFF00}'/rkick' {FFFFFF}- автокик проигравшего (Русская рулетка).\n{FF0000}'Прицел на игрока + V' {FFFFFF}- для Русской Рулетки.\n{FF0000}'Прицел на игрока + H' {FFFFFF}- обычный кик с ангара.\n{FF0000}'Прицел на игрока + J' {FFFFFF}- кик с ангара проигравшего.\n{FF0000}'Прицел на игрока + K' {FFFFFF}- кик с ангара победителя.\n{FF0000}'Прицел на игрока + L' {FFFFFF}- кик за нарушение правил МП.\n{008000}'Клавиша O' {FFFFFF}- открыть/закрыть ангар.\n{008000}'Клавиша P' {FFFFFF}- выйти из ангара.\n{008000}'Клавиша I' {FFFFFF}- открыть/закрыть личный транспорт.\n{008000}'Клавиша Y' {FFFFFF}- отказаться от аренды транспорта.\n{FFFF00}'/scs' {FFFFFF}- старт для CS.\n{FFFF00}'/ssv' {FFFFFF}- старт для СВ.\n{FFFF00}'/spvp' {FFFFFF}- старт для PvP.\n{FFFF00}'/sboi' {FFFFFF}- старт для Боев.\n{FFFF00}'/stdm' {FFFFFF}- старт для ТДМ.\n{FFFF00}'/ssval' {FFFFFF}- смертельная вечеринка (алчность).\n{FFFF00}'/ssvv' {FFFFFF}- смертельная вечеринка (выборы на выборы).\n{FFFF00}'/ssvar' {FFFFFF}- смертельная вечеринка (арена).\n                                                                                          с любовью от mayoR","Закрыть")
end

function ssval()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/c Перед вами чемодан с деньгами.")
        wait(2000)
        sampSendChat("/me показал чемодан участникам")
        wait(2250)
		sampSendChat("/c Каждый из вас должен взять сумму от 0 до 1000$.")
		wait(2000)
		sampSendChat("/c Игрок, взявший большее количество денег - проиграл.")
		wait(1500)
		sampSendChat("/c Игрок, взявший меньшее количество денег - проиграл.")
		wait(2000)
		sampSendChat("/c Жду ваши суммы у себя в /pm!")
    end)
end

function random1() -- Cmd
    lua_thread.create(function()
    math.randomseed(os.time())
    local random = math.random(1, 2)
        if random == 1 then -- Если выпало число 0, то
		wait(100)
        sampSendChat("/s Достал монету и подкинул. | Результат: орел")
        elseif random == 2 then -- Если 1, то
		wait(100)
        sampSendChat("/s Достал монету и подкинул. | Результат: решка")
		end
    end)
end

function ssvv()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/c Перед вами чемодан с деньгами.")
        wait(2000)
        sampSendChat("/me показал чемодан с деньгами.")
        wait(2250)
		sampSendChat("/c Каждый должен сделать выбор. Возьмет он деньги или нет.")
		wait(2000)
		sampSendChat("/c Если все игроки взяли деньги - все умирают.")
		wait(1500)
		sampSendChat("/c Если двое игроков взяли, а третий нет, то он умирает.")
		wait(2000)
		sampSendChat("/c Если все игроки отказались от денег - проходят все.")
		wait(2000)
		sampSendChat("/c Жду ваши ответы у себя в /pm. Выбор за вами!")
    end)
end

function scs()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Counter-Strike | Через 20 секунд будет старт мероприятия.")
        wait(15000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 160")
        sampSendChat("/news Counter-Strike | Старт. Желаю удачи!")
    end)
end


function ssv()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Смертельный Выстрел | Через 20 секунд будет старт мероприятия.")
        wait(15000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 45")
        sampSendChat("/news Cмертельный Выстрел | Старт. Желаю удачи!")
    end)
end

function sboi()

    lua_thread.create(function()
        PlayerName = sampGetPlayerNickname(PlayerId)
        sampSendChat("/news Бои | Участники, встаем по углам. Старт через 10 секунд")
        wait(5000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 100")
        sampSendChat("/s Бои | Старт. Желаю удачи!")
    end)


end

function spvp()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Player vs Player | Через 10 секунд будет старт. Готовность!")
        wait(5000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 160")
        sampSendChat("/s Player vs Player | Старт. Желаю удачи!")
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
			sampSendChat("/news Игрок ".. sampGetPlayerNickname(param) .." получает ".. predArray[param] .."/3 предупреждения. ")
			--print(predArray[param])
			--removePred()
		elseif predArray[param] == 1 then
			predArray[param] = 2
			sampSendChat("/news Игрок ".. sampGetPlayerNickname(param) .." получает ".. predArray[param] .."/3 предупреждения. ")
		elseif predArray[param] == 2 then
			predArray[param] = 3
			lua_thread.create(function()
				sampSendChat("/news Игрок ".. sampGetPlayerNickname(param) .." получает ".. predArray[param] .."/3 предупреждения. ")
				predArray[param] = nil
				wait(1500)
				sampSendChat("/akick " .. param .. " 3/3 предупреждения")
			end)
		end
		print(predArray[param])

	end
end

function stdm()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/news Team Death Math | Через 20 секунд будет старт. Готовность!")
        wait(15000)
        sampSendChat("/sncount")
        wait(6500)
        sampSendChat("/snhp 160")
        sampSendChat("/s Team Death Math | Старт. Желаю удачи!")
    end)
end

function ssvar()
    lua_thread.create(function()
        wait(1000)
        sampSendChat("/c Поздравляю с 3 раундом. В этом раунде ваша задача")
        wait(1500)
        sampSendChat("/c Заключается в том, что вам нужно написать мне в /pm")
        wait(1500)
        sampSendChat("/c Хотите вы убить, защититься или просто забрать деньги")
		wait(1500)
        sampSendChat("/с Если решили убить/защититься, то нужна конкретика")
		wait(1500)
		sampSendChat("/с Пример: защищаюсь(или убиваю) от ID:0")
		wait(1500)
		sampSendChat("/c Если вы атаковали игрока, а он защитился - вы выбываете")
		wait(1500)
		sampSendChat("/c Если вы защитись от игрока, а он не атаковал вас - выбываете")
		wait(1500)
		sampSendChat("/c Если все взяли деньги - выбываете все")
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
            sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF}Вы передали игроку {FFFF00}" .. name1 .." : {008000}" .. colvo .. "$", -1)
            colvo = 0
        end)
    else
        sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF} Ошибка! Следуйте форме: {FF0000}/payy [id] [сумма]", -1)
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
		sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Оповещения о сделаных действиях были {008000}включены.", 0xffffff)
	else
		sampAddChatMessage("{FF0000}[mayoR*script] {ffffff}Оповещения о сделаных действиях были {FF0000}отключены.", 0xffffff)
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
	    sampSendChat("/me достал револьвер | Заряжено 2/6 патрон")
	  else
	   	sampSendChat("/me сложил пули и убрал револьвер")
			removeRecord()
		end
end

function Bega()
	fBega = not fBega
    if fBega then
	    sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF} Вы {008000}включили {FFFFFF}скрипт для {FFFF00}МП 'Козлиные бега'. ", 0xFFFFFF)
	  else
	   	sampAddChatMessage("{FF0000}[mayoR*script] {FFFFFF} Вы {FF0000}выключили {FFFFFF}скрипт для {FFFF00}МП 'Козлиные бега'. ", 0xFFFFFF)
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
	if (string.find(text,".+%[%d+%].+Открыть") or string.find(text,".+%[%d+%].+открыть")) and fRuletka then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		--print(Nickname)

		lua_thread.create(function()
			math.randomseed(os.time())
			local random = math.random(1, 5)
			wait(100)
			if random == 1 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}выбирает любого игрока и устраивает с ним бои.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вы выбираете любого игрока и устраиваете бои")
			elseif random == 2 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}проходит в следующий раунд.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", поздравляю, вы проходите в следующий раунд")
			elseif random == 3 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}выбывает из мероприятия.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", к сожалению, вы выбываете")
			elseif random == 4 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}выбывает из МП и он может отправить любого игрока в след. раунд.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вы выбываете, но можете отправить ...")
				wait(1200)
				sampSendChat("/s Любого игрока в следующий раунд")
			elseif random == 5 then
			    sampAddChatMessage("[mayoR*script] {ffff00}".. Nickname .." {ffffff}выбирает любого игрока для дисквалифисации.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вы должны выбрать любого игрока ...")
				wait(1200)
				sampSendChat("/s И он будет исключен из ангара.")
			end
		end)

	elseif (string.find(text,".+%[%d+%].+Крутить") or string.find(text,".+%[%d+%].+крутить")) and fRevolver then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		local id = string.match(text,".+%[(%d+)%].+")
		local check = checkRecord(id)
		lua_thread.create(function()
			if check == 1 then
				wait(100)
				sampSendChat("/s " .. Nickname .. " вы использовали все прокрутки в этом раунде")
			elseif check == 2 or check == 3 then
				wait(100)
				sampSendChat("/s Игрок " .. Nickname .. " прокрутил барабан револьвера")
			elseif check == 0 then
				--print(string.match(text,".+%[(%d+)%].+"))
				math.randomseed(os.time())
				table.insert(array, {string.match(text,".+%[(%d+)%].+"), 1, 0, math.random(1, 6)})
				--print("qq yacheika " .. math.random(1, 6))
				--print(array[#array][2])
				wait(100)
				sampSendChat("/s Игрок " .. Nickname .. " прокрутил барабан револьвера")
			end
		end)

			--wait(100)
			--sampSendChat("/c " .. Nickname .. " вы использовали все прокрутки в этом раунде")
	elseif (string.find(text,".+%[%d+%].+Выстрел") or string.find(text,".+%[%d+%].+выстрел")) and fRevolver then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		local id = string.match(text,".+%[(%d+)%].+")
		local check = fired(id)
		lua_thread.create(function()
			if check > 0 then
				if array[check][4] == 1 or array[check][4] == 3 then
					wait(50)
					sampSendChat("/s Игрок " .. Nickname .. " нажал на курок | Убит")
					table.remove(array, check)
					if fRkick then
						wait(100)
						sampSendChat("/akick " .. id .. " Вы убиты. Увы")
						sampAddChatMessage("Вы кикнули игрока {FF0000}" .. Nickname .. " {ffffff}из ангара. Причина: убит. ", 0xffffff)
					end
				else
					wait(50)
					sampSendChat("/s Игрок " .. Nickname .. " нажал на курок | Промазал ")
				end
				--print("record - " .. array[check][4])
			else
				math.randomseed(os.time())
				local random = math.random(1, 6)
				if random == 1 or random == 3 then
					wait(50)
					sampSendChat("/s Игрок " .. Nickname .. " нажал на курок | Убит")
					if fRkick then
						wait(100)
						sampSendChat("/akick " .. id .. " Вы убиты. Увы")
						sampAddChatMessage("Вы кикнули игрока {FF0000}" .. Nickname .. " {ffffff}из ангара. Причина: убит. ", 0xffffff)
					end
				else
					wait(50)
					sampSendChat("/s Игрок " .. Nickname .. " нажал на курок | Пустая ячейка")
				end
				--print("new - " .. random)
			end
		end)
	elseif (string.find(text,".+%[%d+%].+Прыгать") or string.find(text,".+%[%d+%].+прыгать")) and fBega then
		local Nickname = string.match(text,"(%S+)%[%d+%].+")
		--print(Nickname)

		lua_thread.create(function()
			math.randomseed(os.time())
			local random = math.random(1, 10)
			wait(100)
			if random == 1 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпал 1 прыжок.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпал 1 прыжок. Начинайте")
			elseif random == 2 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 2 прыжка.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 2 прыжка. Начинайте")
			elseif random == 3 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 3 прыжка.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 3 прыжка. Начинайте")
			elseif random == 4 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 4 прыжка.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 4 прыжка. Начинайте")
			elseif random == 5 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 5 прыжков.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 5 прыжков. Начинайте")
			elseif random == 6 then
				sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 6 прыжков.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 6 прыжков. Начинайте")
			elseif random == 7 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 7 прыжков.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 7 прыжков. Начинайте")
			elseif random == 8 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 8 прыжков.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 8 прыжков. Начинайте")
			elseif random == 9 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 9 прыжков.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 9 прыжков. Начинайте")
			elseif random == 10 then
			    sampAddChatMessage("[mayoR*script] {FFFFFF}Игроку {ffff00}".. Nickname .." {ffffff}выпало 10 прыжков.",0xFF0000)
				sampSendChat("/s " .. Nickname .. ", вам выпало 10 прыжков. Начинайте")
			end
		end)
    elseif text:match('**Продюсер Телесети Hanveetz') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Hanveetz') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Hanveetz") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Barbariska') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Barbariska') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Barbariska") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Volward') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Volward') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Volward") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Daiquiri') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Daiquiri') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Daiquiri") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Vadim_$okolov') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Vadim_$okolov') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Vadim_$okolov") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Soorek.') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Soorek.') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Soorek.") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Lia_France') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Lia_France') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Lia_France") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Kurt') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Kurt') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Kurt") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Esketit') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Esketit') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Esketit") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети Endeavour') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Endeavour') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Endeavour") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Продюсер Телесети Titarenko.') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Titarenko.') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Titarenko.") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Продюсер Телесети AndreykaDASADO') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети AndreykaDASADO') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность AndreykaDASADO") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Продюсер Телесети Doremi') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Doremi') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Doremi") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Продюсер Телесети Hashashin') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети Hashashin') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность Hashashin") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Продюсер Телесети RusicH') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети RusicH') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность RusicH") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Продюсер Телесети KpoJluK.') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети KpoJluK.') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Почетная личность KpoJluK.") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str
    elseif text:match('**Продюсер Телесети skuLL') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Продюсер Телесети skuLL') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Непризнанный почет skuLL") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Новичок w4lker') or text:match('**Новичок W4LKER')  then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Новичок w4lker') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Рядовой компании w4lker") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str	
    elseif text:match('**Редактор Телесети desire') then -- окей, с агром разобрались, теперь посложнее, заменим сообщение Как дела на Как жизнь, допустим
        msg = text:match('**Редактор Телесети desire') -- мы сделали проверку, что такой текст действительно есть, затем присвоили переменную именно части  'как дела'
         str = string.gsub (text, msg, "Дівчисько desire") -- в самом тексте мы заменяем Как дела из переменной msg на Как жизнь и возвращаем значения
        return {color, str} -- вместо text возвращаем str			
	end		
end
