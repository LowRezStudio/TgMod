class TgDeviceForm_Mount extends TgDeviceForm
    native(Devices);

var int m_FadeMaterialFXId;
var array<MaterialInstanceConstant> m_FadeMICs;
var float m_fFadeInTime;
var float m_fRemainingFadeInTime;
var float m_fFadeOutTime;
var float m_fRemainingFadeOutTime;
var Vector m_CameraOffset;
var TgObject.EMountType m_MountType;
var array<AnimSet> m_LoadedAnimSets;

simulated event string GetAnimSetStringForBot(int PlayerBotId)
{
    // End:0x38
    if(PawnOwner != none)
    {
        return PawnOwner.GetAnimSetString(m_MountType);
    }
    return "";
    //return ReturnValue;    
}

// Export UTgDeviceForm_Mount::execPlaySummonEffects(FFrame&, void* const)
native function PlaySummonEffects(float SummonTime, bool bIsDismounting);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0xBA
    if(PawnOwner != none)
    {
        // End:0xBA
        if(PawnOwner.c_bHide3PWeaponMeshWhileMounted)
        {
            // End:0xBA
            if(PawnOwner.m_WeaponMesh != none)
            {
                PawnOwner.m_WeaponMesh.Hide3PWeaponMesh();
            }
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x9C
    if(PawnOwner != none)
    {
        // End:0x9C
        if(PawnOwner.c_bHide3PWeaponMeshWhileMounted)
        {
            // End:0x9C
            if(PawnOwner.m_WeaponMesh != none)
            {
                PawnOwner.m_WeaponMesh.Unhide3PWeaponMesh();
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_CameraOffset=(X=-142.0000000,Y=0.0000000,Z=25.0000000)
}