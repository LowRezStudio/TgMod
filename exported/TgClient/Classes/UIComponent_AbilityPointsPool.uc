class UIComponent_AbilityPointsPool extends UIComponent
    native(UIComponent);

const NUM_ABILITYPOINTPOOL_SKILLS = 4;

var bool m_bDirty;
var int m_nTickCallbackHandle;
var GFxObject m_mcAbilityPointsPool;
var GFxObject m_mcAbilityIcon[4];
var GFxObject m_mcPointsFill[4];
var GFxObject m_mcPointsText[4];
var GFxObject m_mcTalentFocusFrame[4];
var float m_fFillWidth;
var int m_nPoints[4];
var UIDataItem.AbilityModifiedByDevice m_eFocusedAbility;
