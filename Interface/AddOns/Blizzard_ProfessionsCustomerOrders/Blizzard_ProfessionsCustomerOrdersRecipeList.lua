
ProfessionsCustomerOrdersRecipeListElementMixin = CreateFromMixins(ScrollListLineMixin, TableBuilderRowMixin);

function ProfessionsCustomerOrdersRecipeListElementMixin:OnLoad()
	self:RegisterEvent("CRAFTINGORDERS_CUSTOMER_FAVORITES_CHANGED");

	self.FavoriteButton:SetScript("OnLeave", function() self:OnLineLeave(); end);
	self.FavoriteButton:SetScript("OnClick", function() C_CraftingOrders.SetCustomerOptionFavorited(self.option.spellID, not self:IsFavorite()); end);
end

function ProfessionsCustomerOrdersRecipeListElementMixin:OnEvent()
	self:UpdateFavoriteButton();
end

function ProfessionsCustomerOrdersRecipeListElementMixin:OnLineEnter()
	self.isMouseFocus = true;
	self.HighlightTexture:Show();
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

	local reagents = {};
	C_TradeSkillUI.SetTooltipRecipeResultItem(self.option.spellID, reagents);

	if IsModifiedClick("DRESSUP") then
		ShowInspectCursor();
	end

	self.FavoriteButton:Show();

	self:SetScript("OnUpdate", self.OnUpdate);
end

function ProfessionsCustomerOrdersRecipeListElementMixin:OnLineLeave()
	if GetMouseFocus() == self.FavoriteButton then
		return;
	end

	self.isMouseFocus = false;
	self.HighlightTexture:Hide();
	GameTooltip:Hide();
	ResetCursor();
	self:SetScript("OnUpdate", nil);

	if not self:IsFavorite() then
		self.FavoriteButton:Hide();
	end
end

-- Set and cleared dynamically in OnEnter and OnLeave
function ProfessionsCustomerOrdersRecipeListElementMixin:OnUpdate()
	if IsModifiedClick("DRESSUP") then
		ShowInspectCursor();
	else
		ResetCursor();
	end
end

function ProfessionsCustomerOrdersRecipeListElementMixin:OnClick(button)
	if button == "LeftButton" then
		local function UseItemLink(callback)
			local item = Item:CreateFromItemID(self.option.itemID);
			item:ContinueOnItemLoad(function()
				callback(item:GetItemLink());
			end);
		end

		if IsModifiedClick("DRESSUP") then
			UseItemLink(DressUpLink);
		elseif IsModifiedClick("CHATLINK") then
			UseItemLink(ChatEdit_InsertLink);
		else
			local isRecraft = false;
			EventRegistry:TriggerEvent("ProfessionsCustomerOrders.RecipeSelected", C_TradeSkillUI.GetRecipeSchematic(self.option.spellID, isRecraft));
		end
	elseif button == "RightButton" then
		ToggleDropDownMenu(1, self.option.spellID, self.contextMenu, "cursor");
	end
end

function ProfessionsCustomerOrdersRecipeListElementMixin:IsFavorite()
	return C_CraftingOrders.IsCustomerOptionFavorited(self.option.spellID);
end

function ProfessionsCustomerOrdersRecipeListElementMixin:UpdateFavoriteButton()
	local isFavorite = self:IsFavorite();
	local currAtlas = isFavorite and "auctionhouse-icon-favorite" or "auctionhouse-icon-favorite-off";
	self.FavoriteButton.NormalTexture:SetAtlas(currAtlas, TextureKitConstants.IgnoreAtlasSize);
	self.FavoriteButton.HighlightTexture:SetAtlas(currAtlas, TextureKitConstants.IgnoreAtlasSize);
	self.FavoriteButton.HighlightTexture:SetAlpha(isFavorite and 0.2 or 0.4);
	self.FavoriteButton:SetShown(isFavorite or self.isMouseFocus);
end

function ProfessionsCustomerOrdersRecipeListElementMixin:Init(elementData)
	self.option = elementData.option;
	self.contextMenu = elementData.contextMenu;
	self:UpdateFavoriteButton();
	self.HighlightTexture:Hide();
end

ProfessionsCustomerOrdersRecipeListMixin = {};

function ProfessionsCustomerOrdersRecipeListMixin:OnLoad()
	local pad = 5;
	local spacing = 1;
	local view = CreateScrollBoxListLinearView(pad, pad, pad, pad, spacing);
	view:SetElementInitializer("ProfessionsCustomerOrdersRecipeListElementTemplate", function(button, elementData)
		button:Init(elementData);
	end);

	ScrollUtil.InitScrollBoxListWithScrollBar(self.ScrollBox, self.ScrollBar, view);
end