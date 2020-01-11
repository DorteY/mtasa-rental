--((Developers: DorteY))
--((File: cRental.lua))

local x,y=guiGetScreenSize()
local GUI={Window={},Button={},Label={},Gridlist={},GridItem={}}

function openRentalUI()
	if(not isPedInVehicle(localPlayer))then
		if(not isElement(GUI.Window[1]))then
			showCursor(true)
			GUI.Window[1]=guiCreateWindow(x/2-400/2,y/2-260/2,400,260,"Rental by DorteY",false)
			guiWindowSetSizable(GUI.Window[1],false)
			guiWindowSetMovable(GUI.Window[1],false)
			
			GUI.Gridlist[1]=guiCreateGridList(5,25,160,295,false,GUI.Window[1])
			GUI.GridItem[1]=guiGridListAddColumn(GUI.Gridlist[1],"Vehicle",0.55)
			GUI.GridItem[2]=guiGridListAddColumn(GUI.Gridlist[1],"Price",0.2)
			
			GUI.Button[1]=guiCreateButton(370,20,20,20,"x",false,GUI.Window[1])
			GUI.Label[1]=guiCreateLabel(170,45,240,30,"Here you can rent a vehicle for a limited\ntime.",false,GUI.Window[1])
			GUI.Button[2]=guiCreateButton(180,215,200,35,"Rent vehicle",false,GUI.Window[1])
			
			for i,v in pairs(rentalUIvehicles)do
				local row=guiGridListAddRow(GUI.Gridlist[1])
				guiGridListSetItemText(GUI.Gridlist[1],row,GUI.GridItem[1],i,false,false)
				guiGridListSetItemText(GUI.Gridlist[1],row,GUI.GridItem[2],v,false,false)
			end
			
			
			addEventHandler("onClientGUIClick",GUI.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local selectedVeh=guiGridListGetItemText(GUI.Gridlist[1],guiGridListGetSelectedItem(GUI.Gridlist[1]),1)
						local selectedPrice=tonumber(guiGridListGetItemText(GUI.Gridlist[1],guiGridListGetSelectedItem(GUI.Gridlist[1]),2))
						if(clicked~="")then
							if(selectedPrice~=nil)then
								triggerServerEvent("rent:vehicle",localPlayer,selectedVeh,selectedPrice)
								if(isElement(GUI.Window[1]))then
									showCursor(false)
									destroyElement(GUI.Window[1])
								end
							end
						end
					end
				end,
			false)
			addEventHandler("onClientGUIClick",GUI.Button[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						if(isElement(GUI.Window[1]))then
							showCursor(false)
							destroyElement(GUI.Window[1])
						end
					end
				end,
			false)
		end
	end
end
addEvent("open:rentalUI",true)
addEventHandler("open:rentalUI",root,openRentalUI)