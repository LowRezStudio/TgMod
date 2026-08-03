class TgDeviceForm_AstroInhand extends TgDeviceForm_SpinnerWhileFiring;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super(TgDeviceForm).StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    SetSpinnersRotationSpeedState(1);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    SetSpinnersRotationSpeedState(0);
    //return;    
}

function SetSpinnersRotationSpeedState(int nState)
{
    local TgSkelCon_Spinner Spinner;

    // End:0x34
    foreach m_SpinnerSkelControls1p(Spinner)
    {
        SetSpinStates(Spinner, nState);        
    }    
    // End:0x69
    foreach m_SpinnerSkelControls3p(Spinner)
    {
        SetSpinStates(Spinner, nState);        
    }    
    //return;    
}

function SetSpinStates(TgSkelCon_Spinner pSpinner, int nState)
{
    pSpinner.m_nRotationSpeedState = nState;
    // End:0x9D
    if(nState == 1)
    {
        pSpinner.m_bSpinningUp = true;
        pSpinner.m_bIsSpinning = true;
        pSpinner.m_bSpinningDown = false;        
    }
    else
    {
        pSpinner.m_bSpinningUp = false;
        pSpinner.m_bSpinningDown = true;
        pSpinner.m_bSpinDownToZero = false;
    }
    //return;    
}

defaultproperties
{
    m_SpinnerName="RINGS"
}