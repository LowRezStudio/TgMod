class UIComponent_MasteryRewardsPopup extends UIComponent_Popup
    native(UIComponent)
    config(Engine)
    dependson(UIDataChampion);

var protected TgGFxGroup m_grRewardsGroup;
var protected array<UIComponent_MasteryRewardsEntry> m_pMasteryRewardsEntries;
var array<MasteryRewards> m_MasteryRewardData;
var const int m_nNumEntries;

defaultproperties
{
    m_nNumEntries=6
    m_sLoadName="MasteryDetails"
}
