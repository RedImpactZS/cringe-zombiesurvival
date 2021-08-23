function GM:OpenThisMenu()
	local panelx = vgui.Create("DPanel")
	local Frame = vgui.Create( "DFrame" )
    local tabs1 = vgui.Create("DPropertySheet", Frame)
	local panel2 = vgui.Create("DPanel", tabs1)
	local panel1 = vgui.Create("DPanel", tabs1)
	
	local Button = vgui.Create("DButton", Frame)

------
	
	Frame:SetTitle( "" )
	Frame:SetDraggable(true)
	Frame:ShowCloseButton(false)
	Frame:SetSize(400, 400 )
	Frame:Center()	
	Frame:SetDeleteOnClose(true)
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0)) -- Draw a red box instead of the frame
	end
-------
	panel1.Paint = function(s, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0))
		draw.RoundedBox(5, 2, 2, w-4, h-4, Color(30, 30, 30))
	end
------
	panel2.Paint = function(s, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0))
		draw.RoundedBox(5, 2, 2, w-4, h-4, Color(30, 30, 30))
	end
------
	tabs1:Dock( FILL )
	tabs1.Paint = function(s, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0))
		draw.RoundedBox(5, 2, 2, w-4, h-4, Color(30, 30, 30))
	end
	tabs1:AddSheet( "test", panel1,  nil)
	tabs1:AddSheet("testt", panel2, nil)
------
	Button:SetIcon("icon16/cross.png")
	Button:SetText("")
	Button:SetTextColor( Color(255,255,255) )
	Button:SetPos(370, 0)
	Button:SetSize( 40, 40 )
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) ) -- Draw a blue button
	end
	Button.DoClick = function()
		Frame:Close()
	end
--------
	local grid = vgui.Create( "DGrid", panel1 )
	grid:SetPos(0, 0 )
	grid:SetCols( 1 )
	grid:SetColWide( 100000 )
--------
	panelx:FocusPrevious()
	panelx:Hide()
	panelx:SetSize(200, 300)
	panelx.Paint = function( self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(30, 30, 30, 240))
		draw.RoundedBox(5, 3, 3, w, h, Color(100, 100, 100, 50))
	end
	local labelX = vgui.Create("DLabel", panelx)
	labelX:SetPos( 40, 40 )
	labelX:SetText( "Hello, world!" )
--------
	function buttonCreate(textt)
		local CreateButton = vgui.Create("DButton")
		CreateButton:SetText(textt)
		CreateButton:SetSize(390, 20)
		grid:AddItem(CreateButton)
		--[[CreateButton.OnReleased = function( s )
			panelx:Hide()
			panelx:KillFocus()
		end
		CreateButton.OnDepressed = function( d )
			panelx:SetPos(gui.MouseX(), gui.MouseY()-300) 
			panelx:Show()
			panelx:MakePopup() 
		end ]]
		
	end	
	
	button1 = buttonCreate("hello world")
	button2 = buttonCreate("hello worl")
	button3 = buttonCreate("hello wor")
	button4 = buttonCreate("hello wo")
	button5 = buttonCreate("hello w")

	local but = vgui.Create( "DButton" )
	but:SetText( "oh my oh my oh my oh my oh my oh my oh my oh my" )
	but:SetSize( 390, 20 )
	grid:AddItem( but )
	but.OnReleased = function( s )
		panelx:Hide()
		panelx:KillFocus()
	end
	but.OnDepressed = function( d )
		panelx:SetPos(gui.MouseX(), gui.MouseY()-300) 
		panelx:Show()
		panelx:MakePopup() 
	end 
	
end