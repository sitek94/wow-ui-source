CURRENT_ACTIONBAR_PAGE = 1;
NUM_ACTIONBAR_PAGES = 6;
NUM_ACTIONBAR_BUTTONS = 12;
NUM_OVERRIDE_BUTTONS = 6;
ATTACK_BUTTON_FLASH_TIME = 0.4;

BOTTOMLEFT_ACTIONBAR_PAGE = 6;
BOTTOMRIGHT_ACTIONBAR_PAGE = 5;
LEFT_ACTIONBAR_PAGE = 4;
RIGHT_ACTIONBAR_PAGE = 3;
RANGE_INDICATOR = "●";

MULTIBAR_5_ACTIONBAR_PAGE = 13;
MULTIBAR_6_ACTIONBAR_PAGE = 14;
MULTIBAR_7_ACTIONBAR_PAGE = 15;

COOLDOWN_TYPE_LOSS_OF_CONTROL = 1;
COOLDOWN_TYPE_NORMAL = 2;

-- Table of actionbar pages and whether they're viewable or not
VIEWABLE_ACTION_BAR_PAGES = {1, 1, 1, 1, 1, 1};

ACTION_HIGHLIGHT_MARKS = { };
ON_BAR_HIGHLIGHT_MARKS = { };

ACTION_BUTTON_SHOW_GRID_REASON_CVAR = 1;
ACTION_BUTTON_SHOW_GRID_REASON_EVENT = 2;
ACTION_BUTTON_SHOW_GRID_REASON_SPELLBOOK = 4;

function IsOnPrimaryActionBar(action)
	return action >= 1 and action <= NUM_ACTIONBAR_BUTTONS;
end

function MarkNewActionHighlight(action)
	ACTION_HIGHLIGHT_MARKS[action] = true;
end

function ClearNewActionHighlight(action, preventIdenticalActionsFromClearing)
	ACTION_HIGHLIGHT_MARKS[action] = nil;

	if preventIdenticalActionsFromClearing then
		return;
	end

	-- If we're unhighlighting this one because it was used/moused over/etc...
	-- then go find all other current actions that match this one that are also
	-- marked for highlight and unmark them.  The next time they update the highlight
	-- will update; may need to actually force update the action button in some cases
	-- and that means that ACTION_HIGHLIGHT_MARKS needs to store more information
	local unmarkedType, unmarkedID = GetActionInfo(action);

	for actionKey, markValue in pairs(ACTION_HIGHLIGHT_MARKS) do
		if markValue then
			local actionType, actionID = GetActionInfo(actionKey);
			if actionType == unmarkedType and actionID == unmarkedID then
				ACTION_HIGHLIGHT_MARKS[actionKey] = nil;
			end
		end
	end
end

function GetNewActionHighlightMark(action)
	return ACTION_HIGHLIGHT_MARKS[action];
end

function ClearOnBarHighlightMarks()
	ON_BAR_HIGHLIGHT_MARKS = {};
end

function GetOnBarHighlightMark(action)
	return ON_BAR_HIGHLIGHT_MARKS[action];
end

local function UpdateOnBarHighlightMarks(actionButtonSlots)
	if actionButtonSlots then
		ON_BAR_HIGHLIGHT_MARKS = tInvert(actionButtonSlots);
	else
		ClearOnBarHighlightMarks();
	end
end

function UpdateOnBarHighlightMarksBySpell(spellID)
	UpdateOnBarHighlightMarks(C_ActionBar.FindSpellActionButtons(spellID));
end

function UpdateOnBarHighlightMarksByFlyout(flyoutID)
	UpdateOnBarHighlightMarks(C_ActionBar.FindFlyoutActionButtons(flyoutID));
end

function UpdateOnBarHighlightMarksByPetAction(petAction)
	UpdateOnBarHighlightMarks(C_ActionBar.FindPetActionButtons(petAction));
end

function GetActionButtonForID(id)
	if OverrideActionBar and OverrideActionBar:IsShown() then
		if id > NUM_OVERRIDE_BUTTONS then
			return;
		end

		return _G["OverrideActionBarButton"..id];
	end

	return _G["ActionButton"..id];
end

function TryUseActionButton(self, checkingFromDown)
	local isKeyPress = true;
	local isSecureAction = true;
	local usedActionButton = SecureActionButton_OnClick(self, "LeftButton", checkingFromDown, isKeyPress, isSecureAction);
	if usedActionButton then
		if GetNewActionHighlightMark(self.action) then
			ClearNewActionHighlight(self.action);
			self:UpdateHighlightMark();
		end
	end
	self:UpdateState();
end

local isInPetBattle = C_PetBattles.IsInBattle;
local function CheckPetActionButtonEvent(id, isDown)
	if isInPetBattle() and PetBattleFrame then
		if isDown then
			PetBattleFrame_ButtonDown(id);
		else
			PetBattleFrame_ButtonUp(id);
		end
		return true;
	end

	return false;
end

function ActionButtonDown(id)
	if CheckPetActionButtonEvent(id, true) then
		return;
	end

	local button = GetActionButtonForID(id);
	if button then
		if button:GetButtonState() == "NORMAL" then
			button:SetButtonState("PUSHED");
		end

		TryUseActionButton(button, true);
	end
end

function ActionButtonUp(id)
	if CheckPetActionButtonEvent(id, false) then
		return;
	end

	local button = GetActionButtonForID(id);
	if button then
		if ( button:GetButtonState() == "PUSHED" ) then
			button:SetButtonState("NORMAL");
			TryUseActionButton(button, false);
		end
	end
end

function ActionBar_PageUp()
	local nextPage;
	for i=GetActionBarPage() + 1, NUM_ACTIONBAR_PAGES do
		if ( VIEWABLE_ACTION_BAR_PAGES[i] ) then
			nextPage = i;
			break;
		end
	end

	if ( not nextPage ) then
		nextPage = 1;
	end
	ChangeActionBarPage(nextPage);
end

function ActionBar_PageDown()
	local prevPage;
	for i=GetActionBarPage() - 1, 1, -1 do
		if ( VIEWABLE_ACTION_BAR_PAGES[i] ) then
			prevPage = i;
			break;
		end
	end

	if ( not prevPage ) then
		for i=NUM_ACTIONBAR_PAGES, 1, -1 do
			if ( VIEWABLE_ACTION_BAR_PAGES[i] ) then
				prevPage = i;
				break;
			end
		end
	end
	ChangeActionBarPage(prevPage);
end

ActionBarButtonEventsFrameMixin = {};

function ActionBarButtonEventsFrameMixin:OnLoad()
	self.frames = {};
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	self:RegisterEvent("UPDATE_BINDINGS");
	self:RegisterEvent("GAME_PAD_ACTIVE_CHANGED");
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	self:RegisterEvent("PET_BAR_UPDATE");
	self:RegisterUnitEvent("UNIT_FLAGS", "pet");
	self:RegisterUnitEvent("UNIT_AURA", "pet");
	self:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED");
end

function ActionBarButtonEventsFrameMixin:OnEvent(event, ...)
	-- pass event down to the buttons
	for k, frame in pairs(self.frames) do
		frame:OnEvent(event, ...);
	end
end

function ActionBarButtonEventsFrameMixin:RegisterFrame(frame)
	tinsert(self.frames, frame);
end

ActionBarActionEventsFrameMixin = {};

function ActionBarActionEventsFrameMixin:OnLoad()
	self.frames = {};
	--self:RegisterEvent("ACTIONBAR_UPDATE_STATE");			not updating state from lua anymore, see SetActionUIButton
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	--self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");		not updating cooldown from lua anymore, see SetActionUIButton
	self:RegisterEvent("SPELL_UPDATE_CHARGES");
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("TRADE_SKILL_SHOW");
	self:RegisterEvent("TRADE_SKILL_CLOSE");
	self:RegisterEvent("ARCHAEOLOGY_CLOSED");
	self:RegisterEvent("PLAYER_ENTER_COMBAT");
	self:RegisterEvent("PLAYER_LEAVE_COMBAT");
	self:RegisterEvent("START_AUTOREPEAT_SPELL");
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	self:RegisterEvent("UNIT_ENTERED_VEHICLE");
	self:RegisterEvent("UNIT_EXITED_VEHICLE");
	self:RegisterEvent("COMPANION_UPDATE");
	self:RegisterEvent("UNIT_INVENTORY_CHANGED");
	self:RegisterEvent("LEARNED_SPELL_IN_TAB");
	self:RegisterEvent("PET_STABLE_UPDATE");
	self:RegisterEvent("PET_STABLE_SHOW");
	self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
	self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE");
	self:RegisterEvent("UPDATE_SUMMONPETS_ACTION");
	self:RegisterEvent("LOSS_OF_CONTROL_ADDED");
	self:RegisterEvent("LOSS_OF_CONTROL_UPDATE");
	self:RegisterEvent("SPELL_UPDATE_ICON");
end

function ActionBarActionEventsFrameMixin:OnEvent(event, ...)
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		local unit = ...;
		if ( unit == "player" and self.tooltipOwner and GameTooltip:GetOwner() == self.tooltipOwner ) then
			self.tooltipOwner:SetTooltip();
		end
	else
		for k, frame in pairs(self.frames) do
			frame:OnEvent(event, ...);
		end
	end
end

function ActionBarActionEventsFrameMixin:RegisterFrame(frame)
	self.frames[frame] = frame;
end

function ActionBarActionEventsFrameMixin:UnregisterFrame(frame)
	self.frames[frame] = nil;
end

ActionBarActionButtonMixin = {};

function ActionBarActionButtonMixin:OnLoad()
	self.SetButtonStateBase = self.SetButtonState;
	self.SetButtonState = self.SetButtonStateOverride;

	self.flashing = 0;
	self.flashtime = 0;
	self:SetAttribute("type", "action");
	self:SetAttribute("typerelease", "actionrelease");
	self:SetAttribute("checkselfcast", true);
	self:SetAttribute("checkfocuscast", true);
	self:SetAttribute("checkmouseovercast", true);
	self:SetAttribute("useparent-unit", true);
	self:SetAttribute("useparent-actionpage", true);
	self:RegisterForDrag("LeftButton", "RightButton");
	self:RegisterForClicks("AnyUp", "LeftButtonDown", "RightButtonDown");
	ActionBarButtonEventsFrame:RegisterFrame(self);
	self:UpdateAction();
	self:UpdateHotkeys(self.buttonType);

	self.QuickKeybindHighlightTexture:ClearAllPoints();
	self.QuickKeybindHighlightTexture:SetPoint("TOPLEFT");
	self.QuickKeybindHighlightTexture:SetSize(46, 45);
end

function ActionBarActionButtonMixin:UpdateHotkeys(actionButtonType)
	local id;
    if ( not actionButtonType ) then
        actionButtonType = "ACTIONBUTTON";
		id = self:GetID();
	else
		if ( actionButtonType == "MULTICASTACTIONBUTTON" ) then
			id = self.buttonIndex;
		else
			id = self:GetID();
		end
    end

    local hotkey = self.HotKey;
    local key = GetBindingKey(actionButtonType..id) or
                GetBindingKey("CLICK "..self:GetName()..":LeftButton");

	local text = GetBindingText(key, 1);
    if ( text == "" ) then
        hotkey:SetText(RANGE_INDICATOR);
        hotkey:Hide();
    else
		local frameWidth, frameHeight = self:GetSize();
		if ( IsBindingForGamePad(key) ) then
			-- Allow gamepad binding to go all the way across and overlap the border for more space
			hotkey:SetSize(frameWidth, 16);
			hotkey:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0);
		else
			-- Tuck in KBM binding a bit to be inside the border
			hotkey:SetSize(frameWidth-8, 10);
			hotkey:SetPoint("TOPRIGHT", self, "TOPRIGHT", -4, -5);
		end
        hotkey:SetText(text);
        hotkey:Show();
    end
end

function ActionBarActionButtonMixin:UpdatePressAndHoldAction()
	local pressAndHoldAction = false;

	if self.action then
		local actionType, id = GetActionInfo(self.action);
		if actionType == "spell" then
			pressAndHoldAction = IsPressHoldReleaseSpell(id);
		elseif actionType == "macro" then
			local spellID = GetMacroSpell(id);
			if spellID then
				pressAndHoldAction = IsPressHoldReleaseSpell(spellID);
			end
		end
	end

	self:SetAttribute("pressAndHoldAction", pressAndHoldAction);
end

function ActionBarActionButtonMixin:OnAttributeChanged(name, value)
	self:UpdateAction();
end

function ActionBarActionButtonMixin:UpdateAction(force)
	local action = self:CalculateAction();
	if ( action ~= self.action or force ) then
		self.action = action;
		SetActionUIButton(self, action, self.cooldown);
		self:Update();

		-- If on an action bar and layout fields are set, ask  it to update visibility of its buttons
		local actionBar = self:GetParent();
		if (self.index and actionBar and actionBar.UpdateShownButtons) then
			actionBar:UpdateShownButtons();
			actionBar:UpdateGridLayout();
		end
	end
end

function ActionBarActionButtonMixin:Update()
	local action = self.action;
	local icon = self.icon;
	local buttonCooldown = self.cooldown;
	local texture = GetActionTexture(action);

	icon:SetDesaturated(false);
	local type, id = GetActionInfo(action);
	if ( HasAction(action) ) then
		if ( not self.eventsRegistered ) then
			ActionBarActionEventsFrame:RegisterFrame(self);
			self.eventsRegistered = true;
		end
		self:UpdateState();
		self:UpdateUsable();
		ActionButton_UpdateCooldown(self);
		self:UpdateFlash();
		self:UpdateHighlightMark();
		self:UpdateSpellHighlightMark();
	else
		if ( self.eventsRegistered ) then
			ActionBarActionEventsFrame:UnregisterFrame(self);
			self.eventsRegistered = nil;
		end

		buttonCooldown:Hide();

		ClearChargeCooldown(self);

		self:ClearFlash();
		self:SetChecked(false);

		if self.LevelLinkLockIcon then
			self.LevelLinkLockIcon:SetShown(false);
		end
	end

	self:UpdatePressAndHoldAction();

	-- Add a green border if button is an equipped item
	local border = self.Border;
	if border then
		if ( IsEquippedAction(action) ) then
			border:SetVertexColor(0, 1.0, 0, 0.5);
			border:Show();
		else
			border:Hide();
		end
	end

	-- Update Action Text
	local actionName = self.Name;
	if actionName then
		if ( not IsConsumableAction(action) and not IsStackableAction(action) and (IsItemAction(action) or GetActionCount(action) == 0) ) then
			actionName:SetText(GetActionText(action));
		else
			actionName:SetText("");
		end
	end

	-- Update icon and hotkey text
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		self.rangeTimer = -1;
		self:UpdateCount();
	else
		self.Count:SetText("");
		icon:Hide();
		buttonCooldown:Hide();
		self.rangeTimer = nil;
		local hotkey = self.HotKey;
        if ( hotkey:GetText() == RANGE_INDICATOR ) then
			hotkey:Hide();
		else
			hotkey:SetVertexColor(ACTIONBAR_HOTKEY_FONT_COLOR:GetRGB());
		end
	end

	-- Update flyout appearance
	self:UpdateFlyout();

	self:UpdateOverlayGlow();

	-- Update tooltip
	if ( GameTooltip:GetOwner() == self ) then
		self:SetTooltip();
	end

	self.feedback_action = action;
end

function ActionBarActionButtonMixin:UpdateHighlightMark()
	if ( self.NewActionTexture ) then
		self.NewActionTexture:SetShown(GetNewActionHighlightMark(self.action)); -- TODO: Should bindings support this, or should we force SetShown to take a bool?
	end
end

-- Shared between the action bar and the pet bar.
function SharedActionButton_RefreshSpellHighlight(button, shown)
	if ( shown ) then
		button.SpellHighlightTexture:Show();
		button.SpellHighlightAnim:Play();
	else
		button.SpellHighlightTexture:Hide();
		button.SpellHighlightAnim:Stop();
	end
end

function ActionBarActionButtonMixin:UpdateSpellHighlightMark()
	if ( self.SpellHighlightTexture and self.SpellHighlightAnim ) then
		SharedActionButton_RefreshSpellHighlight(self, GetOnBarHighlightMark(self.action));
	end
end

function ActionBarActionButtonMixin:HasAction()
    return HasAction(self.action);
end

function ActionBarActionButtonMixin:UpdateState()
	local action = self.action;
	local isChecked = (IsCurrentAction(action) or IsAutoRepeatAction(action)) and not C_ActionBar.IsAutoCastPetAction(action);
	self:SetChecked(isChecked);
end

function ActionBarActionButtonMixin:UpdateUsable()
	local icon = self.icon;

	local isUsable, notEnoughMana = IsUsableAction(self.action);
	if ( isUsable ) then
		icon:SetVertexColor(1.0, 1.0, 1.0);
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
	end

	local isLevelLinkLocked = C_LevelLink.IsActionLocked(self.action);
	if not icon:IsDesaturated() then
		icon:SetDesaturated(isLevelLinkLocked);
	end

	if self.LevelLinkLockIcon then
		self.LevelLinkLockIcon:SetShown(isLevelLinkLocked);
	end
end

function ActionBarActionButtonMixin:UpdateCount()
	local text = self.Count;
	local action = self.action;
	if ( IsConsumableAction(action) or IsStackableAction(action) or (not IsItemAction(action) and GetActionCount(action) > 0) ) then
		local count = GetActionCount(action);
		if ( count > (self.maxDisplayCount or 9999 ) ) then
			text:SetText("*");
		else
			text:SetText(count);
		end
	else
		local charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(action);
		if (maxCharges > 1) then
			text:SetText(charges);
		else
			text:SetText("");
		end
	end
end

-- Shared between action bar buttons and spell flyout buttons.
function ActionButton_UpdateCooldown(self)
	local locStart, locDuration;
	local start, duration, enable, charges, maxCharges, chargeStart, chargeDuration;
	local modRate = 1.0;
	local chargeModRate = 1.0;
	local actionType, actionID = nil; 
	if (self.action) then 
		actionType, actionID = GetActionInfo(self.action);
	end 
	local auraData = nil;
	local passiveCooldownSpellID = nil;
	local onEquipPassiveSpellID = nil;

	if(actionID) then 
		onEquipPassiveSpellID = C_ActionBar.GetItemActionOnEquipSpellID(self.action);
	end

	if (onEquipPassiveSpellID) then
		passiveCooldownSpellID = C_UnitAuras.GetCooldownAuraBySpellID(onEquipPassiveSpellID);
	elseif ((actionType and actionType == "spell") and actionID ) then 
		passiveCooldownSpellID = C_UnitAuras.GetCooldownAuraBySpellID(actionID);
	elseif(self.spellID) then 
		passiveCooldownSpellID = C_UnitAuras.GetCooldownAuraBySpellID(self.spellID);
	end

	if(passiveCooldownSpellID and passiveCooldownSpellID ~= 0) then 
		auraData = C_UnitAuras.GetPlayerAuraBySpellID(passiveCooldownSpellID);
	end

	if(auraData) then
		local currentTime = GetTime();
		local timeUntilExpire = auraData.expirationTime - currentTime;
		local howMuchTimeHasPassed = auraData.duration - timeUntilExpire; 

		locStart =  currentTime - howMuchTimeHasPassed;
		locDuration = auraData.expirationTime - currentTime;
		start = currentTime - howMuchTimeHasPassed;
		duration =  auraData.duration
		modRate = auraData.timeMod; 
		charges = auraData.charges; 
		maxCharges = auraData.maxCharges; 
		chargeStart = currentTime * 0.001; 
		chargeDuration = duration * 0.001;
		chargeModRate = modRate; 
		enable = 1; 
	elseif (self.spellID) then
		locStart, locDuration = GetSpellLossOfControlCooldown(self.spellID);
		start, duration, enable, modRate = GetSpellCooldown(self.spellID);
		charges, maxCharges, chargeStart, chargeDuration, chargeModRate = GetSpellCharges(self.spellID);
	else
		locStart, locDuration = GetActionLossOfControlCooldown(self.action);
		start, duration, enable, modRate = GetActionCooldown(self.action);
		charges, maxCharges, chargeStart, chargeDuration, chargeModRate = GetActionCharges(self.action);
	end

	if ( (locStart + locDuration) > (start + duration) ) then
		if ( self.cooldown.currentCooldownType ~= COOLDOWN_TYPE_LOSS_OF_CONTROL ) then
			self.cooldown:SetEdgeTexture("Interface\\Cooldown\\edge-LoC");
			self.cooldown:SetSwipeColor(0.17, 0, 0);
			self.cooldown:SetHideCountdownNumbers(true);
			self.cooldown.currentCooldownType = COOLDOWN_TYPE_LOSS_OF_CONTROL;
		end

		CooldownFrame_Set(self.cooldown, locStart, locDuration, true, true, modRate);
		ClearChargeCooldown(self);
	else
		if ( self.cooldown.currentCooldownType ~= COOLDOWN_TYPE_NORMAL ) then
			self.cooldown:SetEdgeTexture("Interface\\Cooldown\\edge");
			self.cooldown:SetSwipeColor(0, 0, 0);
			self.cooldown:SetHideCountdownNumbers(false);
			self.cooldown.currentCooldownType = COOLDOWN_TYPE_NORMAL;
		end

		if( locStart > 0 ) then
			self.cooldown:SetScript("OnCooldownDone", ActionButtonCooldown_OnCooldownDone);
		end

		if ( charges and maxCharges and maxCharges > 1 and charges < maxCharges ) then
			StartChargeCooldown(self, chargeStart, chargeDuration, chargeModRate);
		else
			ClearChargeCooldown(self);
		end

		CooldownFrame_Set(self.cooldown, start, duration, enable, false, modRate);
	end
end

function ActionButtonCooldown_OnCooldownDone(self)
	self:SetScript("OnCooldownDone", nil);
	ActionButton_UpdateCooldown(self:GetParent());
end

-- Charge Cooldown stuff

local numChargeCooldowns = 0;
local function CreateChargeCooldownFrame(parent)
	numChargeCooldowns = numChargeCooldowns + 1;
	local cooldown = CreateFrame("Cooldown", "ChargeCooldown"..numChargeCooldowns, parent, "CooldownFrameTemplate");
	cooldown:SetHideCountdownNumbers(true);
	cooldown:SetDrawSwipe(false);

	cooldown:SetFrameStrata("TOOLTIP");

	return cooldown;
end

function StartChargeCooldown(parent, chargeStart, chargeDuration, chargeModRate)
	if chargeStart == 0 then
		ClearChargeCooldown(parent);
		return;
	end

	parent.chargeCooldown = parent.chargeCooldown or CreateChargeCooldownFrame(parent);

	CooldownFrame_Set(parent.chargeCooldown, chargeStart, chargeDuration, true, true, chargeModRate);
end

function ClearChargeCooldown(parent)
	if parent.chargeCooldown then
		CooldownFrame_Clear(parent.chargeCooldown);
	end
end


--Overlay stuff
local unusedOverlayGlows = {};
local numOverlays = 0;
function ActionButton_GetOverlayGlow()
	local overlay = tremove(unusedOverlayGlows);
	if ( not overlay ) then
		numOverlays = numOverlays + 1;
		overlay = CreateFrame("Frame", "ActionButtonOverlay"..numOverlays, UIParent, "ActionBarButtonSpellActivationAlert");
	end
	return overlay;
end

function ActionBarActionButtonMixin:UpdateOverlayGlow()
	local spellType, id, subType  = GetActionInfo(self.action);
	if ( spellType == "spell" and IsSpellOverlayed(id) ) then
		ActionButton_ShowOverlayGlow(self);
	elseif ( spellType == "macro" ) then
		local spellId = GetMacroSpell(id);
		if ( spellId and IsSpellOverlayed(spellId) ) then
			ActionButton_ShowOverlayGlow(self);
		else
			ActionButton_HideOverlayGlow(self);
		end
	else
		ActionButton_HideOverlayGlow(self);
	end
end

-- Shared between action button and MainMenuBarMicroButton
function ActionButton_ShowOverlayGlow(button)
	if ( button.overlay ) then
		if ( button.overlay.animOut:IsPlaying() ) then
			button.overlay.animOut:Stop();
			button.overlay.animIn:Play();
		end
	else
		button.overlay = ActionButton_GetOverlayGlow();
		local frameWidth, frameHeight = button:GetSize();
		button.overlay:SetParent(button);
		button.overlay:ClearAllPoints();
		--Make the height/width available before the next frame:
		button.overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4);
		button.overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2);
		button.overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2);
		button.overlay.animIn:Play();
	end
end

-- Shared between action button and MainMenuBarMicroButton
function ActionButton_HideOverlayGlow(button)
	if ( button.overlay ) then
		if ( button.overlay.animIn:IsPlaying() ) then
			button.overlay.animIn:Stop();
		end
		if ( button:IsVisible() ) then
			button.overlay.animOut:Play();
		else
			button.overlay.animOut:OnFinished();	--We aren't shown anyway, so we'll instantly hide it.
		end
	end
end

ActionBarOverlayGlowAnimOutMixin = {};

function ActionBarOverlayGlowAnimOutMixin:OnFinished()
	local overlay = self:GetParent();
	local actionButton = overlay:GetParent();
	overlay:Hide();
	tinsert(unusedOverlayGlows, overlay);
	actionButton.overlay = nil;
end

ActionBarOverlayGlowAnimInMixin = {};

function ActionBarOverlayGlowAnimInMixin:OnPlay()
	local frame = self:GetParent();
	local frameWidth, frameHeight = frame:GetSize();
	frame.spark:SetSize(frameWidth, frameHeight);
	frame.spark:SetAlpha(0.3);
	frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2);
	frame.innerGlow:SetAlpha(1.0);
	frame.innerGlowOver:SetAlpha(1.0);
	frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2);
	frame.outerGlow:SetAlpha(1.0);
	frame.outerGlowOver:SetAlpha(1.0);
	frame.ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
	frame.ants:SetAlpha(0);
	frame:Show();
end

function ActionBarOverlayGlowAnimInMixin:OnFinished()
	local frame = self:GetParent();
	local frameWidth, frameHeight = frame:GetSize();
	frame.spark:SetAlpha(0);
	frame.innerGlow:SetAlpha(0);
	frame.innerGlow:SetSize(frameWidth, frameHeight);
	frame.innerGlowOver:SetAlpha(0.0);
	frame.outerGlow:SetSize(frameWidth, frameHeight);
	frame.outerGlowOver:SetAlpha(0.0);
	frame.outerGlowOver:SetSize(frameWidth, frameHeight);
	frame.ants:SetAlpha(1.0);
end

ActionBarButtonSpellActivationAlertMixin = {};

function ActionBarButtonSpellActivationAlertMixin:OnUpdate(elapsed)
	AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, 0.01);
	local cooldown = self:GetParent().cooldown;
	-- we need some threshold to avoid dimming the glow during the gdc
	-- (using 1500 exactly seems risky, what if casting speed is slowed or something?)
	if(cooldown and cooldown:IsShown() and cooldown:GetCooldownDuration() > 3000) then
		self:SetAlpha(0.5);
	else
		self:SetAlpha(1.0);
	end
end

function ActionBarButtonSpellActivationAlertMixin:OnHide()
	if ( self.animOut:IsPlaying() ) then
		self.animOut:Stop();
		self.animOut:OnFinished();
	end
end

function ActionBarActionButtonMixin:OnEvent(event, ...)
	local arg1 = ...;
	if ((event == "UNIT_INVENTORY_CHANGED" and arg1 == "player") or event == "LEARNED_SPELL_IN_TAB") then
		if ( GameTooltip:GetOwner() == self ) then
			self:SetTooltip();
		end
	elseif ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == 0 or arg1 == tonumber(self.action) ) then
			ClearNewActionHighlight(self.action, true);
			self:UpdateAction(true);
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		self:Update();
	elseif ( event == "UPDATE_SHAPESHIFT_FORM" ) then
		-- need to listen for UPDATE_SHAPESHIFT_FORM because attack icons change when the shapeshift form changes
		-- This is NOT intended to update everything about shapeshifting; most stuff should be handled by ActionBar-specific events such as UPDATE_BONUS_ACTIONBAR, UPDATE_USABLE, etc.
		local texture = GetActionTexture(self.action);
		if (texture) then
			self.icon:SetTexture(texture);
		end
	elseif ( event == "UPDATE_BINDINGS" or event == "GAME_PAD_ACTIVE_CHANGED" ) then
		self:UpdateHotkeys(self.buttonType);
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then	-- All event handlers below this line are only set when the button has an action
		self.rangeTimer = -1;
	elseif ( event == "UNIT_FLAGS" or event == "UNIT_AURA" or event == "PET_BAR_UPDATE" ) then
		-- Pet actions can also change the state of action buttons.
		self.flashDirty = true;
		self.stateDirty = true;
	elseif ( (event == "ACTIONBAR_UPDATE_STATE") or
		((event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE") and (arg1 == "player")) or
		((event == "COMPANION_UPDATE") and (arg1 == "MOUNT")) ) then
		self:UpdateState();
	elseif ( event == "ACTIONBAR_UPDATE_USABLE" or event == "PLAYER_MOUNT_DISPLAY_CHANGED" ) then
		self:UpdateUsable();
	elseif ( event == "LOSS_OF_CONTROL_UPDATE" ) then
		ActionButton_UpdateCooldown(self);
	elseif ( event == "ACTIONBAR_UPDATE_COOLDOWN" or event == "LOSS_OF_CONTROL_ADDED" ) then
		ActionButton_UpdateCooldown(self);
		-- Update tooltip
		if ( GameTooltip:GetOwner() == self ) then
			self:SetTooltip();
		end
	elseif ( event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE"  or event == "ARCHAEOLOGY_CLOSED" ) then
		self:UpdateState();
	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		if ( IsAttackAction(self.action) ) then
			self:StartFlash();
		end
	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		if ( IsAttackAction(self.action) ) then
			self:StopFlash();
		end
	elseif ( event == "START_AUTOREPEAT_SPELL" ) then
		if ( IsAutoRepeatAction(self.action) ) then
			self:StartFlash();
		end
	elseif ( event == "STOP_AUTOREPEAT_SPELL" ) then
		if ( self:IsFlashing() and not IsAttackAction(self.action) ) then
			self:StopFlash();
		end
	elseif ( event == "PET_STABLE_UPDATE" or event == "PET_STABLE_SHOW") then
		-- Has to update everything for now, but this event should happen infrequently
		self:Update();
	elseif ( event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" ) then
		local actionType, id, subType = GetActionInfo(self.action);
		if ( actionType == "spell" and id == arg1 ) then
			ActionButton_ShowOverlayGlow(self);
		elseif ( actionType == "macro" ) then
			local spellId = GetMacroSpell(id);
			if ( spellId and spellId == arg1 ) then
				ActionButton_ShowOverlayGlow(self);
			end
		elseif (actionType == "flyout" and FlyoutHasSpell(id, arg1)) then
			ActionButton_ShowOverlayGlow(self);
		end
	elseif ( event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" ) then
		local actionType, id, subType = GetActionInfo(self.action);
		if ( actionType == "spell" and id == arg1 ) then
			ActionButton_HideOverlayGlow(self);
		elseif ( actionType == "macro" ) then
			local spellId = GetMacroSpell(id);
			if (spellId and spellId == arg1 ) then
				ActionButton_HideOverlayGlow(self);
			end
		elseif (actionType == "flyout" and FlyoutHasSpell(id, arg1)) then
			ActionButton_HideOverlayGlow(self);
		end
	elseif ( event == "SPELL_UPDATE_CHARGES" ) then
		self:UpdateCount();
	elseif ( event == "UPDATE_SUMMONPETS_ACTION" ) then
		local actionType, id = GetActionInfo(self.action);
		if (actionType == "summonpet") then
			local texture = GetActionTexture(self.action);
			if (texture) then
				self.icon:SetTexture(texture);
			end
		end
	elseif ( event == "SPELL_UPDATE_ICON" ) then
		self:Update();
	end
end

function ActionBarActionButtonMixin:SetTooltip()
	local inQuickKeybind = KeybindFrames_InQuickKeybindMode();
	if ( GetCVar("UberTooltips") == "1" or inQuickKeybind ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		local parent = self:GetParent();
		if ( parent == MultiBarBottomRight or parent == MultiBarRight or parent == MultiBarLeft ) then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		end
	end
	if ( GameTooltip:SetAction(self.action) ) then
		self.UpdateTooltip = self.SetTooltip;
	else
		self.UpdateTooltip = nil;
	end
end

function ActionBarActionButtonMixin:OnUpdate(elapsed)
	if ( self.stateDirty ) then
		self:UpdateState();
		self.stateDirty = nil;
	end

	if ( self.flashDirty ) then
		self:UpdateFlash();
		self.flashDirty = nil;
	end

	if ( self:IsFlashing() ) then
		local flashtime = self.flashtime;
		flashtime = flashtime - elapsed;

		if ( flashtime <= 0 ) then
			local overtime = -flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = self.Flash;
			if ( flashTexture:IsShown() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end

		self.flashtime = flashtime;
	end

	-- Handle range indicator
	local rangeTimer = self.rangeTimer;
	if ( rangeTimer ) then
		rangeTimer = rangeTimer - elapsed;

		if ( rangeTimer <= 0 ) then
			local valid = IsActionInRange(self.action);
			local checksRange = (valid ~= nil);
			local inRange = checksRange and valid;
			ActionButton_UpdateRangeIndicator(self, checksRange, inRange);
			rangeTimer = TOOLTIP_UPDATE_TIME;
		end

		self.rangeTimer = rangeTimer;
	end
end

-- Shared between the action bar and the pet bar.
function ActionButton_UpdateRangeIndicator(self, checksRange, inRange)
	if ( self.HotKey:GetText() == RANGE_INDICATOR ) then
		if ( checksRange ) then
			self.HotKey:Show();
			if ( inRange ) then
				self.HotKey:SetVertexColor(ACTIONBAR_HOTKEY_FONT_COLOR:GetRGB());
			else
				self.HotKey:SetVertexColor(RED_FONT_COLOR:GetRGB());
			end
		else
			self.HotKey:Hide();
		end
	else
		if ( checksRange and not inRange ) then
			self.HotKey:SetVertexColor(RED_FONT_COLOR:GetRGB());
		else
			self.HotKey:SetVertexColor(ACTIONBAR_HOTKEY_FONT_COLOR:GetRGB());
		end
	end
end

function ActionBarActionButtonMixin:GetPagedID()
    return self.action;
end

function ActionBarActionButtonMixin:UpdateFlash()
	local action = self.action;
	if ( (IsAttackAction(action) and IsCurrentAction(action)) or IsAutoRepeatAction(action) ) then
		self:StartFlash();
		
		local actionType, actionID, actionSubtype = GetActionInfo(action);
		if ( actionSubtype == "pet" ) then
			self:GetCheckedTexture():SetAlpha(0.5);
		else
			self:GetCheckedTexture():SetAlpha(1.0);
		end
	else
		self:StopFlash();
	end
	
	if ( self.AutoCastable ) then
		self.AutoCastable:SetShown(C_ActionBar.IsAutoCastPetAction(action));
		if ( C_ActionBar.IsEnabledAutoCastPetAction(action) ) then
			self.AutoCastShine:Show();
			AutoCastShine_AutoCastStart(self.AutoCastShine);
		else
			self.AutoCastShine:Hide();
			AutoCastShine_AutoCastStop(self.AutoCastShine);
		end
	end
end

function ActionBarActionButtonMixin:ClearFlash()
	if ( self.AutoCastable ) then
		self.AutoCastable:Hide();
		self.AutoCastShine:Hide();
		AutoCastShine_AutoCastStop(self.AutoCastShine);
	end
end

function ActionBarActionButtonMixin:StartFlash()
	self.flashing = 1;
	self.flashtime = 0;
	self:UpdateState();
end

function ActionBarActionButtonMixin:StopFlash()
	self.flashing = 0;
	self.Flash:Hide();
	self:UpdateState();
end

function ActionBarActionButtonMixin:IsFlashing()
	if ( self.flashing == 1 ) then
		return 1;
	end

	return nil;
end

-- Shared between action bar buttons and spell flyout buttons
function ActionBarActionButtonMixin:UpdateFlyout(isButtonDownOverride)
	if (not self.FlyoutArrowContainer or
		not self.FlyoutBorderShadow) then
		return;
	end

	local actionType = GetActionInfo(self.action);
	if (actionType ~= "flyout") then
		self.FlyoutBorderShadow:Hide();
		self.FlyoutArrowContainer:Hide();
		return;
	end

	-- Update border
	local isMouseOverButton =  GetMouseFocus() == self;
	local isFlyoutShown = SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self;
	if (isFlyoutShown or isMouseOverButton) then
		self.FlyoutBorderShadow:Show();
	else
		self.FlyoutBorderShadow:Hide();
	end

	-- Update arrow
	local isButtonDown;
	if (isButtonDownOverride ~= nil) then
		isButtonDown = isButtonDownOverride;
	else
		isButtonDown = self:GetButtonState() == "PUSHED";
	end

	local flyoutArrowTexture = self.FlyoutArrowContainer.FlyoutArrowNormal;

	if (isButtonDown) then
		flyoutArrowTexture = self.FlyoutArrowContainer.FlyoutArrowPushed;

		self.FlyoutArrowContainer.FlyoutArrowNormal:Hide();
		self.FlyoutArrowContainer.FlyoutArrowHighlight:Hide();
	elseif (isMouseOverButton) then
		flyoutArrowTexture = self.FlyoutArrowContainer.FlyoutArrowHighlight;

		self.FlyoutArrowContainer.FlyoutArrowNormal:Hide();
		self.FlyoutArrowContainer.FlyoutArrowPushed:Hide();
	else
		self.FlyoutArrowContainer.FlyoutArrowHighlight:Hide();
		self.FlyoutArrowContainer.FlyoutArrowPushed:Hide();
	end

	self.FlyoutArrowContainer:Show();
	flyoutArrowTexture:Show();
	flyoutArrowTexture:ClearAllPoints();

	local arrowDirection = self:GetAttribute("flyoutDirection");
	local arrowDistance = isFlyoutShown and 1 or 4;

	-- If you are on an action bar then base your direction based on the action bar's orientation
	local actionBar = self:GetParent();
	if (actionBar.actionButtons) then
		arrowDirection = actionBar:GetSpellFlyoutDirection();
	end

	if (arrowDirection == "LEFT") then
		SetClampedTextureRotation(flyoutArrowTexture, isFlyoutShown and 90 or 270);
		flyoutArrowTexture:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0);
	elseif (arrowDirection == "RIGHT") then
		SetClampedTextureRotation(flyoutArrowTexture, isFlyoutShown and 270 or 90);
		flyoutArrowTexture:SetPoint("RIGHT", self, "RIGHT", arrowDistance, 0);
	elseif (arrowDirection == "DOWN") then
		SetClampedTextureRotation(flyoutArrowTexture, isFlyoutShown and 0 or 180);
		flyoutArrowTexture:SetPoint("BOTTOM", self, "BOTTOM", 0, -arrowDistance);
	else
		SetClampedTextureRotation(flyoutArrowTexture, isFlyoutShown and 180 or 0);
		flyoutArrowTexture:SetPoint("TOP", self, "TOP", 0, arrowDistance);
	end
end

function ActionBarActionButtonMixin:SetButtonStateOverride(state)
	self:SetButtonStateBase(state);
	self:UpdateFlyout();
end

function ActionBarActionButtonMixin:OnClick(button, down)
	if ( KeybindFrames_InQuickKeybindMode() ) then
		local cursorType = GetCursorInfo();
		if ( cursorType ) then
			local slotID = self:CalculateAction(button);
			C_ActionBar.PutActionInSlot(slotID);
		end
	else
		if button == "RightButton" and C_ActionBar.IsAutoCastPetAction(self.action) then
			if not down then
				C_ActionBar.ToggleAutoCastPetAction(self.action);
			end
		else
			local actionBarLocked = Settings.GetValue("lockActionBars");

			local isModifiedClickLockedBarDoNothing = IsModifiedClick("PICKUPACTION");
			if GetCursorInfo() then
				-- If we have something on the cursor then we don't care whether it was a modified click
				-- as far as lockedBarDoNothing goes
				isModifiedClickLockedBarDoNothing = false;
			end

			local lockedBarDoNothing = actionBarLocked and down and isModifiedClickLockedBarDoNothing;
			local unlockedBarDoNothing = not actionBarLocked and (self:GetAttribute("pressAndHoldAction") and down);
			if lockedBarDoNothing or unlockedBarDoNothing then
				return;
			end

			local isKeyPress = false;
			local isSecureAction = true;
			SecureActionButton_OnClick(self, button, down, isKeyPress, isSecureAction);
		end
	end

	self:UpdateFlyout(down);
end

function ActionBarActionButtonMixin:OnDragStart()
	if ( not Settings.GetValue("lockActionBars") or IsModifiedClick("PICKUPACTION") ) then
		-- If an IconSelectorPopupFrame is active, we do not want to remove the action from the bar, just copy it to the mouse.
		local ignoreActionRemoval = IsAnyIconSelectorPopupFrameShown();
		PickupAction(self.action, ignoreActionRemoval);

		SpellFlyout:Hide();
		self:UpdateState();
		self:UpdateFlash();
	end
end

function ActionBarActionButtonMixin:OnReceiveDrag()
	PlaceAction(self.action);
	self:UpdateState();
	self:UpdateFlash();
end

function ActionBarActionButtonMixin:OnEnter()
	if (self.NewActionTexture) then
		ClearNewActionHighlight(self.action);
		self:UpdateAction(true);
	end
	self:SetTooltip();
	ActionBarButtonEventsFrame.tooltipOwner = self;
	ActionBarActionEventsFrame.tooltipOwner = self;
	self:UpdateFlyout();
end

function ActionBarActionButtonMixin:OnLeave()
	GameTooltip:Hide();
	ActionBarButtonEventsFrame.tooltipOwner = nil;
	ActionBarActionEventsFrame.tooltipOwner = nil;
	self:UpdateFlyout();
end

BaseActionButtonMixin = {}

function BaseActionButtonMixin:BaseActionButtonMixin_OnLoad()
	self:UpdateButtonArt(self.isLastActionButton);

	self.NormalTexture:SetDrawLayer("OVERLAY");
	self.PushedTexture:SetDrawLayer("OVERLAY");
end

function BaseActionButtonMixin:GetShowGrid()
	local showGridAttribute = self:GetAttribute("showgrid");
	return showGridAttribute and showGridAttribute > 0 or false;
end

function BaseActionButtonMixin:SetShowGrid(showGrid, reason)
	assert(reason);

	if ( issecure() and self:GetShowGrid() ~= showGrid ) then
		local showGridAttribute = self:GetAttribute("showgrid");
		if ( showGrid ) then
			self:SetAttribute("showgrid", bit.bor(showGridAttribute or 0, reason));
		else
			self:SetAttribute("showgrid", bit.band(showGridAttribute or 0, bit.bnot(reason)));
		end
	end
end

function BaseActionButtonMixin:UpdateButtonArt(hideDivider)
	if (not self.SlotArt or not self.SlotBackground) then
		return;
	end

	local function SetDividerShown(shown)
		if (not self.RightDivider or not self.BottomDivider) then
			return;
		end

		-- Don't show dividers if we have multiple rows or any extra padding
		local parent = self:GetParent();
		if (not shown or parent.numRows > 1 or parent.buttonPadding > parent.minButtonPadding) then
			self.RightDivider:Hide();
			self.BottomDivider:Hide();
			return;
		end

		-- Right now buttons are only added to the right for horizontal and below for vertical
		if (parent.isHorizontal) then
			self.RightDivider:Show();
			self.BottomDivider:Hide();
		else
			self.RightDivider:Hide();
			self.BottomDivider:Show();
		end
	end

	if (self.showButtonArt) then
		SetDividerShown(not hideDivider);
		self.SlotArt:Show();
		self.SlotBackground:Hide();

		self:SetNormalAtlas("UI-HUD-ActionBar-IconFrame");
		self.NormalTexture:SetDrawLayer("OVERLAY");
		self.NormalTexture:SetSize(46, 45);

		self:SetPushedAtlas("UI-HUD-ActionBar-IconFrame-Down");
		self.PushedTexture:SetDrawLayer("OVERLAY");
		self.PushedTexture:SetSize(46, 45);
	else
		SetDividerShown(false);
		self.SlotArt:Hide();
		self.SlotBackground:Show();

		self:SetNormalAtlas("UI-HUD-ActionBar-IconFrame-AddRow");
		self.NormalTexture:SetDrawLayer("OVERLAY");
		self.NormalTexture:SetSize(51, 51);

		self:SetPushedAtlas("UI-HUD-ActionBar-IconFrame-AddRow-Down");
		self.PushedTexture:SetDrawLayer("OVERLAY");
		self.PushedTexture:SetSize(51, 51);
	end
end

SmallActionButtonMixin = {}

function SmallActionButtonMixin:SmallActionButtonMixin_OnLoad()
	self.HotKey:ClearAllPoints();
	self.HotKey:SetPoint("TOPRIGHT", -3, -4);

	self.Count:ClearAllPoints();
	self.Count:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -3, 1);

	self.IconMask:SetSize(45, 45);
	self.IconMask:ClearAllPoints();
	self.IconMask:SetPoint("CENTER", 0.5, -0.5);

	self.AutoCastable:SetSize(56, 56);
	self.AutoCastable:ClearAllPoints();
	self.AutoCastable:SetPoint("CENTER", 0.5, -0.5);

	self.AutoCastShine:SetSize(27, 27);
	self.AutoCastShine:ClearAllPoints();
	self.AutoCastShine:SetPoint("CENTER", 0.5, -0.5);

	self.HighlightTexture:SetSize(31.6, 30.9);
	self.CheckedTexture:SetSize(31.6, 30.9);

	if self.QuickKeybindHighlightTexture then
		self.QuickKeybindHighlightTexture:ClearAllPoints();
		self.QuickKeybindHighlightTexture:SetPoint("TOPLEFT");
		self.QuickKeybindHighlightTexture:SetSize(31.6, 30.9);
	end

	self.NewActionTexture:SetSize(31.6, 30.9);
	self.SpellHighlightTexture:SetSize(31.6, 30.9);
	self.Border:SetSize(31.6, 30.9);
	self.Flash:SetSize(31.6, 30.9);

	self.cooldown:ClearAllPoints();
	self.cooldown:SetPoint("TOPLEFT", self.icon, "TOPLEFT", 1.7, -1.7);
	self.cooldown:SetPoint("BOTTOMRIGHT", self.icon, "BOTTOMRIGHT", -1, 1);
end

function SmallActionButtonMixin:UpdateButtonArt(hideDivider)
	BaseActionButtonMixin.UpdateButtonArt(self, hideDivider);

	-- Gotta set these texture sizes here since BaseActionButtonMixin.UpdateButtonArt changes their size
	self.NormalTexture:SetSize(35, 35);
	self.PushedTexture:SetSize(35, 35);
end
