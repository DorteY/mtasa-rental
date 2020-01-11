--((Developers: DorteY))
--((File: sRental.lua))

--((Marker))
local RentalMarker=createMarker(-700,964,12,"cylinder",1.4,200,200,0,200,root)

--((Tables))
local rentVehicleTable={}
local rentVehicleTimerTable={}

--((Functions))
function rentVehicle(typ)
	if(isElementWithinMarker(client,RentalMarker))then
		if(getPlayerMoney(client)>=rentalUIvehicles[typ])then--You can change that to example: if(getElementData(client,"Money")>=price)then
			if(typ and typ~=nil)then
				local x,y,z=getElementPosition(client)
				local rx,ry,rz=getElementRotation(client)
				
				if(isElement(rentVehicleTable[client]))then
					destroyElement(rentVehicleTable[client])
				end
				if(isTimer(rentVehicleTimerTable[client]))then
					killTimer(rentVehicleTimerTable[client])
				end
				if(typ=="Faggio")then
					rentVehicleTable[client]=createVehicle(462,x,y,z,rx,ry,rz)
				elseif(typ=="Tampa")then
					rentVehicleTable[client]=createVehicle(549,x,y,z,rx,ry,rz)
				end
				
				warpPedIntoVehicle(client,rentVehicleTable[client])
				
				rentVehicleTimerTable[client]=setTimer(function(client)
					destroyElement(rentVehicleTable[client])
					if(isTimer(rentVehicleTimerTable[client]))then
						killTimer(rentVehicleTimerTable[client])
					end
					rentVehicleTimerTable[client]=nil
					outputChatBox("You vehicle was destroyed!",client,200,0,0)
				end,20*60*1000,1,client)
				
				setPlayerMoney(client,getPlayerMoney(client)-rentalUIvehicles[typ])
			end
		else
			outputChatBox("You don't have enough money! ($"..rentalUIvehicles[typ]..")",client,200,0,0)
		end
	end
end
addEvent("rent:vehicle",true)
addEventHandler("rent:vehicle",root,rentVehicle)

function openRentalUIfunc(player)
	if(isElement(player))then
		triggerClientEvent(player,"open:rentalUI",player)
	end
end
addEventHandler("onMarkerHit",RentalMarker,openRentalUIfunc)