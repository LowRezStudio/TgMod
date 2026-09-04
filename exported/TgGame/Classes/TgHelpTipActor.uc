class TgHelpTipActor extends Actor
    native(Game)
    notplaceable
    hidecategories(Navigation);

var string m_strTitle;
var string m_strTip;
var int m_nGameTipId;
var transient float m_fAlpha;
var float m_fAlphaNearDistanceSq;
var float m_fAlphaFarDistanceSq;

event Remove(bool bSuppress)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x9B
    if((TgPC != none) && TgPC.c_GameTipManager != none)
    {
        TgPC.c_GameTipManager.DismissHelpText(m_nGameTipId, !bSuppress);
    }
    Destroy();
    //return;    
}

defaultproperties
{
    m_fAlphaNearDistanceSq=160000.0000000
    m_fAlphaFarDistanceSq=490000.0000000
}