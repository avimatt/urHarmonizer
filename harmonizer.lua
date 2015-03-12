FreeAllRegions()

function main()
	createButtons()
end

function makeGreen(region)
	region.t:SetSolidColor(50,200,50,255)
end

function makeWhite(region)
	region.t:SetSolidColor(255,255,255,255)
end

-- BUTTONS --

btns = {}

function createButtons()
	labels = {"Unison","ii","II","iii","III","IV","v","V","vi","VI","vii","VII","Octave"}
	coords = {{0,0},{0,1},{1,1},{0,2},{1,2},{1,3},{0,4},{1,4},{0,5},{1,5},{0,6},{1,6},{0,7}}
	widths = {1,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1}

	btnHeightPadded = ScreenHeight() / 8.0
	btnHeight = btnHeightPadded - 4
	
	for i=1,13 do
		local btn = Region()
		btn.t = btn:Texture("Button-64.png")
		btn.t:SetBlendMode("BLEND")
		width = widths[i]
		btn:SetWidth(ScreenWidth()*width)
		btn:SetHeight(btnHeight)
		coord = coords[i]
		btn:SetAnchor("BOTTOMLEFT", UIParent, "BOTTOMLEFT", coord[1]*(ScreenWidth()/2), coord[2]*btnHeightPadded)
		btn:Show()
		
		btn.tl = btn:TextLabel()
		btn.tl:SetLabel(labels[i])
		btn.tl:SetFontHeight(24)
		
		btn:Handle("OnTouchDown", makeGreen)
		
		btn:EnableInput(true)
		btns[i] = btn
	end
end

main()