class UIHudBurns extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDBURNS_ARROWS = 2;
const UIHUDBURNS_GROUPS = 4;
const UIHUDBURNS_OPTIONS = 5;
const UIHUDBURNS_UPGRADES = 3;
const UIHUDBURNS_DEFT_HANDS_ITEM_ID = 13235;

struct native UIITEMRANK
{
    var int nId;
    var int nRank;

    structdefaultproperties
    {
        nId=0
        nRank=0
    }
};

struct native UIITEMDATA
{
    var GFxObject Obj;
    var GFxObject Icon;
    var GFxObject frame;
    var GFxObject Title;
    var GFxObject Price;
    var GFxObject Button;
    var GFxObject Selected;
    var GFxObject SubTitle;

    structdefaultproperties
    {
        Obj=none
        Icon=none
        frame=none
        Title=none
        Price=none
        Button=none
        Selected=none
        SubTitle=none
    }
};

struct native UIITEMGROUP
{
    var GFxObject Obj;
    var GFxObject Title;
    var GFxObject Items;
    var GFxObject frame;
    var UIITEMDATA Item[5];

    structdefaultproperties
    {
        Obj=none
        Title=none
        Items=none
        frame=none
        Item[0]=(Obj=none,Icon=none,frame=none,Title=none,Price=none,Button=none,Selected=none,SubTitle=none)
        Item[1]=(Obj=none,Icon=none,frame=none,Title=none,Price=none,Button=none,Selected=none,SubTitle=none)
        Item[2]=(Obj=none,Icon=none,frame=none,Title=none,Price=none,Button=none,Selected=none,SubTitle=none)
        Item[3]=(Obj=none,Icon=none,frame=none,Title=none,Price=none,Button=none,Selected=none,SubTitle=none)
        Item[4]=(Obj=none,Icon=none,frame=none,Title=none,Price=none,Button=none,Selected=none,SubTitle=none)
    }
};

var int m_nCredits;
var int m_nActiveItem;
var bool m_bOpenPostTimelapse;
var UIITEMRANK m_Items[4];
var UIITEMRANK m_Temps[4];
var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcSubtitle;
var GFxObject m_mcCredits;
var GFxObject m_mcInfo;
var GFxObject m_mcInfoFrame;
var GFxObject m_mcInfoTitle;
var GFxObject m_mcInfoSubtitle;
var GFxObject m_mcAutoBuyDialogue;
var GFxObject m_mcAutoBuyTitle;
var GFxObject m_mcAutoBuyDesc;
var GFxObject m_mcAutoBuyPrompt;
var UIITEMDATA m_mcInfoUpgrade[3];
var GFxObject m_mcInfoUpgradeArrow[2];
var UIInteractable_Button m_AutoBuyOffButton;
var UIITEMGROUP m_Group[4];
var AkBaseSoundObject m_scPurchase;
var TgGFxGroup m_grItem;

defaultproperties
{
    m_scPurchase=AkEvent'WW_UI_Default.UI_InGame_Card_Select_Play'
    m_OptionList[0]=137
    m_OptionList[1]=23
    m_OptionList[2]=0
    m_ePromptAlignment=UIALIGNINGTYPE.UIALIGNING_LEFT
    m_fPromptOffsetX=80.0000000
    m_bBlur=true
    m_bAlwaysTick=true
    m_Name="UIHudBurns"
    m_scShown=AkEvent'WW_UI_Default.UI_InGame_Card_Burn_Play'
}