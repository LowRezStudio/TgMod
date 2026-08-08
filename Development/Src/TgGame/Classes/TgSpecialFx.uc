class TgSpecialFx extends Object
    native(FX)
    config(Engine);

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

enum ELightFxState {
    LFX_UNMANAGED,  // 0
    LFX_ACTIVE,  // 1
    LFX_KILLEDBYMGR,  // 2
    LFX_DYING,  // 3
    LFX_INACTIVE,  // 4
};

enum EManagedDecalState {
    DecalState_Inactive,  // 0
    DecalState_Active,  // 1
    DecalState_FadingOut,  // 2
};

struct Fx_Material {
    var int nFxMatId;
    var MaterialInstanceTimeVarying c_MITV;
    var int nFxMatTypeCode;
    var name nmMIC;
    var bool bApplyIfSameTeam;
    structdefaultproperties {}
};

struct Fx_AssemblyData {
    var name m_nmSocketName;
    var name m_nmDisplayGroup;
    var int m_nDisplayMode;
    var int m_nSpecialFxId;
    var int m_nIndex;
    var int m_nEquipmentSlot;
    var bool m_bAppliesToAllModes;
    var bool m_bAttachToGround;
    structdefaultproperties {}
};

struct Fx_PSC {
    var int c_nId;
    var export editinline ParticleSystemComponent c_PSC;
    var const ParticleSystem c_PSCTemplate;
    var float c_fScale;
    var int c_nScaleType;
    var bool c_bRunning;
    var name c_nmSocketDisplayGrp;
    var name c_nmSocket;
    var TgEmitter_CameraEffect c_pCameraEffect;
    structdefaultproperties {}
};

struct Fx_Sound {
    var int c_nId;
    var AkBaseSoundObject c_SoundObject;
    var export editinline AudioComponent c_acSound;
    var bool c_bAllowSoundToFinishFlag;
    var bool c_bCanHearThroughStealth;
    var bool c_bForceAudioComponent;
    var AkEvent c_AkEvent;
    structdefaultproperties {}
};

struct Fx_Decal {
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
    structdefaultproperties {}
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

native function AttachToOwner(optional Actor pOwner);  // Export UTgSpecialFx::execAttachToOwner(FFrame&, void* const)

native function Detach();  // Export UTgSpecialFx::execDetach(FFrame&, void* const)

native function Vector GetEffectLocation();  // Export UTgSpecialFx::execGetEffectLocation(FFrame&, void* const)

native function MeshComponent GetOwnerMesh(Actor pOwner);  // Export UTgSpecialFx::execGetOwnerMesh(FFrame&, void* const)

native function ActivateLocalPlayerFx(ParticleSystemComponent ActivePSC);  // Export UTgSpecialFx::execActivateLocalPlayerFx(FFrame&, void* const)

native function SetPSCChannels(ParticleSystemComponent PSC, optional bool bOnlyAllowNonZeroMask=false, optional ParticleSystem Template);  // Export UTgSpecialFx::execSetPSCChannels(FFrame&, void* const)

native function Actor SpawnActor(Class<Actor> InClass, Vector Location, Rotator Rotation);  // Export UTgSpecialFx::execSpawnActor(FFrame&, void* const)

native function SetActiveTime(float Duration, TgPawn Owner);  // Export UTgSpecialFx::execSetActiveTime(FFrame&, void* const)

native function OnActiveTimeExpired();  // Export UTgSpecialFx::execOnActiveTimeExpired(FFrame&, void* const)

native function AdjustHidden(bool bHidden);  // Export UTgSpecialFx::execAdjustHidden(FFrame&, void* const)

native function SetHidden(bool bNewHidden);  // Export UTgSpecialFx::execSetHidden(FFrame&, void* const)

native function bool ShouldShowWhenStealthed();  // Export UTgSpecialFx::execShouldShowWhenStealthed(FFrame&, void* const)

native function PlaySoundAt(Vector Location);  // Export UTgSpecialFx::execPlaySoundAt(FFrame&, void* const)

native function ResetParticles(optional bool bResetInstances=false);  // Export UTgSpecialFx::execResetParticles(FFrame&, void* const)

native function bool AreAnyPSCRunning();  // Export UTgSpecialFx::execAreAnyPSCRunning(FFrame&, void* const)

native function SetPSCRunning(ParticleSystemComponent pPSC, bool bOn);  // Export UTgSpecialFx::execSetPSCRunning(FFrame&, void* const)

native function bool AreAnySoundsPlaying();  // Export UTgSpecialFx::execAreAnySoundsPlaying(FFrame&, void* const)

native function UpdateSoundPlaying(AudioComponent pacSound);  // Export UTgSpecialFx::execUpdateSoundPlaying(FFrame&, void* const)

native function SpawnEmitter(Vector HitLocation, Vector HitNormal, optional float fScale, optional array<ParticleSysParam> Params);  // Export UTgSpecialFx::execSpawnEmitter(FFrame&, void* const)

native function SpawnSound(Vector Location);  // Export UTgSpecialFx::execSpawnSound(FFrame&, void* const)

native function SpawnDecalAt(Vector HitLocation, Vector HitNormal, optional float DecalRotation=-1.0000000, optional float Scale=1.0000000);  // Export UTgSpecialFx::execSpawnDecalAt(FFrame&, void* const)

native function PlayCameraShake(Vector Epicenter);  // Export UTgSpecialFx::execPlayCameraShake(FFrame&, void* const)

native function SetHitEffectScaleBasedOnDamage(int nHealthChange);  // Export UTgSpecialFx::execSetHitEffectScaleBasedOnDamage(FFrame&, void* const)

native function bool IsFxRelevant(Vector SpawnLocation);  // Export UTgSpecialFx::execIsFxRelevant(FFrame&, void* const)

native function TgPlayerController FindLocalPlayerController();  // Export UTgSpecialFx::execFindLocalPlayerController(FFrame&, void* const)

native function TgPawn FindLocalPlayerPawn();  // Export UTgSpecialFx::execFindLocalPlayerPawn(FFrame&, void* const)

native function AdjustEffectRadius(int nPSCIndex, float fScale);  // Export UTgSpecialFx::execAdjustEffectRadius(FFrame&, void* const)

native function AdjustFxScaleByRadius(float fScale);  // Export UTgSpecialFx::execAdjustFxScaleByRadius(FFrame&, void* const)

native function AdjustEffectScale(int nPSCIndex, optional float fScale);  // Export UTgSpecialFx::execAdjustEffectScale(FFrame&, void* const)

native function AdjustEffectFOV(float NewFOV);  // Export UTgSpecialFx::execAdjustEffectFOV(FFrame&, void* const)

native function float Activate(optional Vector HitLocation, optional bool bSkipRelevantChecking=false);  // Export UTgSpecialFx::execActivate(FFrame&, void* const)

native function Deactivate(bool bForceDeactivate);  // Export UTgSpecialFx::execDeactivate(FFrame&, void* const)

native function OnParticleSystemFinished(ParticleSystemComponent FinishedComponent);  // Export UTgSpecialFx::execOnParticleSystemFinished(FFrame&, void* const)

native function OnAudioFinishedFX(AudioComponent FinishedComponent);  // Export UTgSpecialFx::execOnAudioFinishedFX(FFrame&, void* const)

native function CheckDeactivate();  // Export UTgSpecialFx::execCheckDeactivate(FFrame&, void* const)

native function PlaySound();  // Export UTgSpecialFx::execPlaySound(FFrame&, void* const)

native function StopSound();  // Export UTgSpecialFx::execStopSound(FFrame&, void* const)

native function ActivateDecal(out Fx_Decal Decal);  // Export UTgSpecialFx::execActivateDecal(FFrame&, void* const)

native function DeactivateDecal(out Fx_Decal Decal);  // Export UTgSpecialFx::execDeactivateDecal(FFrame&, void* const)

native function bool InitDecalFadeOut(out Fx_Decal Decal);  // Export UTgSpecialFx::execInitDecalFadeOut(FFrame&, void* const)

native function UpdateHiddenDecals(optional bool bClearAll=false);  // Export UTgSpecialFx::execUpdateHiddenDecals(FFrame&, void* const)

native function ParticleChannelContainer GetLocalPlayerPSCChannels(ParticleSystemComponent ActivePSC, optional ParticleSystem Template);  // Export UTgSpecialFx::execGetLocalPlayerPSCChannels(FFrame&, void* const)

native function OverridePSCChannels(ParticleChannelContainer PSysChannels);  // Export UTgSpecialFx::execOverridePSCChannels(FFrame&, void* const)

native function SkeletalMeshComponent FindMeshWithSocket(name nmSocket, SkeletalMeshComponent first, Actor Second, out name BoneName, out Vector RelativeLocation, out Rotator RelativeRotation, out Vector RelativeScale);  // Export UTgSpecialFx::execFindMeshWithSocket(FFrame&, void* const)

function bool HasSoundCue() { }

function Actor GetHitActor(Vector EffectLocation, Vector HitLocation) { }

event SpawnTracer(Vector HitLocation, optional Vector HitOrigin=vect(0.0000000, 0.0000000, 0.0000000)) { }

event DecalComponent SpawnDecal(WorldInfo WorldInfo, out Fx_Decal Decal, bool bUsePool, optional Vector SpawnLocation, optional Rotator SpawnRotation, optional float DecalRotation=-1.0000000, optional float Scale=1.0000000) { }

event UpdateBeamFx(Vector HitLocation, optional Vector HitOrigin=vect(0.0000000, 0.0000000, 0.0000000), optional Actor targetOverride) { }

function ListSounds() { }

function SetKillOnDeactivate() { }

event SetDepthPriorityGroup(Scene.ESceneDepthPriorityGroup NewDepthPriorityGroup) { }

function float CalculateOrientedDecalRotation(Vector HitLocation, Vector HitNormal, Vector DecalOrientationDirection) { }

native function bool IsFriendly();  // Export UTgSpecialFx::execIsFriendly(FFrame&, void* const)

native function bool IsLocal();  // Export UTgSpecialFx::execIsLocal(FFrame&, void* const)

defaultproperties
{
    c_bVisualComplete=true
    c_bAudioComplete=true
    c_nHitEffectBase=20
    c_fMaxEffectDistance=10000.0000000
    c_ParticleChannelOverride=(bInitialized=false,Default=true,Friendly=false,Enemy=false,LocalOwner=false,Channel5=false,Channel6=false,Channel7=false,Channel8=false,VerticalTargeter=false,Filter2=false,NotLocalOwner=false,CustomFilter1=false,CustomFilter2=false,CustomFilter3=false,CustomFilter4=false,CustomFilter5=false,CustomFilter6=false,CustomFilter7=false)
}
