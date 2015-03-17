FreeAllRegions()
DPrint("")

function main()
	createPage1()
	createPage2()
--[[function for the singer page 
		Put this at the top of your function
			SetPage(2)
			FreeAllRegions() --]]
	createButtons()
	SetPage(1)
end

function npow2ratio(n)
	local npow = 1
	while npow < n do 
		npow = npow*2
	end
	return n/npow
end

function makeGreen(region)
	region.t:SetSolidColor(50,200,50,255)
end

function makeWhite(region)
	region.t:SetSolidColor(255,255,255,255)
end

function switchPageOnPress(region)
	SetPage(region.id + 1)
	DPrint("Page " .. region.id + 1)
end

function switchPageOnSwipe(region, x, y, dx, dy)
	if dx > 25 then
		SetPage(1)
	end
end

-- BUTTONS --

btns = {}

function createButtons()
	SetPage(3)
	labels = {"Unison","ii","II","iii","III","IV","v","V","vi","VI","vii","VII","Octave"}
	coords = {{0,0},{0,1},{1,1},{0,2},{1,2},{1,3},{0,4},{1,4},{0,5},{1,5},{0,6},{1,6},{0,7}}
	widths = {1,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1}
	
	bckgrnd = Region()
	bckgrnd:SetWidth(ScreenWidth())
	bckgrnd:SetHeight(ScreenHeight())
	bckgrnd:SetLayer("BACKGROUND")
	bckgrnd.t = bckgrnd:Texture(0, 0, 0, 0)
	bckgrnd:EnableInput(true)
	bckgrnd:Handle("OnMove", switchPageOnSwipe)
	bckgrnd:Show()

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


-- First Page Buttons -- 
page1btns = {}

function createPage1()
	SetPage(1)
	FreeAllRegions()
	
	labels = {"Singer", "Soprano", "Alto", "Tenor", "Baritone", "Bass"}
	coords = {.7, .6, .5, .4, .3, .2}
	
	WriteURLData("http://www.natomasarts.com/wp/wp-content/uploads/2011/07/microphone_black_background2.jpg", "mic.jpg")
	background = Region()
	background.t = background:Texture(DocumentPath("mic.jpg"))
	background:SetWidth(ScreenWidth())
	background:SetHeight(ScreenHeight())
	background.t:SetTexCoord(0, npow2ratio(background.t:Width()), npow2ratio(background.t:Height()), 0)
	background:Show()

	for i=1,6 do 
		local btn = Region()
		btn:SetHeight(40)
		btn.t1 = btn:TextLabel()
		btn.id = i
		btn.t = btn:Texture(50,50,50,100)
		btn.t1:SetLabel(labels[i])
		btn.t1:SetFont("Arial")
		btn.t1:SetFontHeight(20)
		btn:SetAnchor("BOTTOMLEFT", UIParent, "BOTTOMLEFT", ScreenWidth()*.1, ScreenHeight()*coords[i])
		btn:Handle("OnTouchDown", switchPageOnPress)
		btn:EnableInput(true)
		btn:Show()
		
		page1btns[i] = btn
	end
end

function createPage2()
	SetPage(2)
	FreeAllRegions()
	
	--Microphone
	background = Region()
	background.t = background:Texture(DocumentPath("mic.jpg"))
	background:SetWidth(ScreenWidth())
	background:SetHeight(ScreenHeight())
	background.t:SetTexCoord(0, npow2ratio(background.t:Width()), npow2ratio(background.t:Height()), 0)
	background:Show()
	
	background:EnableInput(true)
	background:Handle("OnMove", switchPageOnSwipe)
	
	--Singing Lips
	rLips = Region()
	WriteURLData("http://singingtipsblog.com/wp-content/uploads/2012/07/iStock_000002032735XSmall.jpg","Lips.jpg")
	rLips.t = rLips:Texture(DocumentPath("Lips.jpg"))
	rLips:SetWidth(425)
	rLips:SetHeight(282)
	rLips:Show()
	rLips.t:SetTexCoord(0, npow2ratio(rLips.t:Width()), npow2ratio(rLips.t:Height()), 0.0)
	rLips:SetAnchor("TOPLEFT", background, "TOPLEFT", 0, 0)
	rLips:EnableInput(true)
	--rLips:Handle("OnTouchDown", switchPage)

	--Singer text label
	rtitle = Region()
	rtitle:SetWidth(background:Width()/3)
	rtitle:SetHeight(55)
	rtitle:SetAnchor("CENTER",background,"BOTTOMLEFT",ScreenWidth()/3,ScreenHeight()/3)
	rtitle.tl = rtitle:TextLabel()
	rtitle.tl:SetLabel("Singer")
	rtitle.tl:SetFontHeight(50)
	rtitle.tl:SetColor(255,255,255,255)
	rtitle:Show()
	rtitle:EnableInput(true)
	rtitle:Handle("OnTouchDown", switchPage)
	
end

main()