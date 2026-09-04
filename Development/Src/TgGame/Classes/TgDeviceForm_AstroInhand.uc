class TgDeviceForm_AstroInhand extends TgDeviceForm_SpinnerWhileFiring
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

function SetSpinnersRotationSpeedState(int nState) { }

function SetSpinStates(TgSkelCon_Spinner pSpinner, int nState) { }

defaultproperties
{
    m_SpinnerName="RINGS"
}
