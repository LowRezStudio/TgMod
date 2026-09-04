class TgDevice_BombKingDetonator extends TgDevice
    native(ChampBombKing)
    hidecategories(Navigation);

var bool m_bDetonatePoppyBombs;
var bool m_bInFalseFireRetryPeriod;
var float m_fFalseFireRetryStart;
var const float m_fFalseFireRetryTime;

// Export UTgDevice_BombKingDetonator::execGetCurrentFire(FFrame&, void* const)
native function TgDeviceFire GetCurrentFire();

// Export UTgDevice_BombKingDetonator::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function bool ShouldInterruptMount()
{
    return true;
    //return ReturnValue;    
}

simulated event HandleFalseFireRecory()
{
    local TgPawn PawnOwner;
    local TgDevice_BombKingInhand inhandDev;

    // End:0xEB
    if(m_bInFalseFireRetryPeriod && (m_fFalseFireRetryStart + m_fFalseFireRetryTime) <= WorldInfo.TimeSeconds)
    {
        super.HandleFalseFireRecory();
        PawnOwner = TgPawn(Owner);
        // End:0xDC
        if(PawnOwner != none)
        {
            inhandDev = TgDevice_BombKingInhand(PawnOwner.GetDeviceByEqPoint(1));
            // End:0xDC
            if(inhandDev != none)
            {
                inhandDev.ServerRestoreBombs();
            }
        }
        m_bInFalseFireRetryPeriod = false;        
    }
    else
    {
        m_bInFalseFireRetryPeriod = true;
        m_fFalseFireRetryStart = WorldInfo.TimeSeconds;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        m_bInFalseFireRetryPeriod = false;
        super.StartFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fFalseFireRetryTime=0.3000000
}