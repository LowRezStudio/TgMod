class TgDeviceForm_TurtlePower extends TgDeviceForm
    native(ChampMakoa);

var bool m_bShouldBeActive;
var float m_fRageActivationTime;
var float m_fRageActivationPercent;

// Export UTgDeviceForm_TurtlePower::execUpdateRageMeshVisibility(FFrame&, void* const)
native function UpdateRageMeshVisibility(float DeltaSeconds);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local MaterialInstanceConstant MIC;
    local int I;
    local float fEnemyScalarValue;

    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x40A
    if(PawnOwner != none)
    {
        fEnemyScalarValue = ((PawnOwner.IsFriendlyWithLocalPawn()) ? 0.0000000 : 1.0000000);
        // End:0x1EC
        if((PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_HandsMesh != none)
        {
            I = 0;
            J0xE2:

            // End:0x1EC [Loop If]
            if(I < PawnOwner.m_WeaponMesh.m_HandsMesh.Materials.Length)
            {
                MIC = MaterialInstanceConstant(PawnOwner.m_WeaponMesh.m_HandsMesh.Materials[I]);
                // End:0x1DE
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue('FRIENDLY_ENEMY', fEnemyScalarValue);
                }
                I++;
                // [Loop Continue]
                goto J0xE2;
            }
        }
        // End:0x2FB
        if(PawnOwner.Mesh != none)
        {
            I = 0;
            J0x21B:

            // End:0x2FB [Loop If]
            if(I < PawnOwner.Mesh.Materials.Length)
            {
                MIC = MaterialInstanceConstant(PawnOwner.Mesh.Materials[I]);
                // End:0x2ED
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue('FRIENDLY_ENEMY', fEnemyScalarValue);
                }
                I++;
                // [Loop Continue]
                goto J0x21B;
            }
        }
        // End:0x40A
        if(PawnOwner.m_HeadMesh != none)
        {
            I = 0;
            J0x32A:

            // End:0x40A [Loop If]
            if(I < PawnOwner.m_HeadMesh.Materials.Length)
            {
                MIC = MaterialInstanceConstant(PawnOwner.m_HeadMesh.Materials[I]);
                // End:0x3FC
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue('FRIENDLY_ENEMY', fEnemyScalarValue);
                }
                I++;
                // [Loop Continue]
                goto J0x32A;
            }
        }
    }
    m_bShouldBeActive = true;
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
    m_fRageActivationTime=0.5000000
}