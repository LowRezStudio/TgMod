class UIScene_UIHudSkills extends UIScene
    native(UIComponent)
    config(Engine);

const UIHUDSKILLS_COUNT = 5;

var UIComponent_HudSkillIcon m_pSkillIcon[5];
var UIComponent_HudSkillIcon m_pAltSkillIconA;
var UIComponent_HudSkillIcon m_pAltSkillIconB;
var float m_fSkillRotation;
var GFxObject m_mcGroupA;
var GFxObject m_mcGroupB;
var UIComponent_LexVengeance m_LexVengeance;
var UIComponent_OracleSoulCharges m_OracleSoulCharges;
var int m_nSpectatorMode;

event AnimateWeaponSwap(float fSwapTime) { }

event ApplyAltSkillOffsets() { }

defaultproperties
{
    m_fSkillRotation=25.0000000
}
