class TgData_Cards extends TgObject
    native;

const UPGRADE_LEVEL_GOLD_CARD = 1;

var int m_PropIndex;
var array<CardInfo> m_Deck;
var UIGameMoviePlayer m_pMovie;

// Export UTgData_Cards::execInitialize(FFrame&, void* const)
native function Initialize(UIGameMoviePlayer pMoviePlayer);

event string ParseItemPower(string sValue, int nLevel)
{
    local int nIndex, nPower;
    local string sPower, sPrefix;

    // End:0x1A
    if(nLevel <= 0)
    {
        nLevel = 1;
    }
    nIndex = InStr(sValue, "] ");
    // End:0x6C
    if(nIndex > -1)
    {
        sValue = Mid(sValue, nIndex + 2);
    }
    nIndex = InStr(sValue, "{");
    // End:0xA4
    if(nIndex == -1)
    {
        return sValue;
    }
    sPrefix = Left(sValue, nIndex);
    sValue = Mid(sValue, nIndex + 1);
    nIndex = InStr(sValue, "}");
    // End:0x13A
    if(nIndex == -1)
    {
        return ParseItemPower(sPrefix $ sValue, nLevel);
    }
    sPower = Left(sValue, nIndex);
    sValue = Split(sValue, "}", true);
    // End:0x1BF
    if(nPower == -1)
    {
        return ParseItemPower((sPrefix $ sPower) $ sValue, nLevel);
    }
    nPower = int(sPower);
    nPower *= float(nLevel);
    return (sPrefix $ string(nPower)) $ sValue;
    //return ReturnValue;    
}

defaultproperties
{
    m_PropIndex=1710
}