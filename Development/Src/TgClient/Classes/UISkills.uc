class UISkills extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UISKILLS_COUNT = 5;

var GFxObject m_mcTitle;
var GFxObject m_mcSubtitle;
var GFxObject m_mcSkill[5];
var GFxObject m_mcSkillKey[5];
var GFxObject m_mcSkillBase[5];
var GFxObject m_mcSkillIcon[5];
var GFxObject m_mcSkillTitle[5];
var GFxObject m_mcSkillDamage[5];
var GFxObject m_mcSkillSubtitle[5];
var GFxObject m_mcSkillCooldown[5];
var GFxObject m_mcSkillCooldownTF[5];

defaultproperties
{
    m_UISceneClass=Class'UIScene_SceneAsPopup'
    m_OptionList[0]=249
    m_bBlur=true
    m_bIsPopup=true
    m_Name="UISkills"
}
