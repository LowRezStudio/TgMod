class TgMiniMap_Targeting extends TgMiniMap
    native(GameUI)
    config(Engine);

var MaterialInstanceConstant m_MICWardTarget[MinimapDisplayType];

defaultproperties
{
    m_bShouldDisplayMiniMap=true
    m_nMaskSize=256
    m_fIconScale=1.5000000
}
