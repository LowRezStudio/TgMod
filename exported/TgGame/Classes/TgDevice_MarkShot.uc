class TgDevice_MarkShot extends TgDevice
    native(ChampLex)
    hidecategories(Navigation);

var bool m_bRecalculateMark;
var TgPawn_Character m_CurrentMark;

simulated event bool StartFire()
{
    m_bRecalculateMark = true;
    return super.StartFire();
    //return ReturnValue;    
}

defaultproperties
{
    m_bRecalculateMark=true
}