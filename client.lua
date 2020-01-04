local webview = nil

function ShowPanel()
	if (webview ~= nil) then
		return
	end

	webview = CreateWebUI(0.0, 0.0, 0.0, 0.0)
	LoadWebFile(webview, "http://asset/"..GetPackageName().."/ui/index.html")
	SetWebAlignment(webview, 0.0, 0.0)
	SetWebAnchors(webview, 0.0, 0.0, 1.0, 1.0)		
	SetWebVisibility(webview, WEB_HIDDEN)
end
AddRemoteEvent("characterize:ShowPanel", ShowPanel)

function OnWebLoadComplete(webid)
	if webview == webid then
		CallRemoteEvent("characterize:GetOptions")
	end
end
AddEvent("OnWebLoadComplete", OnWebLoadComplete)

function SetOptions(bodyOptions, shirtOptions, pantOptions, shoeOptions, hairOptions, hairColorOptions)
	ExecuteWebJS(webview, "SetCharacterOptions('body', '".. bodyOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('hair', '".. hairOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('hair_color', '".. hairColorOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('shirt', '".. shirtOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('pants', '".. pantOptions .."')")
	ExecuteWebJS(webview, "SetCharacterOptions('shoes', '".. shoeOptions .."')")

	ShowMouseCursor(true)
	SetIgnoreMoveInput(true);
	SetInputMode(INPUT_GAMEANDUI)
	SetWebVisibility(webview, WEB_VISIBLE)

	SetCameraLocation(700,0,0,false)
	SetCameraRotation(0,180,0,false)
end
AddRemoteEvent("characterize:SetOptions", SetOptions)

function HidePanel()
	SetWebVisibility(webview, WEB_HIDDEN)
	DestroyWebUI(webview)
	webview = nil
	ShowMouseCursor(false)
	SetIgnoreMoveInput(false);
	SetInputMode(INPUT_GAME)

   	SetCameraLocation(0, 0, 0, false)
	SetCameraRotation(0, 0, 0, false)
end
AddEvent("characterize:HidePanel", HidePanel)

function Change(type, value)
	local player = GetPlayerId()
	if (type == 'body') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Body")
		SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
		SkeletalMeshComponent:SetFloatParameterOnMaterials("PupilScale", 1.3)
	elseif (type == 'hair') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing0")
    	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
	elseif (type == 'shirt') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing1")
    	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
	elseif (type == 'pants') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing4")
    	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
	elseif (type == 'shoes') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing5")
    	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(value))
	elseif (type == 'hair_color') then
		local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(player, "Clothing0")
		local r, g, b, a = HexToRGBAFloat("0x"..value)
		SkeletalMeshComponent:SetColorParameterOnMaterials("Hair Color", FLinearColor(r, g, b, a))
	end

	CreateSound("click.wav")
end
AddEvent("characterize:Change", Change)

function Submit(params)
	CallRemoteEvent('characterize:Submit', params);
	CallEvent("characterize:HidePanel")
end
AddEvent("characterize:Submit", Submit)
