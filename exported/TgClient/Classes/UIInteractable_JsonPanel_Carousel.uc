class UIInteractable_JsonPanel_Carousel extends UIInteractable_JsonPanel
    native(UIComponent);

var GFxObject m_mcNavControlsRoot;
var UIInteractable_Button m_mcLeftArrow;
var UIInteractable_Button m_mcRightArrow;
var GFxObject m_mcLeftButtonPrompt;
var GFxObject m_mcRightButtonPrompt;
var GFxObject m_mcImage2;
var bool m_bOnImage2;
var bool m_bPauseAutoRotation;
var int m_nIndex;
var UIInteractable_Button m_mcActivate;
var array<UIInteractable_Button> m_NavDots;
var float m_fNavDotCenter;
var init array<init JsonFeatureData> m_CarouselJsonFeatureData;
var float m_fDotPlacementX;
var float m_fDotWidth;
var float m_fDotPadding;
var float m_fAutoRotationTime;
var float m_fAutoRotationDelay;
var name m_GamepadLeftKey;
var name m_GamepadRightKey;

defaultproperties
{
    m_fAutoRotationDelay=5.0000000
}