class TgHelpTipActor extends Actor
    native(Game)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var string m_strTitle;
var string m_strTip;
var int m_nGameTipId;
var transient float m_fAlpha;
var float m_fAlphaNearDistanceSq;
var float m_fAlphaFarDistanceSq;

event Remove(bool bSuppress) { }

defaultproperties
{
    m_fAlphaNearDistanceSq=160000.0000000
    m_fAlphaFarDistanceSq=490000.0000000
}
