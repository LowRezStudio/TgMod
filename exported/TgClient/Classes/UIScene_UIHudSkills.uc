class UIScene_UIHudSkills extends UIScene
    native(UIComponent);

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

event AnimateWeaponSwap(float fSwapTime)
{
    m_pAltSkillIconA.m_mcRoot.SetY(-90.0000000);
    m_pSkillIcon[0].m_mcRoot.SetY(-77.0000000);
    m_pAltSkillIconA.m_mcRoot.SetAlpha(50.0000000);
    m_pSkillIcon[0].m_mcRoot.SetAlpha(100.0000000);
    Animate(m_pAltSkillIconA.m_mcRoot, 0.1200000, 1, -120.0000000, 0.0200000,, true);
    Animate(m_pAltSkillIconA.m_mcRoot, 0.0500000, 1, -40.0000000, 0.1700000,, false);
    Animate(m_pAltSkillIconA.m_mcRoot, 0.1200000, 1, -90.0000000, 0.2200000,, false);
    Animate(m_pAltSkillIconA.m_mcRoot, 0.0500000, 2, 0.0000000, 0.0200000,, true);
    Animate(m_pAltSkillIconA.m_mcRoot, 0.0500000, 2, 50.0000000, 0.2200000,, false);
    Animate(m_pSkillIcon[0].m_mcRoot, 0.1000000, 1, 7.0000000,,, true);
    Animate(m_pSkillIcon[0].m_mcRoot, 0.0500000, 1, -157.0000000, 0.1500000,, false);
    Animate(m_pSkillIcon[0].m_mcRoot, 0.1000000, 1, -67.0000000, 0.2000000,, false);
    Animate(m_pSkillIcon[0].m_mcRoot, 0.0200000, 1, -77.0000000, 0.3000000,, false);
    Animate(m_pSkillIcon[0].m_mcRoot, 0.0850000, 2, 0.0000000,,, true);
    Animate(m_pSkillIcon[0].m_mcRoot, 0.0500000, 2, 100.0000000, 0.2000000,, false);
    m_pAltSkillIconB.m_mcRoot.SetY(-90.0000000);
    m_pSkillIcon[5 - 1].m_mcRoot.SetY(-77.0000000);
    m_pAltSkillIconB.m_mcRoot.SetAlpha(50.0000000);
    m_pSkillIcon[5 - 1].m_mcRoot.SetAlpha(100.0000000);
    Animate(m_pAltSkillIconB.m_mcRoot, 0.1200000, 1, -120.0000000, 0.0200000,, true);
    Animate(m_pAltSkillIconB.m_mcRoot, 0.0500000, 1, -40.0000000, 0.1700000,, false);
    Animate(m_pAltSkillIconB.m_mcRoot, 0.1200000, 1, -90.0000000, 0.2200000,, false);
    Animate(m_pAltSkillIconB.m_mcRoot, 0.0500000, 2, 0.0000000, 0.0200000,, true);
    Animate(m_pAltSkillIconB.m_mcRoot, 0.0500000, 2, 50.0000000, 0.2200000,, false);
    Animate(m_pSkillIcon[5 - 1].m_mcRoot, 0.1000000, 1, 7.0000000,,, true);
    Animate(m_pSkillIcon[5 - 1].m_mcRoot, 0.0500000, 1, -157.0000000, 0.1200000,, false);
    Animate(m_pSkillIcon[5 - 1].m_mcRoot, 0.1000000, 1, -67.0000000, 0.2000000,, false);
    Animate(m_pSkillIcon[5 - 1].m_mcRoot, 0.0200000, 1, -77.0000000, 0.3000000,, false);
    Animate(m_pSkillIcon[5 - 1].m_mcRoot, 0.0850000, 2, 0.0000000,,, true);
    Animate(m_pSkillIcon[5 - 1].m_mcRoot, 0.1000000, 2, 100.0000000, 0.2000000,, false);
    //return;    
}

event ApplyAltSkillOffsets()
{
    m_pAltSkillIconA.m_mcRoot.SetX(-32.0000000);
    m_pAltSkillIconB.m_mcRoot.SetX(-30.0000000);
    m_pAltSkillIconA.m_mcRoot.SetY(-90.0000000);
    m_pAltSkillIconB.m_mcRoot.SetY(-90.0000000);
    m_pAltSkillIconA.m_mcRoot.SetXScale(m_pAltSkillIconA.m_mcRoot.m_fOrigScaleX * 0.7500000);
    m_pAltSkillIconB.m_mcRoot.SetXScale(m_pAltSkillIconB.m_mcRoot.m_fOrigScaleX * 0.7500000);
    m_pAltSkillIconA.m_mcRoot.SetYScale(m_pAltSkillIconA.m_mcRoot.m_fOrigScaleY * 0.7500000);
    m_pAltSkillIconB.m_mcRoot.SetYScale(m_pAltSkillIconB.m_mcRoot.m_fOrigScaleY * 0.7500000);
    m_pAltSkillIconA.m_mcRoot.SetAlpha(70.0000000);
    m_pAltSkillIconB.m_mcRoot.SetAlpha(70.0000000);
    //return;    
}

defaultproperties
{
    m_fSkillRotation=25.0000000
}