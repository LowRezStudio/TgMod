class UIComponent_OracleSoulCharges extends UIComponent
    native(UIComponent);

enum SoulChargesAnimEvent
{
    SoulChargesAE_Show,             // 0
    SoulChargesAE_Hide,             // 1
    SoulChargesAE_Increase,         // 2
    SoulChargesAE_Decrease,         // 3
    SoulChargesAE_MaxStacks,        // 4
    SoulChargesAE_MAX               // 5
};

var TgPawn m_CurrentViewPawn;
var TgPawn m_CurrentTargetPawn;
var GFxObject m_mcText;
var GFxObject m_mcIcon;
var GFxObject m_mcAnim;
var GFxObject m_mcMaxStacks;
var bool m_bIsHiding;
var bool m_bEnabled;
var int m_nCurrentSoulCharges;

event float HandleAnimEvent(int nEventType, optional array<float> fExtraData)
{
    switch(nEventType)
    {
        // End:0x2E7
        case 0:
            m_bIsHiding = false;
            EndAnim(m_mcAnim);
            EndAnim(m_mcIcon);
            EndAnim(m_mcText);
            EndAnim(m_mcMaxStacks);
            m_mcText.SetXScale(80.0000000);
            m_mcText.SetYScale(80.0000000);
            m_mcText.SetAlpha(85.0000000);
            m_mcIcon.SetXScale(80.0000000);
            m_mcIcon.SetYScale(80.0000000);
            m_mcIcon.SetAlpha(100.0000000);
            m_mcMaxStacks.SetVisible(false);
            m_mcMaxStacks.SetAlpha(0.0000000);
            Animate(m_mcText, 0.2500000, 5, 115.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.2500000, 6, 115.0000000, 0.0000000, 1, false);
            Animate(m_mcIcon, 0.2500000, 5, 115.0000000, 0.0000000, 1, false);
            Animate(m_mcIcon, 0.2500000, 6, 115.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.1000000, 5, 100.0000000, 0.2500000, 1, false);
            Animate(m_mcText, 0.1000000, 6, 100.0000000, 0.2500000, 1, false);
            Animate(m_mcIcon, 0.1000000, 5, 100.0000000, 0.2500000, 1, false);
            Animate(m_mcIcon, 0.1000000, 6, 100.0000000, 0.2500000, 1, false);
            FadeIn(m_mcRoot, 0.2500000);
            return 0.2500000;
        // End:0x4D6
        case 1:
            m_bIsHiding = true;
            EndAnim(m_mcAnim);
            EndAnim(m_mcIcon);
            EndAnim(m_mcText);
            EndAnim(m_mcMaxStacks);
            m_mcText.SetXScale(100.0000000);
            m_mcText.SetYScale(100.0000000);
            m_mcIcon.SetXScale(100.0000000);
            m_mcIcon.SetYScale(100.0000000);
            m_mcMaxStacks.SetVisible(false);
            m_mcMaxStacks.SetAlpha(0.0000000);
            Animate(m_mcText, 0.2500000, 5, 150.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.2500000, 6, 150.0000000, 0.0000000, 1, false);
            Animate(m_mcIcon, 0.2500000, 5, 150.0000000, 0.0000000, 1, false);
            Animate(m_mcIcon, 0.2500000, 6, 150.0000000, 0.0000000, 1, false);
            FadeOut(m_mcRoot, 0.2500000);
            return 0.1000000;
        // End:0x719
        case 2:
            EndAnim(m_mcAnim);
            EndAnim(m_mcText);
            m_mcText.SetXScale(100.0000000);
            m_mcText.SetYScale(100.0000000);
            m_mcAnim.SetXScale(85.0000000);
            m_mcAnim.SetYScale(85.0000000);
            m_mcAnim.SetAlpha(100.0000000);
            Animate(m_mcAnim, 0.4000000, 5, 250.0000000, 0.0000000, 1, false);
            Animate(m_mcAnim, 0.4000000, 6, 250.0000000, 0.0000000, 1, false);
            Animate(m_mcAnim, 0.2500000, 2, 0.0000000, 0.1500000, 1, false);
            Animate(m_mcText, 0.2000000, 2, 100.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.0500000, 2, 85.0000000, 0.2000000, 1, false);
            Animate(m_mcText, 0.2000000, 5, 130.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.2000000, 6, 130.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.0500000, 5, 100.0000000, 0.2000000, 1, false);
            Animate(m_mcText, 0.0500000, 6, 100.0000000, 0.2000000, 1, false);
            // End:0x959
            break;
        // End:0x8CC
        case 3:
            EndAnim(m_mcIcon);
            EndAnim(m_mcText);
            m_mcText.SetAlpha(50.0000000);
            Animate(m_mcText, 0.3000000, 2, 85.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.1000000, 5, 85.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.1000000, 6, 85.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.3000000, 5, 100.0000000, 0.1000000, 1, false);
            Animate(m_mcText, 0.3000000, 6, 100.0000000, 0.1000000, 1, false);
            Animate(m_mcIcon, 0.1000000, 5, 85.0000000, 0.0000000, 1, false);
            Animate(m_mcIcon, 0.1000000, 6, 85.0000000, 0.0000000, 1, false);
            Animate(m_mcIcon, 0.3000000, 5, 100.0000000, 0.1000000, 1, false);
            Animate(m_mcIcon, 0.3000000, 6, 100.0000000, 0.1000000, 1, false);
            // End:0x959
            break;
        // End:0x956
        case 4:
            EndAnim(m_mcMaxStacks);
            m_mcMaxStacks.SetVisible(true);
            Animate(m_mcMaxStacks, 0.1500000, 2, 100.0000000, 0.0000000, 1, false);
            Animate(m_mcText, 0.1500000, 2, 100.0000000, 0.0000000, 1, false);
            // End:0x959
            break;
        // End:0xFFFF
        default:
            break;
    }
    return 0.0000000;
    //return ReturnValue;    
}
