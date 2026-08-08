class UIHudChampionSelect extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIHUDCHAMPIONSELECT_COUNT = 33;

var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcChampion[33];
var GFxObject m_mcChampionIcon[33];
var GFxObject m_mcChampionTitle[33];
var GFxObject m_mcChampionSubtitle[33];
var TgGFxGroup m_grChampions;

event string GetBotSpawnName(string sValue) { }

defaultproperties
{
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_bBlur=true
    m_Name="UIHudChampionSelect"
}
