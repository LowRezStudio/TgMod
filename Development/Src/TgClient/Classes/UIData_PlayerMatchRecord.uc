class UIData_PlayerMatchRecord extends UIData
    native(UIData)
    config(Engine);

const UIDATA_PLAYERMATCHRECORD_DECKSIZE = 5;

const UIDATA_PLAYERMATCHRECORD_ITEMCOUNT = 4;

var int nBotId;
var int nPlayerId;
var int nLevel;
var int nKills;
var int nDeaths;
var int nAssists;
var int nEarnedCredits;
var int nHealingPlayer;
var int nHealingBot;
var int nHealingTotal;
var int nSelfHealing;
var int nDmgTaken;
var int nDmgPlayer;
var int nDmgBot;
var int nDmgTotal;
var int nSoloKills;
var int nFlankKills;
var int nMultikill;
var int nKillstreak;
var int nDmgStructure;
var int nDmgMitigated;
var int nObjectiveTime;
var int nCards[5];
var int nLegendary;
var int nPurchasedItems[4];
var int nPurchasedItemLevels[4];
var int nMountItemId;
var int nEmoteItemId;
var int nMVPPoseItemId;
var int nSprayItemId;
var int nTitleItemId;
var int nTaskForce;
var bool bAlly;
var bool bLocal;
var bool bReported;
var init string sPlayer;
var init string sClass;
var UniqueNetId ConsoleUniqueId;
