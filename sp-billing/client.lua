QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

Citizen.CreateThread(function()
	-- while QBCore == nil do
	-- 	QBCore = exports['qb-core']:GetCoreObject()
	-- 	Citizen.Wait(0)
    -- end
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
	PlayerData.job = job
end)

function MyInvoices()
	QBCore.Functions.TriggerCallback("sp-billing:GetInvoices", function(invoices)
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'myinvoices',
			invoices = invoices,
			VAT = Config.VATPercentage
		})
	end)
end

function SocietyInvoices(society)
	QBCore.Functions.TriggerCallback("sp-billing:GetSocietyInvoices", function(cb, totalInvoices, totalIncome, totalUnpaid, awaitedIncome)
		if json.encode(cb) ~= '[]' then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'societyinvoices',
				invoices = cb,
				totalInvoices = totalInvoices,
				totalIncome = totalIncome,
				totalUnpaid = totalUnpaid,
				awaitedIncome = awaitedIncome,
				VAT = Config.VATPercentage
			})
		else
			QBCore.Functions.Notify("Компанията ти няма фактури.", 'info')
			SetNuiFocus(false, false)
		end
	end, society)
end



function SocietyBonuses(society)
	QBCore.Functions.TriggerCallback("sp-billing:GetSocietyBonuses", function(cb, totalInvoices)

		if json.encode(cb) ~= '[]' then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'societybonus',
				invoices = cb,
				totalInvoices = totalInvoices
			})
		else
			QBCore.Functions.Notify("Компанията ти няма служители.", 'info')
			SetNuiFocus(false, false)
		end

	end, society)
end

function ShowBonuses(citizenid, society)
	print(citizenid, society)
	QBCore.Functions.TriggerCallback("sp-billing:ShowBonuses", function(cb, totalInvoices, worth)

		if json.encode(cb) ~= '[]' then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'societybonusModal',
				invoices = cb,
				totalInvoices = totalInvoices,
				worth = worth
			})
		else
			QBCore.Functions.Notify("Не са намерени съставени фактури.", 'info')
			SetNuiFocus(false, false)
		end

	end, citizenid, society)

end

function CreateInvoice(society)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'createinvoice',
		society = society
	})
end

-- RegisterCommand(Config.InvoicesCommand, function()
-- 	local isAllowed = false
-- 	local jobName = ""
-- 	for k, v in pairs(Config.AllowedSocieties) do
-- 		if v == PlayerData.job.name then
-- 			jobName = v
-- 			isAllowed = true
-- 		end
-- 	end

-- 	if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss == true and isAllowed then
-- 		SetNuiFocus(true, true)
-- 		SendNUIMessage({
-- 			action = 'mainmenu',
-- 			society = true,
-- 			create = true
-- 		})
-- 	elseif Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss ~= true and isAllowed then
-- 		SetNuiFocus(true, true)
-- 		SendNUIMessage({
-- 			action = 'mainmenu',
-- 			society = false,
-- 			create = true
-- 		})
-- 	elseif not Config.OnlyBossCanAccessSocietyInvoices and isAllowed then
-- 		SetNuiFocus(true, true)
-- 		SendNUIMessage({
-- 			action = 'mainmenu',
-- 			society = true,
-- 			create = true
-- 		})
-- 	elseif not isAllowed then
-- 		SetNuiFocus(true, true)
-- 		SendNUIMessage({
-- 			action = 'mainmenu',
-- 			society = false,
-- 			create = false
-- 		})
-- 	end
-- end, false)

RegisterNetEvent('sp-billing:open:menu', function()
	local isAllowed = false
	local jobName = ""
	for k, v in pairs(Config.AllowedSocieties) do
		if v == PlayerData.job.name then
			jobName = v
			isAllowed = true
		end
	end

	if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss == true and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = true,
			create = true
		})
	elseif Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss ~= true and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = false,
			create = true
		})
	elseif not Config.OnlyBossCanAccessSocietyInvoices and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = true,
			create = true
		})
	elseif not isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = false,
			create = false
		})
	end
end)

RegisterNUICallback("countdays", function(data, cb)

	QBCore.Functions.TriggerCallback("sp-billing:CountDays", function(playerInvoices, totalInvoices)

		if json.encode(cb) ~= '[]' then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'showcount',
				playerInvoices = playerInvoices,
				totalInvoices = totalInvoices
			})
		end

	end, data.citizen, data.startDate, data.endDate, data.society)

	cb('ok')

end)

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		SetNuiFocus(false, false)
	elseif data.action == "payInvoice" then
		TriggerServerEvent("sp-billing:PayInvoice", data.invoice_id)
		SetNuiFocus(false, false)
	elseif data.action == "cancelInvoice" then
		TriggerServerEvent("sp-billing:CancelInvoice", data.invoice_id)
		SetNuiFocus(false, false)
	elseif data.action == "createInvoice" then
		local closestPlayer, playerDistance = QBCore.Functions.GetClosestPlayer()
		target = GetPlayerServerId(closestPlayer)
		data.target = target
		data.society = PlayerData.job.name
		data.society_name = PlayerData.job.label

		if closestPlayer == -1 or playerDistance > 3.0 then
			QBCore.Functions.Notify("Грешка при изпращането! Няма никой около теб.", 'error')
		else
			TriggerServerEvent("sp-billing:CreateInvoice", data)
			QBCore.Functions.Notify("Фактурата е изпратена успешно.", 'success')
		end

		SetNuiFocus(false, false)
	elseif data.action == "missingInfo" then
		QBCore.Functions.Notify("Попълни всички полета, преди да изпратиш фактурата.", 'error')
	elseif data.action == "negativeAmount" then
		QBCore.Functions.Notify("Сумата трябва да е положително число.", 'error')
	elseif data.action == "mainMenuOpenMyInvoices" then
		MyInvoices()
	elseif data.action == "mainMenuOpenSocietyInvoices" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss == true then
					SocietyInvoices(PlayerData.job.label)
				elseif not Config.OnlyBossCanAccessSocietyInvoices then
					SocietyInvoices(PlayerData.job.label)
				elseif Config.OnlyBossCanAccessSocietyInvoices then
					QBCore.Functions.Notify("Само началник може да гледа фирмените фактури.", 'error')
				end
			end
		end
	elseif data.action == "mainMenuOpenBonuses" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss == true then
					SocietyBonuses(PlayerData.job.label)
				elseif not Config.OnlyBossCanAccessSocietyInvoices then
					SocietyBonuses(PlayerData.job.label)
				elseif Config.OnlyBossCanAccessSocietyInvoices then
					QBCore.Functions.Notify("Само началник може изчислява фактури.", 'error')
				end
			end
		end
	elseif data.action == "openBonusesModal" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.isboss == true then
					ShowBonuses(data.citizen, PlayerData.job.label)
				elseif not Config.OnlyBossCanAccessSocietyInvoices then
					ShowBonuses(data.citizen, PlayerData.job.label)
				-- elseif Config.OnlyBossCanAccessSocietyInvoices then
				-- 	QBCore.Functions.Notify("Само началник може изчислява фактури.", 'error')
				end
			end
		end
	elseif data.action == "mainMenuOpenCreateInvoice" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				CreateInvoice(PlayerData.job.label)
			end
		end
	end
end)