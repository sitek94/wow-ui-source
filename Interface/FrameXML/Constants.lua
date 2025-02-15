﻿--
-- New constants should be added to this file and other constants
-- deprecated and moved to this file.
--

WORLD_QUEST_ICONS_BY_PROFESSION = {
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.FirstAid)] = "worldquest-icon-firstaid",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Blacksmithing)] = "worldquest-icon-blacksmithing",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Leatherworking)] = "worldquest-icon-leatherworking",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Alchemy)] = "worldquest-icon-alchemy",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Herbalism)] = "worldquest-icon-herbalism",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Mining)] = "worldquest-icon-mining",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Engineering)] = "worldquest-icon-engineering",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Enchanting)] = "worldquest-icon-enchanting",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Jewelcrafting)] = "worldquest-icon-jewelcrafting",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Inscription)] = "worldquest-icon-inscription",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Archaeology)] = "worldquest-icon-archaeology",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Fishing)] = "worldquest-icon-fishing",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Cooking)] = "worldquest-icon-cooking",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Tailoring)] = "worldquest-icon-tailoring",
	[C_TradeSkillUI.GetProfessionSkillLineID(Enum.Profession.Skinning)] = "worldquest-icon-skinning",
};

CHAT_FONT_HEIGHTS = {
	[1] = 12,
	[2] = 14,
	[3] = 16,
	[4] = 18
};

HTML_START = "<html><body><p>";
HTML_START_CENTERED = "<html><body><p align=\"center\">";
HTML_END = "</p></body></html>";

--
-- Class
--
CLASS_SORT_ORDER = {
	"WARRIOR",
	"DEATHKNIGHT",
	"PALADIN",
	"MONK",
	"PRIEST",
	"SHAMAN",
	"DRUID",
	"ROGUE",
	"MAGE",
	"WARLOCK",
	"HUNTER",
	"DEMONHUNTER",
	"EVOKER",
};
MAX_CLASSES = #CLASS_SORT_ORDER;

LOCALIZED_CLASS_NAMES_MALE = {};
LOCALIZED_CLASS_NAMES_FEMALE = {};
FillLocalizedClassList(LOCALIZED_CLASS_NAMES_MALE, false);
FillLocalizedClassList(LOCALIZED_CLASS_NAMES_FEMALE, true);

--
-- Spell
--
HUNTER_DISMISS_PET = 2641;
WARLOCK_METAMORPHOSIS = 103958;
WARLOCK_SOULBURN = 117198;
WARLOCK_GREEN_FIRE = 101508;
BATTLEGROUND_ENLISTMENT_BONUS = 241260;

SCHOOL_STRINGS = {
	STRING_SCHOOL_PHYSICAL,
	STRING_SCHOOL_HOLY,
	STRING_SCHOOL_FIRE,
	STRING_SCHOOL_NATURE,
	STRING_SCHOOL_FROST,
	STRING_SCHOOL_SHADOW,
	STRING_SCHOOL_ARCANE
}


MAX_POWER_PER_EMBER = 10;

SPECIALIZATION_TAB = 1;
TALENTS_TAB = 2;
NUM_TALENT_FRAME_TABS = 2;

--
-- Specs
--
SPEC_WARLOCK_AFFLICTION = 1;	--These are spec indices
SPEC_WARLOCK_DEMONOLOGY = 2;
SPEC_WARLOCK_DESTRUCTION = 3;
SPEC_PRIEST_SHADOW = 3;
SPEC_MONK_MISTWEAVER = 2;
SPEC_MONK_BREWMASTER = 1;
SPEC_MONK_WINDWALKER = 3;
SPEC_PALADIN_RETRIBUTION = 3;
SPEC_MAGE_ARCANE = 1;
SPEC_SHAMAN_RESTORATION = 3;

TALENT_SORT_ORDER = {
	"spec1",
	"spec2",
};

TALENT_ACTIVATION_SPELLS = {
	63645,
	63644,
};

--
-- Achievement
--

MAX_TRACKED_ACHIEVEMENTS = 10;

-- Criteria Types
CRITERIA_TYPE_ACHIEVEMENT = 8;

-- Achievement Flags
ACHIEVEMENT_FLAGS_HAS_PROGRESS_BAR 		= 0x00000080;
ACHIEVEMENT_FLAGS_GUILD					= 0x00004000;
ACHIEVEMENT_FLAGS_SHOW_GUILD_MEMBERS	= 0x00008000;
ACHIEVEMENT_FLAGS_SHOW_CRITERIA_MEMBERS = 0x00010000;
ACHIEVEMENT_FLAGS_ACCOUNT 				= 0x00020000;
NUM_ACHIEVEMENT_FLAGS			= 3;

-- Eval Tree Flags
EVALUATION_TREE_FLAG_PROGRESS_BAR		= 0x00000001;
EVALUATION_TREE_FLAG_DO_NOT_DISPLAY		= 0x00000002;
NUM_EVALUATION_TREE_FLAGS				= 2;

--
-- Inventory
--

-- General item constants
ITEM_UNIQUE_EQUIPPED = -1;
MAX_NUM_SOCKETS = 3;

BAG_ITEM_QUALITY_COLORS = {
	[Enum.ItemQuality.Common] = COMMON_GRAY_COLOR,
	[Enum.ItemQuality.Uncommon] = UNCOMMON_GREEN_COLOR,
	[Enum.ItemQuality.Rare] = RARE_BLUE_COLOR,
	[Enum.ItemQuality.Epic] = EPIC_PURPLE_COLOR,
	[Enum.ItemQuality.Legendary] = LEGENDARY_ORANGE_COLOR,
	[Enum.ItemQuality.Artifact] = ARTIFACT_GOLD_COLOR,
	[Enum.ItemQuality.Heirloom] = HEIRLOOM_BLUE_COLOR,
	[Enum.ItemQuality.WoWToken] = HEIRLOOM_BLUE_COLOR,
}

NEW_ITEM_ATLAS_BY_QUALITY = {
	[Enum.ItemQuality.Poor] = "bags-glow-white",
	[Enum.ItemQuality.Common] = "bags-glow-white",
	[Enum.ItemQuality.Uncommon] = "bags-glow-green",
	[Enum.ItemQuality.Rare] = "bags-glow-blue",
	[Enum.ItemQuality.Epic] = "bags-glow-purple",
	[Enum.ItemQuality.Legendary] = "bags-glow-orange",
	[Enum.ItemQuality.Artifact] = "bags-glow-artifact",
	[Enum.ItemQuality.Heirloom] = "bags-glow-heirloom",
};

-- Loot
LOOT_BORDER_BY_QUALITY = {
	[Enum.ItemQuality.Uncommon] = "loottoast-itemborder-green",
	[Enum.ItemQuality.Rare] = "loottoast-itemborder-blue",
	[Enum.ItemQuality.Epic] = "loottoast-itemborder-purple",
	[Enum.ItemQuality.Legendary] = "loottoast-itemborder-orange",
	[Enum.ItemQuality.Heirloom] = "loottoast-itemborder-heirloom",
	[Enum.ItemQuality.Artifact] = "loottoast-itemborder-artifact",
};

LOOT_ROLL_TYPE_PASS = 0;
LOOT_ROLL_TYPE_NEED = 1;
LOOT_ROLL_TYPE_GREED = 2;
LOOT_ROLL_TYPE_DISENCHANT = 3;

-- Item location bitflags
ITEM_INVENTORY_LOCATION_PLAYER		= 0x00100000;
ITEM_INVENTORY_LOCATION_BAGS		= 0x00200000;
ITEM_INVENTORY_LOCATION_BANK		= 0x00400000;
ITEM_INVENTORY_LOCATION_VOIDSTORAGE	= 0x00800000;
ITEM_INVENTORY_BAG_BIT_OFFSET 		= 8; -- Number of bits that the bag index in GetInventoryItemsForSlot gets shifted to the left.

-- Inventory slots
INVSLOT_AMMO		= 0;
INVSLOT_HEAD 		= 1; INVSLOT_FIRST_EQUIPPED = INVSLOT_HEAD;
INVSLOT_NECK		= 2;
INVSLOT_SHOULDER	= 3;
INVSLOT_BODY		= 4;
INVSLOT_CHEST		= 5;
INVSLOT_WAIST		= 6;
INVSLOT_LEGS		= 7;
INVSLOT_FEET		= 8;
INVSLOT_WRIST		= 9;
INVSLOT_HAND		= 10;
INVSLOT_FINGER1		= 11;
INVSLOT_FINGER2		= 12;
INVSLOT_TRINKET1	= 13;
INVSLOT_TRINKET2	= 14;
INVSLOT_BACK		= 15;
INVSLOT_MAINHAND	= 16;
INVSLOT_OFFHAND		= 17;
INVSLOT_RANGED		= 18;
INVSLOT_TABARD		= 19;
INVSLOT_LAST_EQUIPPED = INVSLOT_TABARD;

INVSLOTS_EQUIPABLE_IN_COMBAT = {
[INVSLOT_MAINHAND] = true,
[INVSLOT_OFFHAND] = true,
[INVSLOT_RANGED] = true,
}

-- Container constants
ITEM_INVENTORY_BANK_BAG_OFFSET	= 4; -- Number of bags before the first bank bag
CONTAINER_BAG_OFFSET = 30; -- Used for PutItemInBag

BACKPACK_CONTAINER = 0;
BANK_CONTAINER = -1;
BANK_CONTAINER_INVENTORY_OFFSET = 39; -- Used for PickupInventoryItem
REAGENTBANK_CONTAINER = -3;

NUM_BAG_SLOTS = 4;
NUM_REAGENTBAG_SLOTS = 1;
NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS;
NUM_BANKGENERIC_SLOTS = 28;
NUM_BANKBAGSLOTS = 7;

-- Item IDs
HEARTHSTONE_ITEM_ID = 6948;

--
-- Equipment Set
--
MAX_EQUIPMENT_SETS_PER_PLAYER = 10;
EQUIPMENT_SET_EMPTY_SLOT = 0;
EQUIPMENT_SET_IGNORED_SLOT = 1;
EQUIPMENT_SET_ITEM_MISSING = -1;

--
-- Combat Log
--

-- Affiliation
COMBATLOG_OBJECT_AFFILIATION_MINE		= 0x00000001;
COMBATLOG_OBJECT_AFFILIATION_PARTY		= 0x00000002;
COMBATLOG_OBJECT_AFFILIATION_RAID		= 0x00000004;
COMBATLOG_OBJECT_AFFILIATION_OUTSIDER		= 0x00000008;
COMBATLOG_OBJECT_AFFILIATION_MASK		= 0x0000000F;
-- Reaction
COMBATLOG_OBJECT_REACTION_FRIENDLY		= 0x00000010;
COMBATLOG_OBJECT_REACTION_NEUTRAL		= 0x00000020;
COMBATLOG_OBJECT_REACTION_HOSTILE		= 0x00000040;
COMBATLOG_OBJECT_REACTION_MASK			= 0x000000F0;
-- Ownership
COMBATLOG_OBJECT_CONTROL_PLAYER			= 0x00000100;
COMBATLOG_OBJECT_CONTROL_NPC			= 0x00000200;
COMBATLOG_OBJECT_CONTROL_MASK			= 0x00000300;
-- Unit type
COMBATLOG_OBJECT_TYPE_PLAYER			= 0x00000400;
COMBATLOG_OBJECT_TYPE_NPC			= 0x00000800;
COMBATLOG_OBJECT_TYPE_PET			= 0x00001000;
COMBATLOG_OBJECT_TYPE_GUARDIAN			= 0x00002000;
COMBATLOG_OBJECT_TYPE_OBJECT			= 0x00004000;
COMBATLOG_OBJECT_TYPE_MASK			= 0x0000FC00;

-- Special cases (non-exclusive)
COMBATLOG_OBJECT_TARGET				= 0x00010000;
COMBATLOG_OBJECT_FOCUS				= 0x00020000;
COMBATLOG_OBJECT_MAINTANK			= 0x00040000;
COMBATLOG_OBJECT_MAINASSIST			= 0x00080000;
COMBATLOG_OBJECT_NONE				= 0x80000000;
COMBATLOG_OBJECT_SPECIAL_MASK		= 0xFFFF0000;

COMBATLOG_OBJECT_RAIDTARGET1		= 0x00000001;
COMBATLOG_OBJECT_RAIDTARGET2		= 0x00000002;
COMBATLOG_OBJECT_RAIDTARGET3		= 0x00000004;
COMBATLOG_OBJECT_RAIDTARGET4		= 0x00000008;
COMBATLOG_OBJECT_RAIDTARGET5		= 0x00000010;
COMBATLOG_OBJECT_RAIDTARGET6		= 0x00000020;
COMBATLOG_OBJECT_RAIDTARGET7		= 0x00000040;
COMBATLOG_OBJECT_RAIDTARGET8		= 0x00000080;
COMBATLOG_OBJECT_RAIDTARGET_MASK	= bit.bor(
						COMBATLOG_OBJECT_RAIDTARGET1,
						COMBATLOG_OBJECT_RAIDTARGET2,
						COMBATLOG_OBJECT_RAIDTARGET3,
						COMBATLOG_OBJECT_RAIDTARGET4,
						COMBATLOG_OBJECT_RAIDTARGET5,
						COMBATLOG_OBJECT_RAIDTARGET6,
						COMBATLOG_OBJECT_RAIDTARGET7,
						COMBATLOG_OBJECT_RAIDTARGET8
						);

-- Object type constants
COMBATLOG_FILTER_ME			= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PLAYER
						);

COMBATLOG_FILTER_MINE			= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_OBJECT
						);

COMBATLOG_FILTER_MY_PET			= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_PET
						);
COMBATLOG_FILTER_FRIENDLY_UNITS		= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_PARTY,
						COMBATLOG_OBJECT_AFFILIATION_RAID,
						COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_CONTROL_NPC,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_NPC,
						COMBATLOG_OBJECT_TYPE_PET,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_OBJECT
						);

COMBATLOG_FILTER_HOSTILE_PLAYERS	= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_PARTY,
						COMBATLOG_OBJECT_AFFILIATION_RAID,
						COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
						COMBATLOG_OBJECT_REACTION_HOSTILE,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_NPC,
						COMBATLOG_OBJECT_TYPE_PET,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_OBJECT
						);

COMBATLOG_FILTER_HOSTILE_UNITS		= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_PARTY,
						COMBATLOG_OBJECT_AFFILIATION_RAID,
						COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
						COMBATLOG_OBJECT_REACTION_HOSTILE,
						COMBATLOG_OBJECT_CONTROL_NPC,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_NPC,
						COMBATLOG_OBJECT_TYPE_PET,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_OBJECT
						);

COMBATLOG_FILTER_NEUTRAL_UNITS		= bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_PARTY,
						COMBATLOG_OBJECT_AFFILIATION_RAID,
						COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
						COMBATLOG_OBJECT_REACTION_NEUTRAL,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_CONTROL_NPC,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_NPC,
						COMBATLOG_OBJECT_TYPE_PET,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_OBJECT
						);
COMBATLOG_FILTER_UNKNOWN_UNITS		= COMBATLOG_OBJECT_NONE;
COMBATLOG_FILTER_EVERYTHING =	0xFFFFFFFF;

--
-- Calendar
--
CALENDAR_FIRST_WEEKDAY			= 1;		-- 1=SUN 2=MON 3=TUE 4=WED 5=THU 6=FRI 7=SAT

--
-- Difficulty
--
QuestDifficultyColors = {
	["impossible"]		= { r = 1.00, g = 0.10, b = 0.10, font = "QuestDifficulty_Impossible" };
	["verydifficult"]	= { r = 1.00, g = 0.50, b = 0.25, font = "QuestDifficulty_VeryDifficult" };
	["difficult"]		= { r = 1.00, g = 0.82, b = 0.00, font = "QuestDifficulty_Difficult" };
	["standard"]		= { r = 0.25, g = 0.75, b = 0.25, font = "QuestDifficulty_Standard" };
	["trivial"]			= { r = 0.50, g = 0.50, b = 0.50, font = "QuestDifficulty_Trivial" };
	["header"]			= { r = 0.70, g = 0.70, b = 0.70, font = "QuestDifficulty_Header" };
	["disabled"]		= { r = 0.498, g = 0.498, b = 0.498, font = "QuestDifficulty_Impossible" };
};

QuestDifficultyHighlightColors = {
	["impossible"]		= { r = 1.00, g = 0.40, b = 0.40, font = "QuestDifficulty_Impossible" };
	["verydifficult"]	= { r = 1.00, g = 0.75, b = 0.44, font = "QuestDifficulty_VeryDifficult" };
	["difficult"]		= { r = 1.00, g = 1.00, b = 0.10, font = "QuestDifficulty_Difficult" };
	["standard"]		= { r = 0.43, g = 0.93, b = 0.43, font = "QuestDifficulty_Standard" };
	["trivial"]			= { r = 0.70, g = 0.70, b = 0.70,  font = "QuestDifficulty_Trivial" };
	["header"]			= { r = 1.00, g = 1.00, b = 1.00, font = "QuestDifficulty_Header" };
	["disabled"]		= { r = 0.60, g = 0.60, b = 0.60, font = "QuestDifficulty_Impossible" };
};

--
-- WorldMap
--
NUM_WORLDMAP_PATCH_TILES = 6;

--
-- Totems
--

MAX_TOTEMS = 4;

FIRE_TOTEM_SLOT = 1;
EARTH_TOTEM_SLOT = 2;
WATER_TOTEM_SLOT = 3;
AIR_TOTEM_SLOT = 4;

STANDARD_TOTEM_PRIORITIES = {1, 2, 3, 4};

SHAMAN_TOTEM_PRIORITIES = {
	EARTH_TOTEM_SLOT,
	FIRE_TOTEM_SLOT,
	WATER_TOTEM_SLOT,
	AIR_TOTEM_SLOT,
};

TOTEM_MULTI_CAST_SUMMON_SPELLS = {
	66842,
	66843,
	66844,
};

TOTEM_MULTI_CAST_RECALL_SPELLS = {
	36936,
};

--
-- GM Ticket
--

GMTICKET_QUEUE_STATUS_ENABLED = 1;
GMTICKET_QUEUE_STATUS_DISABLED = -1;

GMTICKET_ASSIGNEDTOGM_STATUS_NOT_ASSIGNED = 0;	-- ticket is not currently assigned to a gm
GMTICKET_ASSIGNEDTOGM_STATUS_ASSIGNED = 1;		-- ticket is assigned to a normal gm
GMTICKET_ASSIGNEDTOGM_STATUS_ESCALATED = 2;		-- ticket is in the escalation queue

GMTICKET_OPENEDBYGM_STATUS_NOT_OPENED = 0;		-- ticket has never been opened by a gm
GMTICKET_OPENEDBYGM_STATUS_OPENED = 1;			-- ticket has been opened by a gm


-- indicies for adding lights ModelFFX:Add*Light
LIGHT_LIVE  = 0;
LIGHT_GHOST = 1;

-- general constant translation table
STATIC_CONSTANTS = {}
RegisterStaticConstants(STATIC_CONSTANTS);

-- textures for quest item overlays
TEXTURE_ITEM_QUEST_BANG = "Interface\\ContainerFrame\\UI-Icon-QuestBang";
TEXTURE_ITEM_QUEST_BORDER = "Interface\\ContainerFrame\\UI-Icon-QuestBorder";

-- Friends
SHOW_SEARCH_BAR_NUM_FRIENDS = 12;

-- Search box
MIN_CHARACTER_SEARCH = 3;

-- Panel default size
PANEL_DEFAULT_WIDTH = 338;
PANEL_DEFAULT_HEIGHT = 424;

--Inline role icons
INLINE_TANK_ICON = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:0:64:64:0:19:22:41|t";
INLINE_HEALER_ICON = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:0:64:64:20:39:1:20|t";
INLINE_DAMAGER_ICON = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:0:64:64:20:39:22:41|t"

-- Guild
MAX_GUILDBANK_TABS = 8;
MAX_BUY_GUILDBANK_TABS = 6;

EXP_DEFAULT_WIDTH = 1024;

-- Date stuff
CALENDAR_WEEKDAY_NAMES = {
	WEEKDAY_SUNDAY,
	WEEKDAY_MONDAY,
	WEEKDAY_TUESDAY,
	WEEKDAY_WEDNESDAY,
	WEEKDAY_THURSDAY,
	WEEKDAY_FRIDAY,
	WEEKDAY_SATURDAY,
};

-- month names show up differently for full date displays in some languages
CALENDAR_FULLDATE_MONTH_NAMES = {
	FULLDATE_MONTH_JANUARY,
	FULLDATE_MONTH_FEBRUARY,
	FULLDATE_MONTH_MARCH,
	FULLDATE_MONTH_APRIL,
	FULLDATE_MONTH_MAY,
	FULLDATE_MONTH_JUNE,
	FULLDATE_MONTH_JULY,
	FULLDATE_MONTH_AUGUST,
	FULLDATE_MONTH_SEPTEMBER,
	FULLDATE_MONTH_OCTOBER,
	FULLDATE_MONTH_NOVEMBER,
	FULLDATE_MONTH_DECEMBER,
};


-- Druid Forms.
CAT_FORM = 1;
BEAR_FORM = 5;
MOONKIN_FORM = 31;

-- Rogue Forms
ROGUE_STEALTH = 30;

-- PVP Global Lua Constants
CONQUEST_CURRENCY = 390;
HONOR_CURRENCY = 392;
JUSTICE_CURRENCY = 395;
VALOR_CURRENCY = 396;

-- Looking for Guild Parameters
LFGUILD_PARAM_QUESTS 	= 1;
LFGUILD_PARAM_DUNGEONS	= 2;
LFGUILD_PARAM_RAIDS		= 3;
LFGUILD_PARAM_PVP		= 4;
LFGUILD_PARAM_RP		= 5;
LFGUILD_PARAM_WEEKDAYS	= 6;
LFGUILD_PARAM_WEEKENDS	= 7;
LFGUILD_PARAM_TANK		= 8;
LFGUILD_PARAM_HEALER	= 9;
LFGUILD_PARAM_DAMAGE	= 10;
LFGUILD_PARAM_ANY_LEVEL	= 11;
LFGUILD_PARAM_MAX_LEVEL	= 12;
LFGUILD_PARAM_LOOKING	= 13;

-- Instance
INSTANCE_TYPE_DUNGEON = 1;
INSTANCE_TYPE_RAID = 2;
INSTANCE_TYPE_BG = 3;
INSTANCE_TYPE_ARENA = 4;

DEFAULT_READY_CHECK_STAY_TIME = 10;


PET_TYPE_SUFFIX = {
[1] = "Humanoid",
[2] = "Dragon",
[3] = "Flying",
[4] = "Undead",
[5] = "Critter",
[6] = "Magical",
[7] = "Elemental",
[8] = "Beast",
[9] = "Water",
[10] = "Mechanical",
};

PET_BATTLE_PET_TYPE_PASSIVES = {
	238,	--Humanoid - Recovery
	245,	--Dragon - Execute
	239,	--Flying - Swiftness
	242,	--Undead - Damned
	236,	--Critter - Elusive
	243,	--Magical - Spellshield
	241,	--Elemental - Weather Immune
	237,	--Beast - Enrage
	240,	--Aquatic - Purity
	244,	--Mechanical - Failsafe
};

MAX_NUM_PET_BATTLE_ATTACK_MODIFIERS = 2;

PET_BATTLE_STATE_ATTACK = 18;
PET_BATTLE_STATE_SPEED = 20;

PET_BATTLE_EVENT_ON_APPLY = 0;
PET_BATTLE_EVENT_ON_DAMAGE_TAKEN = 1;
PET_BATTLE_EVENT_ON_DAMAGE_DEALT = 2;
PET_BATTLE_EVENT_ON_HEAL_TAKEN = 3;
PET_BATTLE_EVENT_ON_HEAL_DEALT = 4;
PET_BATTLE_EVENT_ON_AURA_REMOVED = 5;
PET_BATTLE_EVENT_ON_ROUND_START = 6;
PET_BATTLE_EVENT_ON_ROUND_END = 7;
PET_BATTLE_EVENT_ON_TURN = 8;
PET_BATTLE_EVENT_ON_ABILITY = 9;
PET_BATTLE_EVENT_ON_SWAP_IN = 10;
PET_BATTLE_EVENT_ON_SWAP_OUT = 11;

PET_BATTLE_PAD_INDEX = 0;

-- Challenge Mode
CHALLENGE_MEDAL_NONE = 0;
CHALLENGE_MEDAL_BRONZE = 1;
CHALLENGE_MEDAL_SILVER = 2;
CHALLENGE_MEDAL_GOLD = 3;
CHALLENGE_MEDAL_PLAT = 4; --as of 7/2/2013 only used for endless proving grounds
NUM_CHALLENGE_MEDALS = 3;
CHALLENGE_MEDAL_TEXTURES = {
	[CHALLENGE_MEDAL_BRONZE] = "Interface\\Challenges\\challenges-bronze",
	[CHALLENGE_MEDAL_SILVER] = "Interface\\Challenges\\challenges-silver",
	[CHALLENGE_MEDAL_GOLD]   = "Interface\\Challenges\\challenges-gold",
	[CHALLENGE_MEDAL_PLAT]   = "Interface\\Challenges\\challenges-plat",
}
CHALLENGE_MEDAL_TEXTURES_SMALL = {
	[CHALLENGE_MEDAL_BRONZE] = "Interface\\Challenges\\challenges-bronze-sm",
	[CHALLENGE_MEDAL_SILVER] = "Interface\\Challenges\\challenges-silver-sm",
	[CHALLENGE_MEDAL_GOLD]   = "Interface\\Challenges\\challenges-gold-sm",
	[CHALLENGE_MEDAL_PLAT]   = "Interface\\Challenges\\challenges-plat-sm",
}

-- Player Reporting
PLAYER_REPORT_TYPE_SPAM = "spam";
PLAYER_REPORT_TYPE_LANGUAGE = "language";
PLAYER_REPORT_TYPE_ABUSE = "abuse";
PLAYER_REPORT_TYPE_BAD_PLAYER_NAME = "badplayername";
PLAYER_REPORT_TYPE_BAD_GUILD_NAME = "badguildname";
PLAYER_REPORT_TYPE_CHEATING = "cheater";
PLAYER_REPORT_TYPE_BAD_BATTLEPET_NAME = "badbattlepetname";
PLAYER_REPORT_TYPE_BAD_PET_NAME = "badpetname";

--Loot
BONUS_ROLL_REQUIRED_CURRENCY = 697;

-- Quest
QUEST_TYPE_DUNGEON = 81;
QUEST_TYPE_SCENARIO = 98;

MAX_QUESTS = 25;
MAX_OBJECTIVES = 20;
MAX_QUESTLOG_QUESTS = 25;

WORLD_QUESTS_TIME_CRITICAL_MINUTES = 15;
WORLD_QUESTS_TIME_LOW_MINUTES = 75;

WORLD_QUESTS_AVAILABLE_QUEST_ID = 43341;

-- LFG
LFG_CATEGORY_NAMES = {
	[LE_LFG_CATEGORY_LFD] = LOOKING_FOR_DUNGEON,
	[LE_LFG_CATEGORY_RF] = RAID_FINDER,
	[LE_LFG_CATEGORY_SCENARIO] = SCENARIOS,
	[LE_LFG_CATEGORY_LFR] = LOOKING_FOR_RAID,
	[LE_LFG_CATEGORY_FLEXRAID] = FLEX_RAID,
	[LE_LFG_CATEGORY_WORLDPVP] = WORLD_PVP,
	[LE_LFG_CATEGORY_BATTLEFIELD] = LFG_CATEGORY_BATTLEFIELD,
}

-- PVP
MAX_ARENA_TEAMS = 2;
MAX_WORLD_PVP_QUEUES = 2;
CONQUEST_SIZE_STRINGS = { RATED_SOLO_SHUFFLE_SIZE, ARENA_2V2, ARENA_3V3, BATTLEGROUND_10V10 };
CONQUEST_TYPE_STRINGS = { ARENA, ARENA, ARENA, BATTLEGROUNDS };
CONQUEST_SIZES = { 1, 2, 3, 10 };
CONQUEST_BRACKET_INDEXES = { 7, 1, 2, 4 }; -- 5v5 was removed

-- Chat
CHANNEL_INVITE_TIMEOUT = 60;

-- Scenarios
SCENARIO_FLAG_DEPRECATED1			= 0x00000001;
SCENARIO_FLAG_SUPRESS_STAGE_TEXT	= 0x00000002;
SCENARIO_FLAG_DEPRECATED2			= 0x00000004;
SCENARIO_FLAG_DEPRECATED3			= 0x00000008;

-- Lua Warning types
LUA_WARNING_TREAT_AS_ERROR = 0;

-- Quest Tags
QUEST_ICONS_FILE = "Interface\\QuestFrame\\QuestTypeIcons";
QUEST_ICONS_FILE_WIDTH = 128;
QUEST_ICONS_FILE_HEIGHT = 64;

QUEST_TAG_TCOORDS = {
	["COMPLETED"] = { 0.140625, 0.28125, 0, 0.28125 },
	["DAILY"] = { 0.28125, 0.421875, 0, 0.28125 },
	["WEEKLY"] = { 0.28125, 0.421875, 0.5625, 0.84375 },
	["FAILED"] = { 0.84375, 0.984375, 0.28125, 0.5625 },
	["STORY"] = { 0.703125, 0.84375, 0.28125, 0.5625 },
	["ALLIANCE"] = { 0.421875, 0.5625, 0.28125, 0.5625 },
	["HORDE"] = { 0.5625, 0.703125, 0.28125, 0.5625 },
	["EXPIRING_SOON"] = { 0.84375, 0.984375, 0.5625, 0.84375 },
	["EXPIRING"] = { 0.703125, 0.84375, 0.5625, 0.84375 },
	[Enum.QuestTag.Dungeon] = { 0.421875, 0.5625, 0, 0.28125 },
	[Enum.QuestTag.Scenario] = { 0.5625, 0.703125, 0, 0.28125 },
	[Enum.QuestTag.Account] = { 0.84375, 0.984375, 0, 0.28125 },
	[Enum.QuestTag.Legendary] = { 0, 0.140625, 0.28125, 0.5625 },
	[Enum.QuestTag.Group] = { 0.140625, 0.28125, 0.28125, 0.5625 },
	[Enum.QuestTag.PvP] = { 0.28125, 0.421875, 0.28125, 0.5625 },
	[Enum.QuestTag.Heroic] = { 0, 0.140625, 0.5625, 0.84375 },
	-- same texture for all raids
	[Enum.QuestTag.Raid] = { 0.703125, 0.84375, 0, 0.28125 },
	[Enum.QuestTag.Raid10] = { 0.703125, 0.84375, 0, 0.28125 },
	[Enum.QuestTag.Raid25] = { 0.703125, 0.84375, 0, 0.28125 },
};

WORLD_QUEST_TYPE_TCOORDS = {
	[Enum.QuestTagType.Dungeon] = { 0.421875, 0.5625, 0, 0.28125 },
	[Enum.QuestTagType.Raid] = { 0.703125, 0.84375, 0, 0.28125 },
};

-- MATCH CONDITIONS
MATCH_CONDITION_WRONG_ACHIEVEMENT = 34;
MATCH_CONDITION_SUCCESS = 57;

-- FOR ABBREVIATING LARGE NUMBERS
FIRST_NUMBER_CAP_VALUE = 1000;

-- GARRISONS
GARRISON_HIGH_THREAT_VALUE = 300;
LOOT_SOURCE_GARRISON_CACHE = 10;
WOW_TOKEN_ITEM_ID = 122284;

-- TRANSMOG
ENCHANT_EMPTY_SLOT_FILEDATAID = 134941;
WARDROBE_TOOLTIP_CYCLE_ARROW_ICON = "|TInterface\\Transmogrify\\transmog-tooltip-arrow:12:11:-1:-1|t";
WARDROBE_TOOLTIP_CYCLE_SPACER_ICON = "|TInterface\\Common\\spacer:12:11:-1:-1|t";
WARDROBE_CYCLE_KEY = "TAB";
WARDROBE_PREV_VISUAL_KEY = "LEFT";
WARDROBE_NEXT_VISUAL_KEY = "RIGHT";
WARDROBE_UP_VISUAL_KEY = "UP";
WARDROBE_DOWN_VISUAL_KEY = "DOWN";

TRANSMOG_INVALID_CODES = {
	"NO_ITEM",
	"NOT_SOULBOUND",
	"LEGENDARY",
	"ITEM_TYPE",
	"DESTINATION",
	"MISMATCH",
	"",		-- same item
	"",		-- invalid source
	"",		-- invalid source quality
	"CANNOT_USE",
	"SLOT_FOR_RACE",
	"",		-- no illusion
	"SLOT_FOR_FORM",
}

TRANSMOG_SOURCE_BOSS_DROP = 1;

FIRST_TRANSMOG_COLLECTION_WEAPON_TYPE = Enum.TransmogCollectionType.Wand;
LAST_TRANSMOG_COLLECTION_WEAPON_TYPE = Enum.TransmogCollectionTypeMeta.NumValues - 1;
NO_TRANSMOG_VISUAL_ID = 0;
REMOVE_TRANSMOG_ID = 0;

-- ITEMSUBCLASSTYPES
ITEMSUBCLASSTYPES = {
	["DAGGER"] = { classID = 2, subClassID = 15},
}

-- MINIMAP
TYPEID_DUNGEON = 1;
TYPEID_RANDOM_DUNGEON = 6;

LFG_SUBTYPEID_DUNGEON = 1;
LFG_SUBTYPEID_HEROIC = 2;
LFG_SUBTYPEID_RAID = 3;
LFG_SUBTYPEID_SCENARIO = 4;
LFG_SUBTYPEID_FLEXRAID = 5;
LFG_SUBTYPEID_WORLDPVP = 6;

-- TEXTURES
QUESTION_MARK_ICON = "INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK.BLP";


UPPER_LEFT_VERTEX = 1;
LOWER_LEFT_VERTEX = 2;
UPPER_RIGHT_VERTEX = 3;
LOWER_RIGHT_VERTEX = 4;

-- TUTORIALS
HELPTIP_HEIGHT_PADDING = 29;

-- RELIC TALENTS
RELIC_TALENT_TYPE_LIGHT = 1;
RELIC_TALENT_TYPE_VOID = 2;
RELIC_TALENT_TYPE_NEUTRAL = 3;

RELIC_TALENT_STYLE_CLOSED = 1;
RELIC_TALENT_STYLE_UPCOMING = 2;
RELIC_TALENT_STYLE_AVAILABLE = 3;
RELIC_TALENT_STYLE_CHOSEN = 4;

RELIC_TALENT_LINK_TYPE_LIGHT = 1;
RELIC_TALENT_LINK_TYPE_VOID = 2;

RELIC_TALENT_LINK_STYLE_DISABLED = 1;
RELIC_TALENT_LINK_STYLE_POTENTIAL = 2;
RELIC_TALENT_LINK_STYLE_ACTIVE = 3;
RELIC_TALENT_LINK_STYLE_UPCOMING = 4;
RELIC_TALENT_LINK_STYLE_AVAILABLE = 5;

-- TODO: Need to be able to expose this from client...
Enum.ChatChannelType = {
	None = 0,
	Custom = 1,
	Private_Party = 2,
	Public_Party = 3,
	Communities = 4,
};

CALENDAR_INVITESTATUS_INFO = {
	["UNKNOWN"] = {
		name		= UNKNOWN,
		color		= NORMAL_FONT_COLOR,
	},
	[Enum.CalendarStatus.Confirmed] = {
		name		= CALENDAR_STATUS_CONFIRMED,
		color		= GREEN_FONT_COLOR,
	},
	[Enum.CalendarStatus.Available] = {
		name		= CALENDAR_STATUS_ACCEPTED,
		color		= GREEN_FONT_COLOR,
	},
	[Enum.CalendarStatus.Declined] = {
		name		= CALENDAR_STATUS_DECLINED,
		color		= RED_FONT_COLOR,
	},
	[Enum.CalendarStatus.Out] = {
		name		= CALENDAR_STATUS_OUT,
		color		= RED_FONT_COLOR,
	},
	[Enum.CalendarStatus.Standby] = {
		name		= CALENDAR_STATUS_STANDBY,
		color		= ORANGE_FONT_COLOR,
	},
	[Enum.CalendarStatus.Invited] = {
		name		= CALENDAR_STATUS_INVITED,
		color		= NORMAL_FONT_COLOR,
	},
	[Enum.CalendarStatus.Signedup] = {
		name		= CALENDAR_STATUS_SIGNEDUP,
		color		= GREEN_FONT_COLOR,
	},
	[Enum.CalendarStatus.NotSignedup] = {
		name		= CALENDAR_STATUS_NOT_SIGNEDUP,
		color		= GRAY_FONT_COLOR,
	},
	[Enum.CalendarStatus.Tentative] = {
		name		= CALENDAR_STATUS_TENTATIVE,
		color		= ORANGE_FONT_COLOR,
	},
};

TOOLTIP_INDENT_OFFSET = 10;

function SetGamepadBindingStrings(mainBinding, abbrBinding, name)
	_G[mainBinding] = ("|A:Gamepad_%s_64:24:24|a"):format(name);
	_G[abbrBinding] = ("|A:Gamepad_%s_64:14:14|a"):format(name);
end

-- Generic GamePad button labels
SetGamepadBindingStrings("KEY_PADDUP",			"KEY_ABBR_PADDUP",			"Gen_Up");
SetGamepadBindingStrings("KEY_PADDRIGHT",		"KEY_ABBR_PADDRIGHT",		"Gen_Right");
SetGamepadBindingStrings("KEY_PADDDOWN",		"KEY_ABBR_PADDDOWN",		"Gen_Down");
SetGamepadBindingStrings("KEY_PADDLEFT",		"KEY_ABBR_PADDLEFT",		"Gen_Left");
SetGamepadBindingStrings("KEY_PAD1",			"KEY_ABBR_PAD1",			"Gen_1");
SetGamepadBindingStrings("KEY_PAD2",			"KEY_ABBR_PAD2",			"Gen_2");
SetGamepadBindingStrings("KEY_PAD3",			"KEY_ABBR_PAD3",			"Gen_3");
SetGamepadBindingStrings("KEY_PAD4",			"KEY_ABBR_PAD4",			"Gen_4");
SetGamepadBindingStrings("KEY_PAD5",			"KEY_ABBR_PAD5",			"Gen_5");
SetGamepadBindingStrings("KEY_PAD6",			"KEY_ABBR_PAD6",			"Gen_6");
SetGamepadBindingStrings("KEY_PADLSTICK",		"KEY_ABBR_PADLSTICK",		"Gen_LStickIn");
SetGamepadBindingStrings("KEY_PADRSTICK",		"KEY_ABBR_PADRSTICK",		"Gen_RStickIn");
SetGamepadBindingStrings("KEY_PADLSHOULDER",	"KEY_ABBR_PADLSHOULDER",	"Gen_LShoulder");
SetGamepadBindingStrings("KEY_PADRSHOULDER",	"KEY_ABBR_PADRSHOULDER",	"Gen_RShoulder");
SetGamepadBindingStrings("KEY_PADLTRIGGER",		"KEY_ABBR_PADLTRIGGER",		"Gen_LTrigger");
SetGamepadBindingStrings("KEY_PADRTRIGGER",		"KEY_ABBR_PADRTRIGGER",		"Gen_RTrigger");
SetGamepadBindingStrings("KEY_PADLSTICKUP",		"KEY_ABBR_PADLSTICKUP",		"Gen_LStickUp");
SetGamepadBindingStrings("KEY_PADLSTICKRIGHT",	"KEY_ABBR_PADLSTICKRIGHT",	"Gen_LStickRight");
SetGamepadBindingStrings("KEY_PADLSTICKDOWN",	"KEY_ABBR_PADLSTICKDOWN",	"Gen_LStickDown");
SetGamepadBindingStrings("KEY_PADLSTICKLEFT",	"KEY_ABBR_PADLSTICKLEFT",	"Gen_LStickLeft");
SetGamepadBindingStrings("KEY_PADRSTICKUP",		"KEY_ABBR_PADRSTICKUP",		"Gen_RStickUp");
SetGamepadBindingStrings("KEY_PADRSTICKRIGHT",	"KEY_ABBR_PADRSTICKRIGHT",	"Gen_RStickRight");
SetGamepadBindingStrings("KEY_PADRSTICKDOWN",	"KEY_ABBR_PADRSTICKDOWN",	"Gen_RStickDown");
SetGamepadBindingStrings("KEY_PADRSTICKLEFT",	"KEY_ABBR_PADRSTICKLEFT",	"Gen_RStickLeft");
SetGamepadBindingStrings("KEY_PADPADDLE1",		"KEY_ABBR_PADPADDLE1",		"Gen_Paddle1");
SetGamepadBindingStrings("KEY_PADPADDLE2",		"KEY_ABBR_PADPADDLE2",		"Gen_Paddle2");
SetGamepadBindingStrings("KEY_PADPADDLE3",		"KEY_ABBR_PADPADDLE3",		"Gen_Paddle3");
SetGamepadBindingStrings("KEY_PADPADDLE4",		"KEY_ABBR_PADPADDLE4",		"Gen_Paddle4");
SetGamepadBindingStrings("KEY_PADFORWARD",		"KEY_ABBR_PADFORWARD",		"Gen_Forward");
SetGamepadBindingStrings("KEY_PADBACK",			"KEY_ABBR_PADBACK",			"Gen_Back");
SetGamepadBindingStrings("KEY_PADSYSTEM",		"KEY_ABBR_PADSYSTEM",		"Gen_System");
SetGamepadBindingStrings("KEY_PADSOCIAL",		"KEY_ABBR_PADSOCIAL",		"Gen_Share");
-- "Letters" label style specializations
SetGamepadBindingStrings("KEY_PADDUP_LTR",		"KEY_ABBR_PADDUP_LTR",		"Ltr_Up");
SetGamepadBindingStrings("KEY_PADDRIGHT_LTR",	"KEY_ABBR_PADDRIGHT_LTR",	"Ltr_Right");
SetGamepadBindingStrings("KEY_PADDDOWN_LTR",	"KEY_ABBR_PADDDOWN_LTR",	"Ltr_Down");
SetGamepadBindingStrings("KEY_PADDLEFT_LTR",	"KEY_ABBR_PADDLEFT_LTR",	"Ltr_Left");
SetGamepadBindingStrings("KEY_PAD1_LTR",		"KEY_ABBR_PAD1_LTR",		"Ltr_A");
SetGamepadBindingStrings("KEY_PAD2_LTR",		"KEY_ABBR_PAD2_LTR",		"Ltr_B");
SetGamepadBindingStrings("KEY_PAD3_LTR",		"KEY_ABBR_PAD3_LTR",		"Ltr_X");
SetGamepadBindingStrings("KEY_PAD4_LTR",		"KEY_ABBR_PAD4_LTR",		"Ltr_Y");
SetGamepadBindingStrings("KEY_PADLSHOULDER_LTR","KEY_ABBR_PADLSHOULDER_LTR","Ltr_LShoulder");
SetGamepadBindingStrings("KEY_PADRSHOULDER_LTR","KEY_ABBR_PADRSHOULDER_LTR","Ltr_RShoulder");
SetGamepadBindingStrings("KEY_PADLTRIGGER_LTR",	"KEY_ABBR_PADLTRIGGER_LTR",	"Ltr_LTrigger");
SetGamepadBindingStrings("KEY_PADRTRIGGER_LTR",	"KEY_ABBR_PADRTRIGGER_LTR",	"Ltr_RTrigger");
SetGamepadBindingStrings("KEY_PADFORWARD_LTR",	"KEY_ABBR_PADFORWARD_LTR",	"Ltr_Menu");
SetGamepadBindingStrings("KEY_PADBACK_LTR",		"KEY_ABBR_PADBACK_LTR",		"Ltr_View");
SetGamepadBindingStrings("KEY_PADSYSTEM_LTR",	"KEY_ABBR_PADSYSTEM_LTR",	"Ltr_System");
SetGamepadBindingStrings("KEY_PADSOCIAL_LTR",	"KEY_ABBR_PADSOCIAL_LTR",	"Ltr_Share");
-- "Shapes" label style specializations
SetGamepadBindingStrings("KEY_PADDUP_SHP",		"KEY_ABBR_PADDUP_SHP",		"Shp_Up");
SetGamepadBindingStrings("KEY_PADDRIGHT_SHP",	"KEY_ABBR_PADDRIGHT_SHP",	"Shp_Right");
SetGamepadBindingStrings("KEY_PADDDOWN_SHP",	"KEY_ABBR_PADDDOWN_SHP",	"Shp_Down");
SetGamepadBindingStrings("KEY_PADDLEFT_SHP",	"KEY_ABBR_PADDLEFT_SHP",	"Shp_Left");
SetGamepadBindingStrings("KEY_PAD1_SHP",		"KEY_ABBR_PAD1_SHP",		"Shp_Cross");
SetGamepadBindingStrings("KEY_PAD2_SHP",		"KEY_ABBR_PAD2_SHP",		"Shp_Circle");
SetGamepadBindingStrings("KEY_PAD3_SHP",		"KEY_ABBR_PAD3_SHP",		"Shp_Square");
SetGamepadBindingStrings("KEY_PAD4_SHP",		"KEY_ABBR_PAD4_SHP",		"Shp_Triangle");
SetGamepadBindingStrings("KEY_PAD5_SHP",		"KEY_ABBR_PAD5_SHP",		"Shp_MicMute");
SetGamepadBindingStrings("KEY_PAD6_SHP",		"KEY_ABBR_PAD6_SHP",		"Shp_TouchpadR");
SetGamepadBindingStrings("KEY_PADLSTICK_SHP",	"KEY_ABBR_PADLSTICK_SHP",	"Shp_LStickIn");
SetGamepadBindingStrings("KEY_PADRSTICK_SHP",	"KEY_ABBR_PADRSTICK_SHP",	"Shp_RStickIn");
SetGamepadBindingStrings("KEY_PADLSHOULDER_SHP","KEY_ABBR_PADLSHOULDER_SHP","Shp_LShoulder");
SetGamepadBindingStrings("KEY_PADRSHOULDER_SHP","KEY_ABBR_PADRSHOULDER_SHP","Shp_RShoulder");
SetGamepadBindingStrings("KEY_PADLTRIGGER_SHP",	"KEY_ABBR_PADLTRIGGER_SHP",	"Shp_LTrigger");
SetGamepadBindingStrings("KEY_PADRTRIGGER_SHP",	"KEY_ABBR_PADRTRIGGER_SHP",	"Shp_RTrigger");
SetGamepadBindingStrings("KEY_PADFORWARD_SHP",	"KEY_ABBR_PADFORWARD_SHP",	"Shp_Menu");
SetGamepadBindingStrings("KEY_PADBACK_SHP",		"KEY_ABBR_PADBACK_SHP",		"Shp_TouchpadL");
SetGamepadBindingStrings("KEY_PADSYSTEM_SHP",	"KEY_ABBR_PADSYSTEM_SHP",	"Shp_System");
SetGamepadBindingStrings("KEY_PADSOCIAL_SHP",	"KEY_ABBR_PADSOCIAL_SHP",	"Shp_Share");
-- "Reverse" label style specializations
SetGamepadBindingStrings("KEY_PAD1_REV",		"KEY_ABBR_PAD1_REV",		"Rev_B");
SetGamepadBindingStrings("KEY_PAD2_REV",		"KEY_ABBR_PAD2_REV",		"Rev_A");
SetGamepadBindingStrings("KEY_PAD3_REV",		"KEY_ABBR_PAD3_REV",		"Rev_Y");
SetGamepadBindingStrings("KEY_PAD4_REV",		"KEY_ABBR_PAD4_REV",		"Rev_X");
SetGamepadBindingStrings("KEY_PADLSHOULDER_REV","KEY_ABBR_PADLSHOULDER_REV","Rev_LShoulder");
SetGamepadBindingStrings("KEY_PADRSHOULDER_REV","KEY_ABBR_PADRSHOULDER_REV","Rev_RShoulder");
SetGamepadBindingStrings("KEY_PADLTRIGGER_REV",	"KEY_ABBR_PADLTRIGGER_REV",	"Rev_LTrigger");
SetGamepadBindingStrings("KEY_PADRTRIGGER_REV",	"KEY_ABBR_PADRTRIGGER_REV",	"Rev_RTrigger");
SetGamepadBindingStrings("KEY_PADFORWARD_REV",	"KEY_ABBR_PADFORWARD_REV",	"Rev_Plus");
SetGamepadBindingStrings("KEY_PADBACK_REV",		"KEY_ABBR_PADBACK_REV",		"Rev_Minus");
SetGamepadBindingStrings("KEY_PADSYSTEM_REV",	"KEY_ABBR_PADSYSTEM_REV",	"Rev_Home");
SetGamepadBindingStrings("KEY_PADSOCIAL_REV",	"KEY_ABBR_PADSOCIAL_REV",	"Rev_Capture");
