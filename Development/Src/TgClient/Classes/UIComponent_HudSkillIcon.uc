class UIComponent_HudSkillIcon extends UIComponent
    native(UIComponent)
    config(Engine);

var GFxObject m_mcSkill;
var GFxObject m_mcSkillBtn;
var GFxObject m_mcSkillKey;
var GFxObject m_mcSkillIcon;
var GFxObject m_mcSkillCDBot;
var GFxObject m_mcSkillCDTop;
var GFxObject m_mcSkillTimer;
var GFxObject m_mcSkillPulse;
var GFxObject m_mcSkillReady;
var GFxObject m_mcSkillActive;
var GFxObject m_mcSkillMouse;
var GFxObject m_mcSkillAmmo;
var GFxObject m_mcSkillShadow;
var bool m_bUsingIconOverride;
var int m_nSkillIconIndex;
var int m_nSkillId;
var int m_nSkillAmmo;
var int m_nSkillActive;
var int m_nSkillStatus;
var float m_fSkillCharge;
var float m_fSkillChargeTime;
var float m_fReadyTimer;
var string m_sSkillBind;
