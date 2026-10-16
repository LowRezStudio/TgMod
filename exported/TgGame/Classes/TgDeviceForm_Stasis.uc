class TgDeviceForm_Stasis extends TgDeviceForm
    native(ChampEvie);

var bool m_bNeedsLoopActivation;
var float m_fFireStartTime;
var float m_fLoopDelay;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    m_bNeedsLoopActivation = true;
    m_fFireStartTime = -1.0000000;
    // End:0x95
    if((PawnOwner != none) && PawnOwner.Mesh != none)
    {
        PawnOwner.Mesh.FxActivateGroup('IceBlock_Intro', 0);
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    m_bNeedsLoopActivation = false;
    m_fFireStartTime = -1.0000000;
    // End:0xD2
    if((PawnOwner != none) && PawnOwner.Mesh != none)
    {
        PawnOwner.Mesh.FxActivateGroup('IceBlock_Outro', 0);
        PawnOwner.Mesh.FxDeactivateGroup('IceBlock_Loop', 0);
    }
    super.StopFire(nFireModeNum);
    //return;    
}

defaultproperties
{
    m_fLoopDelay=0.2800000
}