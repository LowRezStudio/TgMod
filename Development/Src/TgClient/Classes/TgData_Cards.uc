class TgData_Cards extends TgObject
    native
    config(Engine);

const UPGRADE_LEVEL_GOLD_CARD = 1;

var int m_PropIndex;
var array<CardInfo> m_Deck;
var UIGameMoviePlayer m_pMovie;

native function Initialize(UIGameMoviePlayer pMoviePlayer);  // Export UTgData_Cards::execInitialize(FFrame&, void* const)

event string ParseItemPower(string sValue, int nLevel) { }

defaultproperties
{
    m_PropIndex=1710
}
