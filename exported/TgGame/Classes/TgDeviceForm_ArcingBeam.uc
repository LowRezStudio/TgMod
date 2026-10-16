class TgDeviceForm_ArcingBeam extends TgDeviceForm
    native(ChampGrohk);

struct native ArcingFXInfo
{
    var Actor Source;
    var Actor Target;
    var TgSpecialFx ArcingFX;
    var float fRemainingActiveTime;

    structdefaultproperties
    {
        Source=none
        Target=none
        ArcingFX=none
        fRemainingActiveTime=0.0000000
    }
};

var array<ArcingFXInfo> m_ArcingBeamList;
var Actor m_BeamSourceActor;
var float m_fBeamPersistTime;
var bool m_bRequireDeviceIsFiring;
var bool m_bIsFXContinuous;
var int m_nBeamEffectID;
var TgPawn_Grohk m_CachedGrohkPawn;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    StopArcingBeamEffects();
    //return;    
}

event SetSourceArcingBeamEffect(Actor Source)
{
    m_BeamSourceActor = Source;
    //return;    
}

event SetTargetArcingBeamEffect(Actor Target)
{
    local int I;
    local bool bIsEnemy;
    local ParticleChannelContainer Channels;
    local TgWeaponMeshActor_Orb orbWeaponMesh;

    // End:0x4A
    if((((FormState != 'DeviceFiring') && m_bRequireDeviceIsFiring) || PawnOwner == none) || m_BeamSourceActor == none)
    {
        return;
    }
    I = 0;
    J0x55:

    // End:0x126 [Loop If]
    if(I < m_ArcingBeamList.Length)
    {
        // End:0x118
        if((m_bIsFXContinuous && m_ArcingBeamList[I].Target == Target) && m_ArcingBeamList[I].Source == m_BeamSourceActor)
        {
            m_ArcingBeamList[I].fRemainingActiveTime = m_fBeamPersistTime;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x55;
    }
    I = m_ArcingBeamList.Add(1);
    m_ArcingBeamList[I].Target = Target;
    m_ArcingBeamList[I].Source = m_BeamSourceActor;
    m_BeamSourceActor = none;
    m_ArcingBeamList[I].fRemainingActiveTime = m_fBeamPersistTime;
    m_ArcingBeamList[I].ArcingFX = Class'TgGame.TgPawn'.static.GetSpecialFx(m_nBeamEffectID);
    // End:0x541
    if(m_ArcingBeamList[I].ArcingFX != none)
    {
        m_ArcingBeamList[I].ArcingFX.AttachToOwner(m_ArcingBeamList[I].Source);
        // End:0x336
        if(PawnOwner.IsLocallyControlled())
        {
            Channels.Friendly = false;
            Channels.Enemy = false;
            Channels.LocalOwner = true;            
        }
        else
        {
            bIsEnemy = !PawnOwner.IsFriendlyWithLocalPawn();
            Channels.Friendly = !bIsEnemy;
            Channels.Enemy = bIsEnemy;
            Channels.LocalOwner = false;
        }
        Channels.bInitialized = true;
        m_ArcingBeamList[I].ArcingFX.OverridePSCChannels(Channels);
        m_ArcingBeamList[I].ArcingFX.Activate();
        UpdateBeamEndLocation(I);
        // End:0x541
        if((HasCachedGrohkPawn()) && m_CachedGrohkPawn.m_WeaponMesh != none)
        {
            orbWeaponMesh = TgWeaponMeshActor_Orb(m_CachedGrohkPawn.m_WeaponMesh);
            // End:0x541
            if(orbWeaponMesh != none)
            {
                orbWeaponMesh.SetFireLoopDisplayGroup('Grohk_ChainLightning', Class'TgGame.TgSkeletalMeshComponent_Weapon'.default.m_nmFireLoopTailSound);
            }
        }
    }
    //return;    
}

// Export UTgDeviceForm_ArcingBeam::execUpdateBeamEndLocation(FFrame&, void* const)
native function UpdateBeamEndLocation(int Idx);

function StopArcingBeamEffects(optional Actor Target)
{
    local int I;
    local TgWeaponMeshActor_Orb orbWeaponMesh;

    // End:0x18A
    if(Target == none)
    {
        I = 0;
        J0x1B:

        // End:0xE2 [Loop If]
        if(I < m_ArcingBeamList.Length)
        {
            m_ArcingBeamList[I].ArcingFX.Deactivate(true);
            m_ArcingBeamList[I].ArcingFX.Detach();
            m_ArcingBeamList[I].ArcingFX = none;
            I++;
            // [Loop Continue]
            goto J0x1B;
        }
        m_ArcingBeamList.Remove(0, m_ArcingBeamList.Length);
        // End:0x18A
        if((HasCachedGrohkPawn()) && m_CachedGrohkPawn.m_WeaponMesh != none)
        {
            orbWeaponMesh = TgWeaponMeshActor_Orb(m_CachedGrohkPawn.m_WeaponMesh);
            // End:0x18A
            if(orbWeaponMesh != none)
            {
                orbWeaponMesh.ResetFireLoopDisplayGroup();
            }
        }
    }
    //return;    
}

simulated function bool HasCachedGrohkPawn()
{
    // End:0x2B
    if(m_CachedGrohkPawn == none)
    {
        m_CachedGrohkPawn = TgPawn_Grohk(PawnOwner);
    }
    return m_CachedGrohkPawn != none;
    //return ReturnValue;    
}

defaultproperties
{
    m_fBeamPersistTime=0.5000000
    m_bRequireDeviceIsFiring=true
    m_bIsFXContinuous=true
    m_nBeamEffectID=6980
    m_bUseImpactFXOverride=true
}