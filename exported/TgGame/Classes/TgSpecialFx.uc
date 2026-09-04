class TgSpecialFx extends Object
    native(FX);

const TGFXP_SCALAR = 299;
const TGFXP_VECTOR = 300;
const TGFXP_COLOR = 301;
const TGFXP_TEXTURE = 307;
const TGFXT_NO_PRIORITY = 0;
const TGFXT_PRIORITY_SHIELD = 625;
const TGFXT_PRIORITY_STEALTH = 626;
const TGFXT_PRIORITY_STEALTH_DETECTION = 627;
const TGFXT_PRIORITY_FLAME = 838;
const TGFXT_PRIORITY_SPAWN_SORTORDER = 15;
const TGFXMAT_GENERIC = 615;
const TGFXMAT_HAIR = 616;
const TGFXMAT_HEAD = 617;
const TGFXMAT_BODY = 618;
const TGFXMAT_WEAPON = 16600;
const FX_SCALE_BY_DAMAGE = 745;
const FX_SCALE_BY_RADIUS = 746;
const FX_SCALE_ABSOLUTE = 10677;
const FX_SCALE_BY_RADIUS_SQUARED = 1023;

enum ELightFxState
{
    LFX_UNMANAGED,                  // 0
    LFX_ACTIVE,                     // 1
    LFX_KILLEDBYMGR,                // 2
    LFX_DYING,                      // 3
    LFX_INACTIVE,                   // 4
    LFX_MAX                         // 5
};

enum EManagedDecalState
{
    DecalState_Inactive,            // 0
    DecalState_Active,              // 1
    DecalState_FadingOut,           // 2
    DecalState_MAX                  // 3
};

struct native Fx_Material
{
    var int nFxMatId;
    var MaterialInstanceTimeVarying c_MITV;
    var int nFxMatTypeCode;
    var name nmMIC;
    var bool bApplyIfSameTeam;

    structdefaultproperties
    {
        nFxMatId=0
        c_MITV=none
        nFxMatTypeCode=0
        nmMIC="None"
        bApplyIfSameTeam=false
    }
};

struct native Fx_AssemblyData
{
    var name m_nmSocketName;
    var name m_nmDisplayGroup;
    var int m_nDisplayMode;
    var int m_nSpecialFxId;
    var int m_nIndex;
    var int m_nEquipmentSlot;
    var bool m_bAppliesToAllModes;
    var bool m_bAttachToGround;

    structdefaultproperties
    {
        m_nmSocketName="None"
        m_nmDisplayGroup="None"
        m_nDisplayMode=0
        m_nSpecialFxId=0
        m_nIndex=0
        m_nEquipmentSlot=0
        m_bAppliesToAllModes=false
        m_bAttachToGround=false
    }
};

struct native Fx_PSC
{
    var int c_nId;
    var export editinline ParticleSystemComponent c_PSC;
    var const ParticleSystem c_PSCTemplate;
    var float c_fScale;
    var int c_nScaleType;
    var bool c_bRunning;
    var name c_nmSocketDisplayGrp;
    var name c_nmSocket;
    var TgEmitter_CameraEffect c_pCameraEffect;

    structdefaultproperties
    {
        c_nId=0
        c_PSC=none
        c_PSCTemplate=none
        c_fScale=0.0000000
        c_nScaleType=0
        c_bRunning=false
        c_nmSocketDisplayGrp="None"
        c_nmSocket="None"
        c_pCameraEffect=none
    }
};

struct native Fx_Sound
{
    var int c_nId;
    var AkBaseSoundObject c_SoundObject;
    var export editinline AudioComponent c_acSound;
    var bool c_bAllowSoundToFinishFlag;
    var bool c_bCanHearThroughStealth;
    var bool c_bForceAudioComponent;
    var AkEvent c_AkEvent;

    structdefaultproperties
    {
        c_nId=0
        c_SoundObject=none
        c_acSound=none
        c_bAllowSoundToFinishFlag=false
        c_bCanHearThroughStealth=false
        c_bForceAudioComponent=false
        c_AkEvent=none
    }
};

struct native Fx_Decal
{
    var int c_nId;
    var MaterialInstanceTimeVarying c_MITV;
    var float c_fWidth;
    var float c_fHeight;
    var float c_fThickness;
    var bool c_bNoClip;
    var bool c_bAttach;
    var export editinline DecalComponent c_Decal;
    var float c_fLifetime;
    var float c_fFadeOutTime;
    var TgSpecialFx.EManagedDecalState c_eState;
    var float c_fHideAtTimeSeconds;

    structdefaultproperties
    {
        c_nId=0
        c_MITV=none
        c_fWidth=0.0000000
        c_fHeight=0.0000000
        c_fThickness=0.0000000
        c_bNoClip=false
        c_bAttach=false
        c_Decal=none
        c_fLifetime=0.0000000
        c_fFadeOutTime=0.0000000
        c_eState=EManagedDecalState.DecalState_Inactive
        c_fHideAtTimeSeconds=0.0000000
    }
};

var int c_nFxId;
var export editinline MeshComponent c_OwnerMesh;
var Actor c_Owner;
var bool c_bAttached;
var bool c_bAppliesToAllModes;
var bool c_bSelfManage;
var bool c_bFromEffectForm;
var bool c_bVisualComplete;
var bool c_bAudioComplete;
var bool c_bMuteSound;
var bool c_bIsDebuff;
var bool c_bHasTeamMaterials;
var bool c_bActive;
var bool c_bIsSpawnFx;
var bool c_bUseBeam;
var bool c_bLifetimeManagedExternally;
var init bool c_bLocalPawnIsOwner;
var bool m_bMatLoaded;
var bool m_bMatLoadedFriendly;
var bool m_bMatLoadedLocal;
var bool m_bDecalMatLoaded;
var bool m_bDecalMatLoadedFriendly;
var bool m_bDecalMatLoadedLocal;
var int c_nPriorityType;
var int c_nPrioritySort;
var name c_nmSocket;
var name c_nmDisplayGroup;
var int c_nDisplayMode;
var int c_nIndex;
var int c_nEquipSlot;
var MaterialInstanceConstant c_MIC;
var float c_fTransition;
var int c_nHitEffectBase;
var float c_fMaxEffectDistance;
var ParticleChannelContainer c_ParticleChannelOverride;
var int c_nSortPriorityOverride;
var TgSpecialFx.ELightFxState c_LightComponentState;
var init export editinline LightComponent c_LightComponent;
var init Pointer c_ManagedLightEmitter;
var init array<init Fx_Sound> c_SoundList;
var init array<init Fx_PSC> c_PSCList;
var init array<init Fx_Material> c_MaterialList;
var init array<init Fx_Decal> c_DecalList;
var TgCameraShake c_CameraShake;
var TgTimerManager c_ActiveTimer;

// Export UTgSpecialFx::execAttachToOwner(FFrame&, void* const)
native function AttachToOwner(optional Actor pOwner);

// Export UTgSpecialFx::execDetach(FFrame&, void* const)
native function Detach();

// Export UTgSpecialFx::execGetEffectLocation(FFrame&, void* const)
native function Vector GetEffectLocation();

// Export UTgSpecialFx::execGetOwnerMesh(FFrame&, void* const)
native static function MeshComponent GetOwnerMesh(Actor pOwner);

// Export UTgSpecialFx::execActivateLocalPlayerFx(FFrame&, void* const)
native function ActivateLocalPlayerFx(ParticleSystemComponent ActivePSC);

// Export UTgSpecialFx::execSetPSCChannels(FFrame&, void* const)
native function SetPSCChannels(ParticleSystemComponent PSC, optional bool bOnlyAllowNonZeroMask = false, optional ParticleSystem Template);

// Export UTgSpecialFx::execSpawnActor(FFrame&, void* const)
native function Actor SpawnActor(Class<Actor> InClass, Vector Location, Rotator Rotation);

// Export UTgSpecialFx::execSetActiveTime(FFrame&, void* const)
native function SetActiveTime(float Duration, TgPawn Owner);

// Export UTgSpecialFx::execOnActiveTimeExpired(FFrame&, void* const)
native function OnActiveTimeExpired();

// Export UTgSpecialFx::execAdjustHidden(FFrame&, void* const)
native function AdjustHidden(bool bHidden);

// Export UTgSpecialFx::execSetHidden(FFrame&, void* const)
native function SetHidden(bool bNewHidden);

// Export UTgSpecialFx::execShouldShowWhenStealthed(FFrame&, void* const)
native function bool ShouldShowWhenStealthed();

// Export UTgSpecialFx::execPlaySoundAt(FFrame&, void* const)
native function PlaySoundAt(Vector Location);

// Export UTgSpecialFx::execResetParticles(FFrame&, void* const)
native function ResetParticles(optional bool bResetInstances = false);

// Export UTgSpecialFx::execAreAnyPSCRunning(FFrame&, void* const)
native function bool AreAnyPSCRunning();

// Export UTgSpecialFx::execSetPSCRunning(FFrame&, void* const)
native function SetPSCRunning(ParticleSystemComponent pPSC, bool bOn);

// Export UTgSpecialFx::execAreAnySoundsPlaying(FFrame&, void* const)
native function bool AreAnySoundsPlaying();

// Export UTgSpecialFx::execUpdateSoundPlaying(FFrame&, void* const)
native function UpdateSoundPlaying(AudioComponent pacSound);

// Export UTgSpecialFx::execSpawnEmitter(FFrame&, void* const)
native function SpawnEmitter(Vector HitLocation, Vector HitNormal, optional float fScale, optional array<ParticleSysParam> Params);

// Export UTgSpecialFx::execSpawnSound(FFrame&, void* const)
native function SpawnSound(Vector Location);

// Export UTgSpecialFx::execSpawnDecalAt(FFrame&, void* const)
native function SpawnDecalAt(Vector HitLocation, Vector HitNormal, optional float DecalRotation = -1.0000000, optional float Scale = 1.0000000);

// Export UTgSpecialFx::execPlayCameraShake(FFrame&, void* const)
native function PlayCameraShake(Vector Epicenter);

// Export UTgSpecialFx::execSetHitEffectScaleBasedOnDamage(FFrame&, void* const)
native function SetHitEffectScaleBasedOnDamage(int nHealthChange);

// Export UTgSpecialFx::execIsFxRelevant(FFrame&, void* const)
native function bool IsFxRelevant(Vector SpawnLocation);

// Export UTgSpecialFx::execFindLocalPlayerController(FFrame&, void* const)
native function TgPlayerController FindLocalPlayerController();

// Export UTgSpecialFx::execFindLocalPlayerPawn(FFrame&, void* const)
native function TgPawn FindLocalPlayerPawn();

// Export UTgSpecialFx::execAdjustEffectRadius(FFrame&, void* const)
native function AdjustEffectRadius(int nPSCIndex, float fScale);

// Export UTgSpecialFx::execAdjustFxScaleByRadius(FFrame&, void* const)
native function AdjustFxScaleByRadius(float fScale);

// Export UTgSpecialFx::execAdjustEffectScale(FFrame&, void* const)
native function AdjustEffectScale(int nPSCIndex, optional float fScale);

// Export UTgSpecialFx::execAdjustEffectFOV(FFrame&, void* const)
native function AdjustEffectFOV(float NewFOV);

// Export UTgSpecialFx::execActivate(FFrame&, void* const)
native function float Activate(optional Vector HitLocation, optional bool bSkipRelevantChecking = false);

// Export UTgSpecialFx::execDeactivate(FFrame&, void* const)
native function Deactivate(bool bForceDeactivate);

// Export UTgSpecialFx::execOnParticleSystemFinished(FFrame&, void* const)
native function OnParticleSystemFinished(ParticleSystemComponent FinishedComponent);

// Export UTgSpecialFx::execOnAudioFinishedFX(FFrame&, void* const)
native function OnAudioFinishedFX(AudioComponent FinishedComponent);

// Export UTgSpecialFx::execCheckDeactivate(FFrame&, void* const)
native function CheckDeactivate();

// Export UTgSpecialFx::execPlaySound(FFrame&, void* const)
native function PlaySound();

// Export UTgSpecialFx::execStopSound(FFrame&, void* const)
native function StopSound();

// Export UTgSpecialFx::execActivateDecal(FFrame&, void* const)
native function ActivateDecal(out Fx_Decal Decal);

// Export UTgSpecialFx::execDeactivateDecal(FFrame&, void* const)
native function DeactivateDecal(out Fx_Decal Decal);

// Export UTgSpecialFx::execInitDecalFadeOut(FFrame&, void* const)
native function bool InitDecalFadeOut(out Fx_Decal Decal);

// Export UTgSpecialFx::execUpdateHiddenDecals(FFrame&, void* const)
native function UpdateHiddenDecals(optional bool bClearAll = false);

// Export UTgSpecialFx::execGetLocalPlayerPSCChannels(FFrame&, void* const)
native function ParticleChannelContainer GetLocalPlayerPSCChannels(ParticleSystemComponent ActivePSC, optional ParticleSystem Template);

// Export UTgSpecialFx::execOverridePSCChannels(FFrame&, void* const)
native function OverridePSCChannels(ParticleChannelContainer PSysChannels);

// Export UTgSpecialFx::execFindMeshWithSocket(FFrame&, void* const)
native static function SkeletalMeshComponent FindMeshWithSocket(name nmSocket, SkeletalMeshComponent first, Actor Second, out name BoneName, out Vector RelativeLocation, out Rotator RelativeRotation, out Vector RelativeScale);

function bool HasSoundCue()
{
    return c_SoundList.Length > 0;
    //return ReturnValue;    
}

function Actor GetHitActor(Vector EffectLocation, Vector HitLocation)
{
    local Vector out_HitLocation, out_HitNormal;

    // End:0x50
    if(c_Owner != none)
    {
        return c_Owner.Trace(out_HitLocation, out_HitNormal, HitLocation, EffectLocation, true);
    }
    return none;
    //return ReturnValue;    
}

event SpawnTracer(Vector HitLocation, optional Vector HitOrigin = vect(0.0000000, 0.0000000, 0.0000000))
{
    local Emitter E;
    local Vector Dir, EffectLocation;
    local Actor HitActor, OriginActor;
    local int I, J;
    local TgPawn OwnerPawn;
    local ParticleChannelContainer newPSysChannels;

    // End:0x2B
    if(!IsFxRelevant(HitLocation))
    {
        return;
    }
    // End:0x5C
    if(HitOrigin != vect(0.0000000, 0.0000000, 0.0000000))
    {
        EffectLocation = HitOrigin;        
    }
    else
    {
        EffectLocation = GetEffectLocation();
    }
    Dir = HitLocation - EffectLocation;
    HitActor = GetHitActor(HitLocation - (Normal(Dir) * float(10)), HitLocation + (Normal(Dir) * float(10)));
    OriginActor = GetHitActor(EffectLocation + (Normal(Dir) * float(10)), EffectLocation - (Normal(Dir) * float(10)));
    OwnerPawn = TgPawn(c_Owner);
    // End:0x1A8
    if((OwnerPawn == none) && c_Owner.Instigator != none)
    {
        OwnerPawn = TgPawn(c_Owner.Instigator);
    }
    // End:0x50C
    if(c_Owner != none)
    {
        I = 0;
        J0x1C2:

        // End:0x50C [Loop If]
        if(I < c_PSCList.Length)
        {
            newPSysChannels = ((c_ParticleChannelOverride.bInitialized) ? c_ParticleChannelOverride : GetLocalPlayerPSCChannels(c_PSCList[I].c_PSC));
            E = c_Owner.Spawn(Class'TgGame.TgEmitter',,, EffectLocation, Rotator(Dir));
            E.ParticleSystemComponent.m_ParticleChannels = newPSysChannels;
            E.SetTemplate(c_PSCList[I].c_PSCTemplate, true);
            // End:0x35E
            if(HitOrigin != vect(0.0000000, 0.0000000, 0.0000000))
            {
                // End:0x35B
                if(OriginActor != none)
                {
                    E.SetBase(OriginActor);
                }                
            }
            else
            {
                E.SetBase(OwnerPawn);
            }
            // End:0x4EA
            if(E.ParticleSystemComponent != none)
            {
                E.ParticleSystemComponent.SetVectorParameter('beamEnd', HitLocation);
                J = 0;
                J0x3F7:

                // End:0x495 [Loop If]
                if(J < c_PSCList[I].c_PSC.EmitterInstances.Length)
                {
                    E.ParticleSystemComponent.SetBeamEndPoint(J, HitLocation);
                    J++;
                    // [Loop Continue]
                    goto J0x3F7;
                }
                // End:0x4EA
                if(HitActor != none)
                {
                    E.ParticleSystemComponent.SetActorParameter('BeamEndActor', HitActor);
                }
            }
            AdjustEffectScale(I);
            I++;
            // [Loop Continue]
            goto J0x1C2;
        }
    }
    return;
    //return;    
}

event DecalComponent SpawnDecal(WorldInfo WorldInfo, out Fx_Decal Decal, bool bUsePool, optional Vector SpawnLocation, optional Rotator SpawnRotation, optional float DecalRotation = -1.0000000, optional float Scale = 1.0000000)
{
    local editinline DecalComponent Comp;
    local MaterialInstance MatInst;

    MatInst = new Class'Engine.MaterialInstanceTimeVarying';
    MatInst.SetParent(Decal.c_MITV);
    // End:0xA1
    if(IsZero(SpawnLocation))
    {
        SpawnLocation = GetEffectLocation();
        SpawnRotation = rot(-16384, 0, 0);
    }
    Comp = WorldInfo.MyDecalManager.SpawnDecal(bUsePool, MatInst, SpawnLocation, SpawnRotation, Decal.c_fWidth * Scale, Decal.c_fHeight * Scale, Decal.c_fThickness, Decal.c_bNoClip, DecalRotation,,,,,,, Decal.c_fLifetime);
    return Comp;
    //return ReturnValue;    
}

event UpdateBeamFx(Vector HitLocation, optional Vector HitOrigin = vect(0.0000000, 0.0000000, 0.0000000), optional Actor targetOverride)
{
    local Vector Dir, EffectLocation;
    local Actor HitActor;
    local int I, J;

    // End:0x2C
    if(!IsFxRelevant(HitLocation))
    {
        return;
    }
    // End:0x4F
    if(!c_bActive)
    {
        Activate(HitLocation);
    }
    // End:0x80
    if(HitOrigin != vect(0.0000000, 0.0000000, 0.0000000))
    {
        EffectLocation = HitOrigin;        
    }
    else
    {
        EffectLocation = GetEffectLocation();
    }
    Dir = HitLocation - EffectLocation;
    // End:0x110
    if(targetOverride == none)
    {
        HitActor = GetHitActor(HitLocation - (Normal(Dir) * float(10)), HitLocation + (Normal(Dir) * float(10)));        
    }
    else
    {
        HitActor = targetOverride;
    }
    // End:0x2BF
    if(c_Owner != none)
    {
        I = 0;
        J0x13D:

        // End:0x2BF [Loop If]
        if(I < c_PSCList.Length)
        {
            c_PSCList[I].c_PSC.SetVectorParameter('beamEnd', HitLocation);
            J = 0;
            J0x1AE:

            // End:0x254 [Loop If]
            if(J < c_PSCList[I].c_PSC.EmitterInstances.Length)
            {
                c_PSCList[I].c_PSC.SetBeamEndPoint(J, HitLocation);
                J++;
                // [Loop Continue]
                goto J0x1AE;
            }
            // End:0x2B1
            if(HitActor != none)
            {
                c_PSCList[I].c_PSC.SetActorParameter('BeamEndActor', HitActor);
            }
            I++;
            // [Loop Continue]
            goto J0x13D;
        }
    }
    return;
    //return;    
}

function ListSounds()
{
    local int I;

    // End:0x70
    if(c_SoundList.Length > 0)
    {
        I = 0;
        J0x1B:

        // End:0x6D [Loop If]
        if(I < c_SoundList.Length)
        {
            // End:0x5F
            if(c_SoundList[I].c_SoundObject != none)
            {
            }
            I++;
            // [Loop Continue]
            goto J0x1B;
        }        
    }
    //return;    
}

function SetKillOnDeactivate()
{
    local int I, Idx;

    I = 0;
    J0x0B:

    // End:0xDA [Loop If]
    if(I < c_PSCList.Length)
    {
        Idx = 0;
        J0x2E:

        // End:0xCC [Loop If]
        if(Idx < c_PSCList[I].c_PSC.EmitterInstances.Length)
        {
            c_PSCList[I].c_PSC.SetKillOnDeactivate(Idx, true);
            Idx++;
            // [Loop Continue]
            goto J0x2E;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

event SetDepthPriorityGroup(Scene.ESceneDepthPriorityGroup NewDepthPriorityGroup)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x76 [Loop If]
    if(I < c_PSCList.Length)
    {
        c_PSCList[I].c_PSC.super(TgSpecialFx).SetDepthPriorityGroup(NewDepthPriorityGroup);
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

static function float CalculateOrientedDecalRotation(Vector HitLocation, Vector HitNormal, Vector DecalOrientationDirection)
{
    local float DecalRotation, HitNormalAngle;
    local Vector DecalOrientationProjection, RotX, RotY, RotZ;

    HitNormalAngle = Acos(HitNormal Dot vect(0.0000000, 0.0000000, 1.0000000));
    // End:0x7D
    if((HitNormalAngle > (3.1415930 / float(3))) && HitNormalAngle < ((float(2) * 3.1415930) / float(3)))
    {
        DecalOrientationDirection = vect(0.0000000, 0.0000000, 1.0000000);
    }
    DecalOrientationProjection = Normal(DecalOrientationDirection - (((DecalOrientationDirection Dot HitNormal) / VSizeSq(HitNormal)) * HitNormal));
    GetAxes(Rotator(-HitNormal), RotX, RotY, RotZ);
    DecalRotation = (Acos(DecalOrientationProjection Dot RotZ) * float(180)) / 3.1415930;
    // End:0x155
    if((RotY Dot DecalOrientationProjection) > float(0))
    {
        DecalRotation = 360.0000000 - DecalRotation;
    }
    return DecalRotation;
    //return ReturnValue;    
}

// Export UTgSpecialFx::execIsFriendly(FFrame&, void* const)
native function bool IsFriendly();

// Export UTgSpecialFx::execIsLocal(FFrame&, void* const)
native function bool IsLocal();

defaultproperties
{
    c_bVisualComplete=true
    c_bAudioComplete=true
    c_nHitEffectBase=20
    c_fMaxEffectDistance=10000.0000000
    c_ParticleChannelOverride=(bInitialized=false,Default=true,Friendly=false,Enemy=false,LocalOwner=false,Channel5=false,Channel6=false,Channel7=false,Channel8=false,VerticalTargeter=false,Filter2=false,NotLocalOwner=false,CustomFilter1=false,CustomFilter2=false,CustomFilter3=false,CustomFilter4=false,CustomFilter5=false,CustomFilter6=false,CustomFilter7=false)
}