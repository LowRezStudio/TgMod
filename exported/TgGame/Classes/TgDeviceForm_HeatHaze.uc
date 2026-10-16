class TgDeviceForm_HeatHaze extends TgDeviceForm
    native(ChampLongbow);

var bool m_bShouldBeActive;
var float m_fUltActivationTime;
var float m_fUltActivationPercent;

// Export UTgDeviceForm_HeatHaze::execUpdateUltMeshVisibility(FFrame&, void* const)
native function UpdateUltMeshVisibility(float DeltaSeconds);

// Export UTgDeviceForm_HeatHaze::execUpdateMeshMICValue(FFrame&, void* const)
native function UpdateMeshMICValue(MeshComponent MeshComp);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    m_bShouldBeActive = true;
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0xF2
    if((PawnOwner != none) && PawnOwner.Mesh != none)
    {
        PawnOwner.Mesh.FxActivateIndependant('UltimateActivated', 0, PawnOwner.Location, Vector(PawnOwner.Rotation));
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    m_bShouldBeActive = false;
    //return;    
}

defaultproperties
{
    m_fUltActivationTime=0.5000000
}