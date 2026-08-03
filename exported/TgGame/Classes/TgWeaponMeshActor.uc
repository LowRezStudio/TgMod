class TgWeaponMeshActor extends Actor
    native
    notplaceable
    hidecategories(Navigation);

const TG_EQP_POINT_MAX = 33;

enum TG_PLAY_FIRE_EFFECT_ON
{
    START_FIRE,                     // 0
    Fire,                           // 1
    NEVER,                          // 2
    TG_PLAY_FIRE_EFFECT_ON_MAX      // 3
};

enum EFirstPersonWeaponAttachState
{
    FPAS_NeedsUpdate,               // 0
    FPAS_Attached,                  // 1
    FPAS_Detached,                  // 2
    FPAS_MAX                        // 3
};

struct native QueuedImpactEffect
{
    var Vector HitLocation;
    var bool bSuccessfulHit;
    var Actor HitActor;
    var Vector HitNormal;
    var Vector FireOrigin;
    var int nEquipSlot;

    structdefaultproperties
    {
        HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        bSuccessfulHit=false
        HitActor=none
        HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        FireOrigin=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        nEquipSlot=0
    }
};

var TgPawn m_OwningPawn;
var const Class<TgSkeletalMeshComponent_Weapon> m_WeaponMesh1PClass;
var export editinline TgSkeletalMeshComponent_Weapon m_WeaponMesh1P;
var const Class<TgSkeletalMeshComponent_Weapon> m_WeaponMesh3PClass;
var export editinline TgSkeletalMeshComponent_Weapon m_WeaponMesh3P;
var array<TgAnimNodeSimpleTransitioner> m_SimpleTransitionerNodes1P;
var array<TgAnimBlendByFireMode> m_DeviceModeBlendNodes;
var array<TgAnimNodeFitToDuration> m_FitToDurationNodes;
var array<TgAnimBlendByPaladinsCharacter> m_PaladinsCharacterNodes;
var array<TgAnimNodeTriggerCameraAnim> m_TriggerCameraAnimNodes;
var TgAnimNodeSlot PoseTransitioner;
var array<TgAnimNodeSimpleTransitioner> m_PawnMeshSimpleTransitionerNodes;
var array<TgAnimNodeFitToDuration> m_PawnMeshFitToDurationNodes;
var array<TgAnimBlendByPaladinsCharacter> m_PawnMeshPaladinsCharacterNodes;
var array<TgAnimNodeTriggerCameraAnim> m_PawnMeshTriggerCameraAnimNodes;
var int m_nEquipSlot;
var int m_nDeviceId;
var int m_MeshAsmId1P;
var int m_MeshAsmId3P;
var Class<TgDevice> m_WeaponClass;
var TgWeaponMeshActor.TG_PLAY_FIRE_EFFECT_ON m_PlayFireEffectsOn[33];
var TgObject.TG_EQUIP_POINT m_ActiveEquipPoint;
var transient TgWeaponMeshActor.EFirstPersonWeaponAttachState Current1pAttachState;
var bool m_bShouldLoopingMuzzleTrace;
var bool m_bUseSocketForCameraAttach;
var bool m_bProceduralBob;
var protected bool m_bIsFOVZoomed;
var bool m_bFlourishBlocked;
var transient bool m_bIsHoldingBeacon;
var bool m_bWasViewTargetLastTick;
var bool m_bUseCameraAnims;
var bool c_bEnemyMatLoaded;
var export editinline TgSkeletalMeshComponent m_HandsMesh;
var export editinline TgSkeletalMeshComponent m_HeadMesh1P;
var Vector2D m_v2WeaponLagAimOffset;
var(WeaponLag) Vector2D m_nMaxWeaponLag;
var(WeaponLag) Vector2D m_v2WeaponLagInterpSpeed;
var(WeaponLag) Vector2D m_v2WeaponLagSmoothingFactor;
var Rotator m_rLastRotation;
var() editinline TgCameraShake m_FireCameraShake;
var int m_nTracerCounter;
var() int m_nTracerFrequency;
var name m_TracerName;
var float m_fTracerLifetime;
var name m_HitTargetName;
var name m_HitWallName;
var() float m_BeamEmitterEndPointOffset;
var const int m_nBeaconMeshId;
var array<TgSkelCon_HitReaction> m_HitReactionSkelControls;
var array<QueuedImpactEffect> m_QueuedImpactEffects;

// Export UTgWeaponMeshActor::execGetMeshAsmIds(FFrame&, void* const)
native static function GetMeshAsmIds(int DeviceID, out int MeshId1P, out int MeshId3P);

// Export UTgWeaponMeshActor::execGetWeaponClassById(FFrame&, void* const)
native static function string GetWeaponClassById(int DeviceID);

// Export UTgWeaponMeshActor::execUpdateReticule(FFrame&, void* const)
native function UpdateReticule();

// Export UTgWeaponMeshActor::execUpdateHandsMesh(FFrame&, void* const)
native function UpdateHandsMesh();

// Export UTgWeaponMeshActor::execUpdateHeadMesh1P(FFrame&, void* const)
native function UpdateHeadMesh1P();

// Export UTgWeaponMeshActor::execNativeInit(FFrame&, void* const)
native function NativeInit(byte EquipPoint, int DeviceID);

// Export UTgWeaponMeshActor::execGetDefaultDevice(FFrame&, void* const)
native function TgDevice GetDefaultDevice();

// Export UTgWeaponMeshActor::execIsFriendlyWithLocalPawn(FFrame&, void* const)
native function bool IsFriendlyWithLocalPawn();

// Export UTgWeaponMeshActor::execForceRecalculateMaterial(FFrame&, void* const)
native function ForceRecalculateMaterial();

// Export UTgWeaponMeshActor::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);

// Export UTgWeaponMeshActor::execSetLocationForWeapon(FFrame&, void* const)
native final function SetLocationForWeapon(Vector NewLocation, Actor OwningPawn);

// Export UTgWeaponMeshActor::execCheckOcclusion(FFrame&, void* const)
native function float CheckOcclusion();

// Export UTgWeaponMeshActor::execGetFxOverrideFor(FFrame&, void* const)
native function int GetFxOverrideFor(int nBaseFXID);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    c_bEnemyMatLoaded = !IsFriendlyWithLocalPawn();
    //return;    
}

simulated function bool IsFirstPerson()
{
    local TgPawn TgP;

    TgP = TgPawn(Owner);
    // End:0x4B
    if(TgP != none)
    {
        return TgP.IsFirstPerson();
    }
    return false;
    //return ReturnValue;    
}

simulated event Destroyed()
{
    ClearEquipPoint(0);
    super.Destroyed();
    //return;    
}

simulated function ClearEquipPoint(byte EquipPoint)
{
    local TgPawn TgP;

    TgP = TgPawn(Owner);
    // End:0x55
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.DetachFromAny();
        m_WeaponMesh1P = none;
    }
    // End:0xED
    if(m_WeaponMesh3P != none)
    {
        // End:0xC3
        if(TgP != none)
        {
            TgP.RemoveOverlayInfo(m_WeaponMesh3P);
            TgP.RemoveSilhouetteInfo(m_WeaponMesh3P);
        }
        m_WeaponMesh3P.DetachFromAny();
        m_WeaponMesh3P = none;
    }
    //return;    
}

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint = true)
{
    // End:0x25
    if(bClearEquipPoint)
    {
        ClearEquipPoint(EquipPoint);
    }
    GetMeshAsmIds(DeviceID, m_MeshAsmId1P, m_MeshAsmId3P);
    Initialize1P(EquipPoint, DeviceID);
    Initialize3P(EquipPoint, DeviceID);
    //return;    
}

simulated function FixUpReferencesToWeaponMesh1P(SkeletalMeshComponent WeaponMesh)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;
    local TgAnimNodeTriggerCameraAnim TriggerCameraAnimNode;
    local TgAnimBlendByFireMode FireModeNode;
    local TgAnimNodeFitToDuration FitToDurationNode;
    local TgAnimNodeSimpleTransitioner SimpleTransitionerNode;
    local TgAnimNodeAimOffset AimOffset;
    local TgAnimNodeSlot PoseNode;
    local AnimNode AnimNode;

    m_SimpleTransitionerNodes1P.Length = 0;
    m_FitToDurationNodes.Length = 0;
    m_DeviceModeBlendNodes.Length = 0;
    m_PaladinsCharacterNodes.Length = 0;
    m_TriggerCameraAnimNodes.Length = 0;
    PoseTransitioner = none;
    // End:0x2AA
    foreach WeaponMesh.AllAnimNodes(Class'Engine.AnimNode', AnimNode)
    {
        PaladinsCharNode = TgAnimBlendByPaladinsCharacter(AnimNode);
        TriggerCameraAnimNode = TgAnimNodeTriggerCameraAnim(AnimNode);
        SimpleTransitionerNode = TgAnimNodeSimpleTransitioner(AnimNode);
        AimOffset = TgAnimNodeAimOffset(AnimNode);
        PoseNode = TgAnimNodeSlot(AnimNode);
        FireModeNode = TgAnimBlendByFireMode(AnimNode);
        FitToDurationNode = TgAnimNodeFitToDuration(AnimNode);
        // End:0x167
        if(SimpleTransitionerNode != none)
        {
            m_SimpleTransitionerNodes1P.AddItem(SimpleTransitionerNode);
            // End:0x2A9
            continue;
        }
        // End:0x1BA
        if((PoseNode != none) && PoseNode.NodeName == 'TransitionSlot')
        {
            PoseTransitioner = PoseNode;
            // End:0x2A9
            continue;
        }
        // End:0x1EC
        if(AimOffset != none)
        {
            AimOffset.m_WeaponMeshActor = self;
            // End:0x2A9
            continue;
        }
        // End:0x214
        if(FireModeNode != none)
        {
            m_DeviceModeBlendNodes.AddItem(FireModeNode);
            // End:0x2A9
            continue;
        }
        // End:0x23C
        if(FitToDurationNode != none)
        {
            m_FitToDurationNodes.AddItem(FitToDurationNode);
            // End:0x2A9
            continue;
        }
        // End:0x284
        if(PaladinsCharNode != none)
        {
            PaladinsCharNode.m_WeaponMeshActor = self;
            m_PaladinsCharacterNodes.AddItem(PaladinsCharNode);
            // End:0x2A9
            continue;
        }
        // End:0x2A9
        if(TriggerCameraAnimNode != none)
        {
            m_TriggerCameraAnimNodes.AddItem(TriggerCameraAnimNode);
        }        
    }    
    CacheHitReactionSkelControls();
    //return;    
}

simulated function FixUpReferencesToPawnMesh(SkeletalMeshComponent PawnMesh)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;
    local TgAnimNodeTriggerCameraAnim TriggerCameraAnimNode;
    local TgAnimNodeSimpleTransitioner SimpleTransitionerNode;
    local TgAnimNodeFitToDuration FitToDurationNode;
    local AnimNode AnimNode;

    m_PawnMeshSimpleTransitionerNodes.Length = 0;
    m_PawnMeshFitToDurationNodes.Length = 0;
    m_PawnMeshPaladinsCharacterNodes.Length = 0;
    m_PawnMeshTriggerCameraAnimNodes.Length = 0;
    // End:0x172
    foreach PawnMesh.AllAnimNodes(Class'Engine.AnimNode', AnimNode)
    {
        SimpleTransitionerNode = TgAnimNodeSimpleTransitioner(AnimNode);
        PaladinsCharNode = TgAnimBlendByPaladinsCharacter(AnimNode);
        TriggerCameraAnimNode = TgAnimNodeTriggerCameraAnim(AnimNode);
        FitToDurationNode = TgAnimNodeFitToDuration(AnimNode);
        // End:0xFC
        if(SimpleTransitionerNode != none)
        {
            m_PawnMeshSimpleTransitionerNodes.AddItem(SimpleTransitionerNode);
            // End:0x171
            continue;
        }
        // End:0x124
        if(PaladinsCharNode != none)
        {
            m_PawnMeshPaladinsCharacterNodes.AddItem(PaladinsCharNode);
            // End:0x171
            continue;
        }
        // End:0x14C
        if(TriggerCameraAnimNode != none)
        {
            m_PawnMeshTriggerCameraAnimNodes.AddItem(TriggerCameraAnimNode);
            // End:0x171
            continue;
        }
        // End:0x171
        if(FitToDurationNode != none)
        {
            m_PawnMeshFitToDurationNodes.AddItem(FitToDurationNode);
        }        
    }    
    //return;    
}

simulated function Initialize1P(byte EquipPoint, int DeviceID, optional int MeshAsmId1P = -1)
{
    local int I;
    local TgPawn InstPawn;

    // End:0x2B
    if(MeshAsmId1P < 0)
    {
        MeshAsmId1P = m_MeshAsmId1P;
    }
    // End:0x3C
    if(MeshAsmId1P <= 0)
    {
        return;
    }
    InstPawn = TgPawn(Instigator);
    // End:0x69
    if(InstPawn == none)
    {
        return;
    }
    // End:0xD0
    if((m_WeaponMesh1P != none) && m_WeaponMesh1P.Class != m_WeaponMesh1PClass)
    {
        m_WeaponMesh1P.DetachFromAny();
        m_WeaponMesh1P = none;
    }
    // End:0x18B
    if((m_WeaponMesh1P == none) && m_WeaponMesh1PClass != none)
    {
        m_WeaponMesh1P = new (self) m_WeaponMesh1PClass;
        m_WeaponMesh1P.SetLightEnvironment(TgPawn(Instigator).LightEnvironment);
        m_WeaponMesh1P.SetFOV(m_WeaponClass.default.m_fMeshFOV);
    }
    // End:0x19C
    if(m_WeaponMesh1P == none)
    {
        return;
    }
    InstPawn.CreateMeshComponent(MeshAsmId1P, m_WeaponMesh1P, true);
    NativeInit(EquipPoint, DeviceID);
    FixUpReferencesToWeaponMesh1P(m_WeaponMesh1P);
    I = 0;
    J0x208:

    // End:0x29B [Loop If]
    if(I < 33)
    {
        // End:0x28D
        if(InstPawn.c_EquipForm[I] != none)
        {
            InstPawn.c_EquipForm[I].Cache1PAnimNodes(m_WeaponMesh1P);
        }
        I++;
        // [Loop Continue]
        goto J0x208;
    }
    InstPawn.InitializeOverlayMeshComponent(m_WeaponMesh1P, true);
    m_WeaponMesh1P.CompleteInitialization();
    //return;    
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    local int I;
    local TgPawn InstPawn;
    local editinline TgSkeletalMeshComponent TgSkelComp;

    super.PostInitAnimTree(SkelComp);
    // End:0x3D
    if((m_WeaponMesh1P != none) && m_WeaponMesh1P != SkelComp)
    {
        return;
    }
    FixUpReferencesToWeaponMesh1P(SkelComp);
    InstPawn = TgPawn(Instigator);
    TgSkelComp = TgSkeletalMeshComponent(SkelComp);
    // End:0xAA
    if((InstPawn == none) || TgSkelComp == none)
    {
        return;
    }
    I = 0;
    J0xB5:

    // End:0x148 [Loop If]
    if(I < 33)
    {
        // End:0x13A
        if(InstPawn.c_EquipForm[I] != none)
        {
            InstPawn.c_EquipForm[I].Cache1PAnimNodes(TgSkelComp);
        }
        I++;
        // [Loop Continue]
        goto J0xB5;
    }
    //return;    
}

simulated function Initialize3P(byte EquipPoint, int DeviceID)
{
    local TgPawn TgP;

    TgP = TgPawn(Owner);
    // End:0x53
    if((TgP == none) || TgP.Mesh == none)
    {
        return;
    }
    FixUpReferencesToPawnMesh(TgP.Mesh);
    // End:0x124
    if(m_WeaponMesh3P != none)
    {
        TgP.RemoveOverlayInfo(m_WeaponMesh3P);
        TgP.RemoveSilhouetteInfo(m_WeaponMesh3P);
        m_WeaponMesh3P.DetachFromAny();
        m_WeaponMesh3P.SetParentAnimComponent(none);
        m_WeaponMesh3P = none;
    }
    // End:0x38A
    if((m_WeaponMesh3PClass != none) && m_MeshAsmId3P > 0)
    {
        m_WeaponMesh3P = new (TgP) m_WeaponMesh3PClass;
        TgP.AttachComponent(m_WeaponMesh3P);
        m_WeaponMesh3P.bUseBoundsFromParentAnimComponent = false;
        // End:0x213
        if(int(TgP.c_LocalPolymorph) == int(0))
        {
            m_WeaponMesh3P.SetParentAnimComponent(TgP.Mesh);
        }
        TgP.CreateMeshComponent(m_MeshAsmId3P, m_WeaponMesh3P);
        m_WeaponMesh3P.SetLightEnvironment(TgP.Mesh.LightEnvironment);
        m_WeaponMesh3P.SetShadowParent(TgP.Mesh);
        m_WeaponMesh3P.m_bForceHideComponent = int(TgP.c_LocalPolymorph) > int(0);
        TgP.InitializeSilhouetteComponent(m_WeaponMesh3P);
        TgP.InitializeOverlayMeshComponent(m_WeaponMesh3P);
        m_WeaponMesh3P.CompleteInitialization();
    }
    TgP.AddRemoveAnimSetList(TgP.c_EquipForm[int(EquipPoint)].c_PawnAnimSetOverrideList, true);
    //return;    
}

simulated event SetActiveWeapon(byte EquipPoint, int DeviceID, Class<TgDevice> WeaponClass, WeaponMeshSwapStrategy SwapStrategy)
{
    // End:0x22
    if(m_WeaponMesh1P != none)
    {
        DetachComponent(m_WeaponMesh1P);
    }
    m_nEquipSlot = int(EquipPoint);
    m_nDeviceId = DeviceID;
    m_WeaponClass = WeaponClass;
    InitializeForWeapon(EquipPoint, DeviceID, SwapStrategy.bClearEquipPoint);
    // End:0xB8
    if(m_WeaponMesh1P != none)
    {
        AttachComponent(m_WeaponMesh1P);
    }
    m_ActiveEquipPoint = EquipPoint;
    UpdateReticule();
    // End:0x1F4
    if(m_WeaponClass != none)
    {
        // End:0x113
        if(m_WeaponClass.default.m_bParentAnimComponentHands)
        {
            UpdateHandsMesh();            
        }
        else
        {
            // End:0x16C
            if(m_HandsMesh != none)
            {
                m_HandsMesh.DetachFromAny();
                m_HandsMesh.SetOwnerNoSee(true);
                m_HandsMesh = none;
            }
        }
        // End:0x19B
        if(m_WeaponClass.default.m_bParentAnimComponent1PHead)
        {
            UpdateHeadMesh1P();            
        }
        else
        {
            // End:0x1F4
            if(m_HeadMesh1P != none)
            {
                m_HeadMesh1P.DetachFromAny();
                m_HeadMesh1P.SetOwnerNoSee(true);
                m_HeadMesh1P = none;
            }
        }
    }
    // End:0x22E
    if(int(SwapStrategy.RetrieveStrategy) > int(0))
    {
        PlayRetrieve(SwapStrategy);
    }
    Current1pAttachState = 0;
    //return;    
}

simulated function PlayPutaway(TgObject.TG_EQUIP_POINT eqp, int DeviceID, Class<TgDevice> WeaponClass)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x52
    foreach m_PaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnPutAway(eqp, DeviceID, WeaponClass);        
    }    
    // End:0xA5
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnPutAway(eqp, DeviceID, WeaponClass);        
    }    
    //return;    
}

simulated function PlayRetrieve(WeaponMeshSwapStrategy SwapStrategy)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x37
    foreach m_PaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnRetrieve();        
    }    
    //return;    
}

simulated function OnBehindViewUpdated(bool bNewBehindView)
{
    // End:0x86
    if(bNewBehindView)
    {
        // End:0x47
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.FxDeactivateGroup('AlwaysOn', 0);
        }
        // End:0x83
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.FxActivateGroup('AlwaysOn', 0);
        }        
    }
    else
    {
        // End:0xC2
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.FxActivateGroup('AlwaysOn', 0);
        }
        // End:0xFC
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.FxDeactivateGroup('AlwaysOn', 0);
        }
    }
    //return;    
}

// Export UTgWeaponMeshActor::execSet1PAttachState(FFrame&, void* const)
native final simulated function Set1PAttachState(TgWeaponMeshActor.EFirstPersonWeaponAttachState NewAttachState);

simulated function Toggle1PVisibility(bool bVisible)
{
    local bool bVisibilityChanged;
    local TgPawn TgP;

    bVisibilityChanged = false;
    // End:0x7C
    if(m_WeaponMesh1P != none)
    {
        bVisibilityChanged = bVisible == m_WeaponMesh1P.bOwnerNoSee;
        m_WeaponMesh1P.SetOwnerNoSee(!bVisible);
    }
    // End:0xB6
    if(m_HandsMesh != none)
    {
        m_HandsMesh.SetOwnerNoSee(!bVisible);
    }
    // End:0xF0
    if(m_HeadMesh1P != none)
    {
        m_HeadMesh1P.SetOwnerNoSee(!bVisible);
    }
    // End:0x18E
    if((bVisible && bVisibilityChanged) && m_bWasViewTargetLastTick)
    {
        PlayWeaponQuickRetrieve();
        TgP = TgPawn(Owner);
        // End:0x18E
        if(TgP != none)
        {
            TgP.UpdateOverlayVisibilityBody();
            TgP.UpdateOverlayVisibilityWeapon();
        }
    }
    //return;    
}

simulated exec function PlayWeaponQuickRetrieve()
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x37
    foreach m_PaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnRetrieve();        
    }    
    //return;    
}

simulated function ToggleHoldingBeacon(bool bHolding)
{
    // End:0x168
    if(m_bIsHoldingBeacon != bHolding)
    {
        // End:0x153
        if(m_nBeaconMeshId > 0)
        {
            // End:0xB8
            if(bHolding)
            {
                Initialize1P(byte(m_nEquipSlot), m_nDeviceId, m_nBeaconMeshId);
                // End:0xB5
                if(m_HandsMesh != none)
                {
                    m_HandsMesh.DetachFromAny();
                    m_HandsMesh.SetParentAnimComponent(none);
                    m_HandsMesh = none;
                }                
            }
            else
            {
                Initialize1P(byte(m_nEquipSlot), m_nDeviceId);
                // End:0x114
                if((m_WeaponClass != none) && m_WeaponClass.default.m_bParentAnimComponentHands)
                {
                    UpdateHandsMesh();
                }
            }
            // End:0x153
            if((m_WeaponMesh1P != none) && !m_WeaponMesh1P.bOwnerNoSee)
            {
                PlayWeaponQuickRetrieve();
            }
        }
        m_bIsHoldingBeacon = bHolding;
    }
    //return;    
}

simulated function bool CanUseCameraBone()
{
    // End:0x0F
    if(m_bUseCameraAnims)
    {
        return false;
    }
    // End:0x20
    if(m_WeaponMesh1P == none)
    {
        return false;
    }
    // End:0x54
    if(m_WeaponMesh1P.MatchRefBone('Camera_bn') == -1)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
    UpdateTransform(DeltaTime);
    //return;    
}

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate = false)
{
    local TgPawn TgP;
    local Vector WeaponBob, ViewOffset, ViewLoc;
    local float BobAmount, PreviewFOV;
    local TgPlayerController TgPC, localPC;
    local bool bNewOwnerNoSee;
    local editinline TgSkeletalMeshComponent CurrentSkelMesh1P;
    local Rotator NewRotation;
    local int I;
    local TgCameraModule_ThirdPerson CameraModule;

    TgP = TgPawn(Owner);
    // End:0x43
    if((TgP == none) || m_WeaponMesh1P == none)
    {
        return;
    }
    // End:0x98
    if(!WorldInfo.IsPlayingTimelapse())
    {
        TgPC = TgPlayerController(TgP.Controller);
    }
    // End:0xB6
    if(Base == none)
    {
        SetBase(TgP);
    }
    CurrentSkelMesh1P = m_WeaponMesh1P;
    localPC = TgPlayerController(GetALocalPlayerController());
    // End:0xB5A
    if(TgP.ShouldBeFirstPersonThisTick())
    {
        // End:0x196
        if(localPC != none)
        {
            bNewOwnerNoSee = (TgCameraModule_ThirdPerson(localPC.GetCurrentCameraModule()) != none) && TgCameraModule_ThirdPerson(localPC.GetCurrentCameraModule()).fZoomFactorInterp > 0.0500000;
        }
        Set1PAttachState(1);
        Toggle1PVisibility(!bNewOwnerNoSee);
        // End:0x269
        filtereditoronly
        {
            ViewOffset.X += @NULL.X;
            ViewOffset.Y += @NULL.Y;
            ViewOffset.Z += @NULL.Z;
        }
        // End:0x2DE
        if(!CanUseCameraBone())
        {
            NewRotation = localPC.PlayerCamera.CameraCache.POV.Rotation;            
        }
        else
        {
            // End:0x32D
            if(TgPC != none)
            {
                NewRotation = TgP.Controller.Rotation;                
            }
            else
            {
                NewRotation = TgP.Rotation;
                NewRotation.Pitch = TgP.m_nSmoothedRemoteViewPitch;
            }
        }
        // End:0x3C7
        if(m_WeaponClass != none)
        {
            BobAmount = m_WeaponClass.default.m_fWeaponBob;
        }
        AddWeaponLeading(NewRotation, m_rLastRotation, DeltaTime);
        m_rLastRotation = NewRotation;
        // End:0x545
        if(m_bProceduralBob)
        {
            // End:0x423
            filtereditoronly
            {
                BobAmount += @NULL;
            }
            TgP.UpdateBob(DeltaTime);
            WeaponBob = BobAmount * TgP.WalkBob;
            ViewOffset.X += WeaponBob.X;
            ViewOffset.Y += WeaponBob.Y;
            ViewOffset.Z += ((0.4500000 + (0.5500000 * BobAmount)) * WeaponBob.Z);
        }
        ViewOffset = ViewOffset >> NewRotation;
        // End:0x6F2
        filtereditoronly
        {
            // End:0x6F2
            if(@NULL != float(0))
            {
                PreviewFOV = @NULL;
                // End:0x5C3
                if(m_WeaponClass != none)
                {
                    PreviewFOV += m_WeaponClass.default.m_fMeshFOV;
                }
                // End:0x628
                if((m_WeaponMesh1P != none) && m_WeaponMesh1P.FOV != PreviewFOV)
                {
                    m_WeaponMesh1P.SetFOV(PreviewFOV);
                }
                // End:0x68D
                if((m_HandsMesh != none) && m_HandsMesh.FOV != PreviewFOV)
                {
                    m_HandsMesh.SetFOV(PreviewFOV);
                }
                // End:0x6F2
                if((m_HeadMesh1P != none) && m_HeadMesh1P.FOV != PreviewFOV)
                {
                    m_HeadMesh1P.SetFOV(PreviewFOV);
                }
            }
        }
        // End:0x8CD
        if(!CanUseCameraBone())
        {
            // End:0x8CA
            if(bFromCameraUpdate)
            {
                ViewLoc = localPC.PlayerCamera.CameraCache.POV.Location;
                SetLocationForWeapon(ViewLoc + ViewOffset, Owner);
                SetRotation(NewRotation);
                CurrentSkelMesh1P.ForceUpdate(true);
                I = 0;
                J0x7CF:

                // End:0x85C [Loop If]
                if(I < CurrentSkelMesh1P.Attachments.Length)
                {
                    CurrentSkelMesh1P.Attachments[I].Component.ForceUpdate(true);
                    I++;
                    // [Loop Continue]
                    goto J0x7CF;
                }
                m_HandsMesh.ForceUpdate(true);
                // End:0x8AB
                if(m_HeadMesh1P != none)
                {
                    m_HeadMesh1P.ForceUpdate(true);
                }
                TgP.ForceUpdate1PMeshes();
            }            
        }
        else
        {
            // End:0x990
            if((m_bUseSocketForCameraAttach && TgP.IsAliveAndWell()) && CanUseCameraBone())
            {
                ViewLoc = TgP.Location;
                ViewLoc.Z += TgP.BaseEyeHeight;
                SetLocationForWeapon(ViewLoc, Owner);                
            }
            else
            {
                // End:0xAA1
                if(TgPC != none)
                {
                    CameraModule = TgCameraModule_ThirdPerson(TgPC.GetCurrentCameraModule());
                    // End:0xA7A
                    if(CameraModule != none)
                    {
                        ViewLoc = (CameraModule.GetCamAttachPoint(TgP) + CameraModule.GetCamLocationOffset(TgPC.Rotation, TgP)) + TgP.WalkBob;
                    }
                    SetLocationForWeapon(ViewLoc + ViewOffset, Owner);
                }
            }
            // End:0xADE
            if(TgPC != none)
            {
                SetRotation(ApplyRotationModifier(TgPC.Rotation));                
            }
            else
            {
                NewRotation = TgP.Rotation;
                NewRotation.Pitch = TgP.m_nSmoothedRemoteViewPitch;
                SetRotation(ApplyRotationModifier(NewRotation));
            }
        }        
    }
    else
    {
        Set1PAttachState(2);
        Toggle1PVisibility(false);
    }
    CurrentSkelMesh1P.bUpdateSkelWhenNotRendered = (localPC != none) && localPC.GetViewTarget() == TgP;
    CurrentSkelMesh1P.bTickAnimNodesWhenNotRendered = CurrentSkelMesh1P.bUpdateSkelWhenNotRendered;
    // End:0xC98
    if(m_HandsMesh != none)
    {
        m_HandsMesh.bUpdateSkelWhenNotRendered = CurrentSkelMesh1P.bUpdateSkelWhenNotRendered;
        m_HandsMesh.bTickAnimNodesWhenNotRendered = CurrentSkelMesh1P.bTickAnimNodesWhenNotRendered;
    }
    // End:0xD25
    if(m_HeadMesh1P != none)
    {
        m_HeadMesh1P.bUpdateSkelWhenNotRendered = CurrentSkelMesh1P.bUpdateSkelWhenNotRendered;
        m_HeadMesh1P.bTickAnimNodesWhenNotRendered = CurrentSkelMesh1P.bTickAnimNodesWhenNotRendered;
    }
    UpdateBeamEffects(int(m_ActiveEquipPoint));
    // End:0xD8F
    if(localPC != none)
    {
        m_bWasViewTargetLastTick = (localPC.GetViewTarget() == Owner) && Owner != none;
    }
    //return;    
}

simulated function Rotator ApplyRotationModifier(Rotator inRot)
{
    return inRot;
    //return ReturnValue;    
}

simulated function GetAllFireLoopParticleSystemComponents(out array<editinline ParticleSystemComponent> FireLoopParticles, optional int nEquipSlot = 1)
{
    // End:0x46
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.super(TgWeaponMeshActor).GetAllFireLoopParticleSystemComponents(FireLoopParticles, nEquipSlot);
    }
    // End:0x87
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.super(TgWeaponMeshActor).GetAllFireLoopParticleSystemComponents(FireLoopParticles, nEquipSlot);
    }
    //return;    
}

simulated function UpdateBeamEffects(int nEquipSlotToUpdate)
{
    local Vector HitLocation;
    local bool bHasEndPoint;

    // End:0x1A
    if(!ShouldUpdateBeamEffects(nEquipSlotToUpdate))
    {
        return;
    }
    bHasEndPoint = GetAccurateBeamTarget(HitLocation, nEquipSlotToUpdate);
    // End:0x77
    if(!bHasEndPoint)
    {
        bHasEndPoint = GetSimulatedBeamTarget(HitLocation, nEquipSlotToUpdate);
    }
    UpdateFireLoopBeamParams(bHasEndPoint, HitLocation, nEquipSlotToUpdate);
    //return;    
}

simulated function bool ShouldUpdateBeamEffects(int nEquipSlot)
{
    return ((m_WeaponMesh1P != none) && m_WeaponMesh1P.IsFireLoopActive(nEquipSlot)) || (m_WeaponMesh3P != none) && m_WeaponMesh3P.IsFireLoopActive(nEquipSlot);
    //return ReturnValue;    
}

simulated function UpdateFireLoopBeamParams(bool bHasEndPoint, Vector HitLocation, optional int nEquipSlot = 1)
{
    local int I;
    local editinline array<editinline ParticleSystemComponent> FireLoopParticles;
    local editinline ParticleSystemComponent Particle;

    // End:0xEF
    if(bHasEndPoint)
    {
        GetAllFireLoopParticleSystemComponents(FireLoopParticles, nEquipSlot);
        // End:0xEE
        foreach FireLoopParticles(Particle)
        {
            Particle.SetVectorParameter('beamEnd', HitLocation);
            I = 0;
            J0x81:

            // End:0xED [Loop If]
            if(I < Particle.EmitterInstances.Length)
            {
                Particle.SetBeamEndPoint(I, HitLocation);
                I++;
                // [Loop Continue]
                goto J0x81;
            }            
        }        
    }
    //return;    
}

simulated function bool GetAccurateBeamTarget(out Vector HitLocation, int nEquipSlot)
{
    local AimData Aim;
    local Vector POVLoc;
    local Rotator POVRot, AimRot;
    local TgPawn TgP;
    local TgDevice TgD;

    TgP = TgPawn(Owner);
    // End:0x2D
    if(TgP == none)
    {
        return false;
    }
    TgD = TgP.GetDeviceByEqPoint(nEquipSlot);
    // End:0x70
    if(TgD == none)
    {
        return false;
    }
    // End:0x1C7
    if(m_bShouldLoopingMuzzleTrace)
    {
        TgD.GetTargetingAim(Aim);
        // End:0x1C7
        if(Aim.bResult)
        {
            Aim.EndTrace = Aim.StartTrace + (VSize(Aim.EndTrace - Aim.StartTrace) * Aim.AimVector);
            // End:0x1C7
            if(TgD.GetCurrentFire() != none)
            {
                HitLocation = TgD.CalcWeaponFire(Aim).HitLocation;
                return true;
            }
        }
    }
    Aim.StartTrace = TgP.GetWeaponStartTraceLocation(TgD);
    TgP.GetAdjustedAimNative(TgD, Aim.StartTrace, AimRot);
    // End:0x377
    if((TgP.Controller != none) && TgD.m_bAimThroughReticule)
    {
        TgP.Controller.GetPlayerViewPoint(POVLoc, POVRot);
        Aim.AimVector = Vector(AimRot);
        Aim.EndTrace = POVLoc + (Aim.AimVector * TgD.GetRange());        
    }
    else
    {
        Aim.AimVector = Vector(AimRot);
        Aim.EndTrace = Aim.AimVector * TgD.GetRange();
    }
    HitLocation = Aim.EndTrace;
    return true;
    //return ReturnValue;    
}

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot)
{
    local TgDeviceForm DeviceForm;
    local Vector HitNormal, fireLoc, EndLoc;
    local Rotator FireRot;
    local TgPawn TgP;
    local editinline TgSkeletalMeshComponent SkelMesh3P;

    TgP = TgPawn(Owner);
    SkelMesh3P = Get3PWeaponMesh();
    // End:0x53
    if((SkelMesh3P == none) || TgP == none)
    {
        return false;
    }
    SkelMesh3P.GetSocketWorldLocationAndRotation('WSO_Emit_01', fireLoc, FireRot);
    DeviceForm = TgP.c_EquipForm[int(m_ActiveEquipPoint)];
    // End:0x244
    if(DeviceForm != none)
    {
        FireRot = TgP.Rotation;
        // End:0x156
        if(FireRot.Pitch == 0)
        {
            FireRot.Pitch = TgP.m_nSmoothedRemoteViewPitch;
        }
        EndLoc = fireLoc + (Vector(FireRot) * DeviceForm.ModeDatas[DeviceForm.c_nFireMode].c_fMaxRange);
        // End:0x21D
        if(!m_bShouldLoopingMuzzleTrace || Trace(HitLocation, HitNormal, EndLoc, fireLoc,,,, 1) == none)
        {
            HitLocation = EndLoc;
        }
        HitLocation.Z += m_BeamEmitterEndPointOffset;
    }
    return true;
    //return ReturnValue;    
}

simulated function PlayTargetingEffects(int nEquipSlot)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x42
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnDeviceTargeting(byte(nEquipSlot));        
    }    
    // End:0x96
    if(nEquipSlot != 7)
    {
        // End:0x95
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.OnDeviceTargeting(byte(nEquipSlot));            
        }        
    }
    //return;    
}

simulated function PlayBuildupEffects(int nEquipSlot)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x42
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnDeviceBuildup(byte(nEquipSlot));        
    }    
    // End:0x96
    if(nEquipSlot != 7)
    {
        // End:0x95
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.OnDeviceBuildup(byte(nEquipSlot));            
        }        
    }
    // End:0x10D
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.FxDeactivateGroup('BuildUp', nEquipSlot);
        m_WeaponMesh1P.FxActivateGroup('BuildUp', nEquipSlot);
    }
    // End:0x184
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.FxDeactivateGroup('BuildUp', nEquipSlot);
        m_WeaponMesh3P.FxActivateGroup('BuildUp', nEquipSlot);
    }
    //return;    
}

simulated function AttackComboTimeout()
{
    local TgAnimNodeSimpleTransitioner SimpleTransitionerIterator;
    local bool bNeedsTransition;

    // End:0x6A
    foreach m_SimpleTransitionerNodes1P(SimpleTransitionerIterator)
    {
        // End:0x69
        if(SimpleTransitionerIterator.ActiveChildIndex == 2)
        {
            SimpleTransitionerIterator.SetStance(0);
            bNeedsTransition = true;
        }        
    }    
    // End:0xD5
    foreach m_PawnMeshSimpleTransitionerNodes(SimpleTransitionerIterator)
    {
        // End:0xD4
        if(SimpleTransitionerIterator.ActiveChildIndex == 2)
        {
            SimpleTransitionerIterator.SetStance(0);
            bNeedsTransition = true;
        }        
    }    
    // End:0x133
    if((PoseTransitioner != none) && bNeedsTransition)
    {
        PoseTransitioner.PlayCustomAnim('Trans_to_Stance_01', 1.0000000, 0.0000000, 0.1000000, false, true, 0.0000000);
    }
    //return;    
}

simulated function SetLoopingMuzzleEffects(bool bSetActive, optional int nEquipSlot = 1)
{
    // End:0x85
    if(bSetActive)
    {
        // End:0x4A
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.PlayFireLoop(nEquipSlot);
        }
        // End:0x82
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.PlayFireLoop(nEquipSlot);
        }        
    }
    else
    {
        // End:0xBD
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.StopFireLoop(nEquipSlot);
        }
        // End:0xF5
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.StopFireLoop(nEquipSlot);
        }
    }
    //return;    
}

simulated function bool ShowAsLocallyOwned()
{
    local TgPawn TgP;
    local TgPlayerController LocalTgPC;

    TgP = TgPawn(Owner);
    LocalTgPC = TgPlayerController(GetALocalPlayerController());
    return ((TgP != none) && LocalTgPC != none) && LocalTgPC.GetTgPawn() == TgP;
    //return ReturnValue;    
}

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode)
{
    local TgAnimNodeSimpleTransitioner SimpleTransitionerIterator;
    local TgAnimBlendByFireMode FireModeNodeIterator;

    // End:0x33
    if(PoseTransitioner != none)
    {
        PoseTransitioner.StopCustomAnim(0.0000000);
    }
    // End:0xA1
    foreach m_DeviceModeBlendNodes(FireModeNodeIterator)
    {
        // End:0xA0
        if(int(FireModeNodeIterator.m_EquipPoint) == nEquipSlot)
        {
            FireModeNodeIterator.SelectFireMode(nFireMode);
        }        
    }    
    PlayFireAnimation(nEquipSlot, fRefireTime);
    // End:0x166
    if(nEquipSlot == 1)
    {
        // End:0x105
        foreach m_SimpleTransitionerNodes1P(SimpleTransitionerIterator)
        {
            SimpleTransitionerIterator.Fire(0);            
        }        
        // End:0x13E
        foreach m_PawnMeshSimpleTransitionerNodes(SimpleTransitionerIterator)
        {
            SimpleTransitionerIterator.Fire(0);            
        }        
        ClearTimer('AttackComboTimeout');
        SetTimer(1.5000000, false, 'AttackComboTimeout');
    }
    // End:0x1A0
    if(int(m_PlayFireEffectsOn[nEquipSlot]) == int(0))
    {
        PlayFireFx(nEquipSlot, nFireMode);
    }
    //return;    
}

simulated function PlayFireFx(int nEquipSlot, int nFireMode)
{
    // End:0x40
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.PlayFire(nEquipSlot, nFireMode);
    }
    // End:0x80
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.PlayFire(nEquipSlot, nFireMode);
    }
    SetLoopingMuzzleEffects(true, nEquipSlot);
    // End:0xAD
    if(nEquipSlot == 1)
    {
        Play3pFireAimedFX();
    }
    //return;    
}

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime)
{
    local TgAnimNodeFitToDuration DurationNodeIterator;
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x94
    foreach m_FitToDurationNodes(DurationNodeIterator)
    {
        // End:0x93
        if(!DurationNodeIterator.m_bScaleByReload && int(DurationNodeIterator.m_EquipPoint) == nEquipSlot)
        {
            DurationNodeIterator.OverrideDuration = fRefireTime;
        }        
    }    
    // End:0x129
    foreach m_PawnMeshFitToDurationNodes(DurationNodeIterator)
    {
        // End:0x128
        if(!DurationNodeIterator.m_bScaleByReload && int(DurationNodeIterator.m_EquipPoint) == nEquipSlot)
        {
            DurationNodeIterator.OverrideDuration = fRefireTime;
        }        
    }    
    // End:0x175
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnDeviceStartFire(byte(nEquipSlot), fRefireTime);        
    }    
    // End:0x1D2
    if(nEquipSlot != 7)
    {
        // End:0x1D1
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.OnDeviceStartFire(byte(nEquipSlot), fRefireTime);            
        }        
    }
    //return;    
}

simulated function PlayDeviceFiredEffects(int nEquipSlot, float fRefireTime, int nFireMode)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x4B
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnDeviceFire(byte(nEquipSlot), fRefireTime);        
    }    
    // End:0xA8
    if(nEquipSlot != 7)
    {
        // End:0xA7
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.OnDeviceFire(byte(nEquipSlot), fRefireTime);            
        }        
    }
    // End:0xE2
    if(int(m_PlayFireEffectsOn[nEquipSlot]) == int(1))
    {
        PlayFireFx(nEquipSlot, nFireMode);
    }
    //return;    
}

simulated function Play3pFireAimedFX()
{
    local editinline TgSkeletalMeshComponent SkelMesh3P;
    local Vector fireLoc;
    local Rotator FireRot;
    local TgPawn TgP;

    // End:0x0F
    if(IsFirstPerson())
    {
        return;
    }
    TgP = TgPawn(Owner);
    // End:0x3C
    if(TgP == none)
    {
        return;
    }
    SkelMesh3P = TgSkeletalMeshComponent(TgP.Mesh);
    // End:0x7E
    if(SkelMesh3P == none)
    {
        return;
    }
    SkelMesh3P.GetSocketWorldLocationAndRotation('CSO_COG', fireLoc, FireRot);
    FireRot.Yaw = TgP.Rotation.Yaw;
    FireRot.Roll = 0;
    FireRot.Pitch = int(TgP.RemoteViewPitch) << int(8);
    SkelMesh3P.FxSpawnEmitter('FireAimed', 0, fireLoc, Vector(FireRot));
    //return;    
}

simulated function TgSkeletalMeshComponent Get3PWeaponMesh()
{
    return ((m_WeaponMesh3P != none) ? m_WeaponMesh3P : TgSkeletalMeshComponent(TgPawn(Owner).Mesh));
    //return ReturnValue;    
}

simulated function PlayTracerEffects(Vector endLocation, optional int nEquipSlot = 0)
{
    local TgSpecialFx TracerFX;
    local TgProj_Tracer TracerProjectile;
    local Vector fireLoc, FireLocToHitLoc;
    local Rotator FireRot;
    local int I;
    local Emitter TracerBeamEmitter;
    local editinline TgSkeletalMeshComponent SkelMesh3P;
    local TgPlayerController TgPC;
    local bool bConfused, bTracerSpawnFailed;

    bTracerSpawnFailed = false;
    // End:0x471
    if(m_nTracerCounter == 0)
    {
        // End:0x135
        if(IsFirstPerson())
        {
            TracerFX = TgSpecialFx(m_WeaponMesh1P.FxGet('Tracer', 0,,, nEquipSlot));
            // End:0xD3
            if((TracerFX == none) && nEquipSlot == 1)
            {
                TracerFX = TgSpecialFx(m_WeaponMesh1P.FxGet('Tracer', 0));
            }
            // End:0x132
            if(TracerFX != none)
            {
                m_WeaponMesh1P.GetSocketWorldLocationAndRotation(TracerFX.c_nmSocket, fireLoc, FireRot);
            }            
        }
        else
        {
            SkelMesh3P = Get3PWeaponMesh();
            // End:0x25D
            if(SkelMesh3P != none)
            {
                TracerFX = TgSpecialFx(SkelMesh3P.FxGet('Tracer', 0,,, nEquipSlot));
                // End:0x1FE
                if((TracerFX == none) && nEquipSlot == 1)
                {
                    TracerFX = TgSpecialFx(SkelMesh3P.FxGet('Tracer', 0));
                }
                // End:0x25D
                if(TracerFX != none)
                {
                    SkelMesh3P.GetSocketWorldLocationAndRotation(TracerFX.c_nmSocket, fireLoc, FireRot);
                }
            }
        }
        // End:0x465
        if(TracerFX != none)
        {
            TgPC = TgPlayerController(GetALocalPlayerController());
            // End:0x2C8
            if((TgPC != none) && TgPC.IsConfused())
            {
                bConfused = true;
            }
            FireLocToHitLoc = endLocation - fireLoc;
            TracerProjectile = Spawn(Class'TgGame.TgProj_Tracer', Owner,, fireLoc, Rotator(FireLocToHitLoc),, true);
            TracerProjectile.InitTracer(TracerFX, !TgPawn(Owner).IsFriendlyWithLocalPawn(), bConfused);
            TracerProjectile.r_vSpawnLocation = fireLoc;
            TracerProjectile.Instigator = Instigator;
            TracerProjectile.r_fRange = VSize(FireLocToHitLoc);
            TracerProjectile.Velocity = TracerProjectile.Speed * Normal(FireLocToHitLoc);
            TracerProjectile.CompleteInitialization();            
        }
        else
        {
            bTracerSpawnFailed = true;
        }
    }
    // End:0x4A9
    if(!bTracerSpawnFailed)
    {
        m_nTracerCounter++;
        m_nTracerCounter = m_nTracerCounter % m_nTracerFrequency;
    }
    TracerFX = none;
    // End:0x5C9
    if(IsFirstPerson())
    {
        TracerFX = TgSpecialFx(m_WeaponMesh1P.FxGet(m_TracerName, 0,,, nEquipSlot));
        // End:0x567
        if((TracerFX == none) && nEquipSlot == 1)
        {
            TracerFX = TgSpecialFx(m_WeaponMesh1P.FxGet(m_TracerName, 0));
        }
        // End:0x5C6
        if(TracerFX != none)
        {
            m_WeaponMesh1P.GetSocketWorldLocationAndRotation(TracerFX.c_nmSocket, fireLoc, FireRot);
        }        
    }
    else
    {
        SkelMesh3P = Get3PWeaponMesh();
        // End:0x6F1
        if(SkelMesh3P != none)
        {
            TracerFX = TgSpecialFx(SkelMesh3P.FxGet(m_TracerName, 0,,, nEquipSlot));
            // End:0x692
            if((TracerFX == none) && nEquipSlot == 1)
            {
                TracerFX = TgSpecialFx(SkelMesh3P.FxGet(m_TracerName, 0));
            }
            // End:0x6F1
            if(TracerFX != none)
            {
                SkelMesh3P.GetSocketWorldLocationAndRotation(TracerFX.c_nmSocket, fireLoc, FireRot);
            }
        }
    }
    OverrideTracerFireLoc(fireLoc);
    // End:0x8E0
    if(TracerFX != none)
    {
        I = 0;
        J0x71E:

        // End:0x8E0 [Loop If]
        if(I < TracerFX.c_PSCList.Length)
        {
            FireLocToHitLoc = endLocation - fireLoc;
            TracerBeamEmitter = Spawn(Class'TgGame.TgEmitter', Owner,, fireLoc, Rotator(FireLocToHitLoc),, true);
            TracerFX.SetPSCChannels(TracerBeamEmitter.ParticleSystemComponent);
            TracerBeamEmitter.LifeSpan = m_fTracerLifetime;
            TracerBeamEmitter.SetTemplate(TracerFX.c_PSCList[I].c_PSCTemplate, true);
            // End:0x8D2
            if(TracerBeamEmitter.ParticleSystemComponent != none)
            {
                TracerBeamEmitter.ParticleSystemComponent.SetVectorParameter('beamEnd', endLocation);
            }
            I++;
            // [Loop Continue]
            goto J0x71E;
        }
    }
    //return;    
}

simulated function OverrideTracerFireLoc(out Vector fireLoc)
{
    //return;    
}

simulated function QueueInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot)
{
    local QueuedImpactEffect NewQueuedImpactEffect;

    NewQueuedImpactEffect.HitLocation = HitLocation;
    NewQueuedImpactEffect.bSuccessfulHit = bSuccessfulHit;
    NewQueuedImpactEffect.HitActor = HitActor;
    NewQueuedImpactEffect.HitNormal = HitNormal;
    NewQueuedImpactEffect.FireOrigin = FireOrigin;
    NewQueuedImpactEffect.nEquipSlot = nEquipSlot;
    m_QueuedImpactEffects.AddItem(NewQueuedImpactEffect);
    // End:0x169
    if(!IsTimerActive('PlayQueuedInstantHitImpactEffects'))
    {
        SetTimer((Class'PlatformCommon.PComUtilityFunctions'.static.GetGDeltaTime() * WorldInfo.TimeDilation) + 0.0010000, false, 'PlayQueuedInstantHitImpactEffects');
    }
    //return;    
}

simulated function PlayQueuedInstantHitImpactEffects()
{
    local QueuedImpactEffect CurrentImpactEffect;

    // End:0xCB
    foreach m_QueuedImpactEffects(CurrentImpactEffect)
    {
        PlayInstantHitImpactEffects(CurrentImpactEffect.HitLocation, CurrentImpactEffect.bSuccessfulHit, CurrentImpactEffect.HitActor, CurrentImpactEffect.HitNormal, CurrentImpactEffect.FireOrigin, CurrentImpactEffect.nEquipSlot);        
    }    
    m_QueuedImpactEffects.Remove(0, m_QueuedImpactEffects.Length);
    //return;    
}

simulated function GetFiringSocketTransform(out Vector fireLoc, out Rotator FireRot)
{
    local editinline TgSkeletalMeshComponent SkelMesh3P;

    // End:0x4B
    if(IsFirstPerson())
    {
        m_WeaponMesh1P.GetSocketWorldLocationAndRotation('WSO_Emit_01', fireLoc, FireRot);        
    }
    else
    {
        SkelMesh3P = Get3PWeaponMesh();
        // End:0xA9
        if(SkelMesh3P != none)
        {
            SkelMesh3P.GetSocketWorldLocationAndRotation('WSO_Emit_01', fireLoc, FireRot);
        }
    }
    // End:0x132
    if(((fireLoc.X == 0.0000000) && fireLoc.Y == 0.0000000) && fireLoc.Z == 0.0000000)
    {
        fireLoc = Location;
    }
    //return;    
}

simulated function TgSpecialFx GetMeshFx(name nmDisplayGroupName, optional int nEquipSlot = 0)
{
    local editinline TgSkeletalMeshComponent SkelMesh3P;

    // End:0x53
    if(IsFirstPerson())
    {
        return TgSpecialFx(m_WeaponMesh1P.FxGet(nmDisplayGroupName, 0,,, nEquipSlot));        
    }
    else
    {
        SkelMesh3P = Get3PWeaponMesh();
        // End:0xB4
        if(SkelMesh3P != none)
        {
            return TgSpecialFx(SkelMesh3P.FxGet(nmDisplayGroupName, 0,,, nEquipSlot));
        }
    }
    return none;
    //return ReturnValue;    
}

simulated function PlayInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot)
{
    local TgSpecialFx ImpactFx;
    local TgPawn HitPawn;
    local TraceHitInfo HitInfo;

    // End:0x121
    if(bSuccessfulHit)
    {
        HitPawn = TgPawn(HitActor);
        // End:0xC1
        if((HitPawn != none) && HitPawn.IsGod())
        {
            HitPawn.CheckHitInfo(HitInfo, HitPawn.Mesh, Normal(HitLocation - FireOrigin), HitLocation);
        }
        ImpactFx = GetMeshFx(m_HitTargetName, nEquipSlot);
        // End:0x11E
        if(ImpactFx != none)
        {
            ImpactFx.PlaySoundAt(HitLocation);
        }        
    }
    else
    {
        // End:0x1C5
        if(HitActor != none)
        {
            ImpactFx = GetMeshFx(m_HitWallName, nEquipSlot);
            // End:0x1C2
            if(ImpactFx != none)
            {
                ImpactFx.SpawnDecalAt(HitLocation, -HitNormal);
                ImpactFx.PlaySoundAt(HitLocation);
            }            
        }
        else
        {
            ImpactFx = GetMeshFx('ProjectileFizzle', nEquipSlot);
        }
    }
    // End:0x2AB
    if(ImpactFx != none)
    {
        // End:0x278
        if(ImpactFx.c_nFxId == 4491)
        {
            ImpactFx.SpawnEmitter(HitLocation, GetClampedEmitDirection(Normal(FireOrigin - HitLocation), HitNormal));            
        }
        else
        {
            ImpactFx.SpawnEmitter(HitLocation, HitNormal);
        }
    }
    //return;    
}

simulated function Vector GetClampedEmitDirection(Vector vInput, Vector vReflect)
{
    local float fAngle, fMinAngle, fMaxAngle;
    local Vector vReflectOrtho;

    fMinAngle = 0.3420000;
    fMaxAngle = 0.9400000;
    fAngle = vInput Dot vReflect;
    // End:0xC2
    if(fAngle <= fMinAngle)
    {
        vReflectOrtho = Normal(vInput - ((vInput Dot vReflect) * vReflect));
        vInput = Normal((vReflect * fMinAngle) + (vReflectOrtho * fMaxAngle));        
    }
    else
    {
        // End:0x145
        if(fAngle >= fMaxAngle)
        {
            vReflectOrtho = Normal(vInput - ((vInput Dot vReflect) * vReflect));
            vInput = Normal((vReflect * fMaxAngle) + (vReflectOrtho * fMinAngle));
        }
    }
    return -MirrorVectorByNormal(vInput, vReflect);
    //return ReturnValue;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;
    local TgAnimNodeTriggerCameraAnim TriggerCameraAnimNode;

    // End:0x42
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnDeviceStopFire(byte(nEquipSlot));        
    }    
    // End:0x96
    if(nEquipSlot != 7)
    {
        // End:0x95
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.OnDeviceStopFire(byte(nEquipSlot));            
        }        
    }
    // End:0xD8
    foreach m_PawnMeshTriggerCameraAnimNodes(TriggerCameraAnimNode)
    {
        TriggerCameraAnimNode.OnDeviceStopFire(byte(nEquipSlot));        
    }    
    // End:0x11B
    foreach m_TriggerCameraAnimNodes(TriggerCameraAnimNode)
    {
        TriggerCameraAnimNode.OnDeviceStopFire(byte(nEquipSlot));        
    }    
    // End:0x14D
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.StopFire();
    }
    // End:0x17E
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.StopFire();
    }
    SetLoopingMuzzleEffects(false, nEquipSlot);
    //return;    
}

simulated event PlayReload(int nEqpPoint, float ReloadTime, int AmmoRemainingInClip, optional int ReloadType = 0)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;
    local TgAnimNodeFitToDuration FitToDurationNode;
    local TgDeviceForm DeviceForm;
    local TgPawn TgP;

    TgP = TgPawn(Owner);
    // End:0xC2
    if(TgP != none)
    {
        DeviceForm = TgP.c_EquipForm[nEqpPoint];
        // End:0xC2
        if(DeviceForm != none)
        {
            DeviceForm.OnReload(ReloadTime);
            DeviceForm.SetAmmoBlendNodesAmount(AmmoRemainingInClip);
        }
    }
    // End:0x124
    foreach m_FitToDurationNodes(FitToDurationNode)
    {
        // End:0x123
        if(FitToDurationNode.m_bScaleByReload)
        {
            FitToDurationNode.OverrideDuration = ReloadTime;
        }        
    }    
    // End:0x187
    foreach m_PawnMeshFitToDurationNodes(FitToDurationNode)
    {
        // End:0x186
        if(FitToDurationNode.m_bScaleByReload)
        {
            FitToDurationNode.OverrideDuration = ReloadTime;
        }        
    }    
    // End:0x1C8
    foreach m_PawnMeshPaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnReload(ReloadTime);        
    }    
    // End:0x209
    foreach m_PaladinsCharacterNodes(PaladinsCharNode)
    {
        PaladinsCharNode.OnReload(ReloadTime);        
    }    
    //return;    
}

simulated event PlayFlourish()
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    // End:0x47
    if(!m_bFlourishBlocked)
    {
        // End:0x46
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.OnFlourish();            
        }        
    }
    //return;    
}

simulated function BlockFlourish(bool bBlock)
{
    local TgAnimBlendByPaladinsCharacter PaladinsCharNode;

    m_bFlourishBlocked = bBlock;
    // End:0x5A
    if(m_bFlourishBlocked)
    {
        // End:0x59
        foreach m_PaladinsCharacterNodes(PaladinsCharNode)
        {
            PaladinsCharNode.ForceInterruptFlourish();            
        }        
    }
    //return;    
}

simulated function SetFOVZoomed(bool bEnabled)
{
    m_bIsFOVZoomed = bEnabled;
    UpdateReticule();
    //return;    
}

simulated function SetFireLoopDisplayGroup(name FireLoop, name FireLoopTailSound)
{
    // End:0x40
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.super(TgWeaponMeshActor).SetFireLoopDisplayGroup(FireLoop, FireLoopTailSound);
    }
    // End:0x80
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.super(TgWeaponMeshActor).SetFireLoopDisplayGroup(FireLoop, FireLoopTailSound);
    }
    //return;    
}

simulated function ResetFireLoopDisplayGroup()
{
    // End:0x6A
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.SetFireLoopDisplayGroup(m_WeaponMesh1P.default.m_nmFireLoop, m_WeaponMesh1P.default.m_nmFireLoopTailSound);
    }
    // End:0xD4
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.SetFireLoopDisplayGroup(m_WeaponMesh3P.default.m_nmFireLoop, m_WeaponMesh3P.default.m_nmFireLoopTailSound);
    }
    //return;    
}

simulated function AddWeaponLeading(Rotator NewRotation, Rotator OldRotation, float DeltaTime)
{
    local float TargetAimOffset, Delta, RotDiff;

    // End:0xA8
    if(ClockwiseFrom_IntInt(NewRotation.Yaw, OldRotation.Yaw))
    {
        // End:0xA5
        if(OldRotation.Yaw > NewRotation.Yaw)
        {
            OldRotation.Yaw -= 65536;
        }        
    }
    else
    {
        // End:0x108
        if(NewRotation.Yaw > OldRotation.Yaw)
        {
            NewRotation.Yaw -= 65536;
        }
    }
    RotDiff = float(NewRotation.Yaw - OldRotation.Yaw);
    TargetAimOffset = FClamp(RotDiff / m_nMaxWeaponLag.X, -1.0000000, 1.0000000);
    Delta = Abs(TargetAimOffset - m_v2WeaponLagAimOffset.X);
    // End:0x26E
    if((Delta > m_v2WeaponLagSmoothingFactor.X) || TargetAimOffset == 0.0000000)
    {
        m_v2WeaponLagAimOffset.X = FInterpTo(m_v2WeaponLagAimOffset.X, TargetAimOffset, DeltaTime, m_v2WeaponLagInterpSpeed.X);
    }
    // End:0x316
    if(ClockwiseFrom_IntInt(NewRotation.Pitch, OldRotation.Pitch))
    {
        // End:0x313
        if(OldRotation.Pitch > NewRotation.Pitch)
        {
            OldRotation.Pitch -= 65536;
        }        
    }
    else
    {
        // End:0x376
        if(NewRotation.Pitch > OldRotation.Pitch)
        {
            NewRotation.Pitch -= 65536;
        }
    }
    RotDiff = float(NewRotation.Pitch - OldRotation.Pitch);
    TargetAimOffset = FClamp(RotDiff / m_nMaxWeaponLag.Y, -1.0000000, 1.0000000);
    Delta = Abs(TargetAimOffset - m_v2WeaponLagAimOffset.Y);
    // End:0x4DC
    if((Delta > m_v2WeaponLagSmoothingFactor.Y) || TargetAimOffset == 0.0000000)
    {
        m_v2WeaponLagAimOffset.Y = FInterpTo(m_v2WeaponLagAimOffset.Y, TargetAimOffset, DeltaTime, m_v2WeaponLagInterpSpeed.Y);
    }
    //return;    
}

simulated function OnPolymorphChanged(bool bDead)
{
    local TgPawn PawnOwner;
    local bool bShouldBeHidden;

    PawnOwner = TgPawn(Owner);
    // End:0x91
    if((m_WeaponMesh3P != none) && PawnOwner != none)
    {
        bShouldBeHidden = int(PawnOwner.c_LocalPolymorph) > int(0);
        // End:0x87
        if(bShouldBeHidden)
        {
            Hide3PWeaponMesh();            
        }
        else
        {
            Unhide3PWeaponMesh();
        }
    }
    // End:0xC9
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.SetHidden(bDead);
    }
    // End:0x101
    if(m_HandsMesh != none)
    {
        m_HandsMesh.SetHidden(bDead);
    }
    // End:0x139
    if(m_HeadMesh1P != none)
    {
        m_HeadMesh1P.SetHidden(bDead);
    }
    //return;    
}

simulated function NotifyLocalPlayerTeamReceived()
{
    RecalculateMaterial(IsFriendlyWithLocalPawn());
    //return;    
}

// Export UTgWeaponMeshActor::execCacheHitReactionSkelControls(FFrame&, void* const)
native function CacheHitReactionSkelControls();

// Export UTgWeaponMeshActor::execPlayHitReaction(FFrame&, void* const)
native function PlayHitReaction(TgObject.RecoilHitDir Dir, float DamageAmount);

simulated function Hide3PWeaponMesh()
{
    // End:0x50
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.SetParentAnimComponent(none);
        m_WeaponMesh3P.m_bForceHideComponent = true;
    }
    //return;    
}

simulated function Unhide3PWeaponMesh()
{
    local TgPawn PawnOwner;

    // End:0x98
    if(m_WeaponMesh3P != none)
    {
        PawnOwner = TgPawn(Owner);
        // End:0x77
        if(PawnOwner != none)
        {
            m_WeaponMesh3P.SetParentAnimComponent(PawnOwner.Mesh);
        }
        m_WeaponMesh3P.m_bForceHideComponent = false;
    }
    //return;    
}

simulated function PlayMeshTransitionAnimation(WeaponMeshSwapStrategy SwapStrategy, TgObject.TG_EQUIP_POINT eqp, TgDevice PreviousTargetingDevice, TgDevice NextTargetingDevice)
{
    // End:0xA7
    if((SwapStrategy.bPlayPutAway && PreviousTargetingDevice != none) && PreviousTargetingDevice.m_bPlayPutAway)
    {
        PlayPutaway(eqp, NextTargetingDevice.r_nDeviceId, NextTargetingDevice.Class);        
    }
    else
    {
        // End:0x132
        if((NextTargetingDevice != none) && NextTargetingDevice.m_bUseDeviceMeshWhenTargeting)
        {
            SetActiveWeapon(eqp, NextTargetingDevice.r_nDeviceId, NextTargetingDevice.Class, SwapStrategy);
        }
    }
    //return;    
}

defaultproperties
{
    m_WeaponMesh1PClass=Class'TgGame.TgSkeletalMeshComponent_WeaponFirstPerson'
    m_WeaponMesh3PClass=Class'TgGame.TgSkeletalMeshComponent_Weapon'
    m_bShouldLoopingMuzzleTrace=true
    m_bUseSocketForCameraAttach=true
    m_bUseCameraAnims=true
    m_nMaxWeaponLag=(X=483.0000000,Y=262.0000000)
    m_v2WeaponLagInterpSpeed=(X=6.0000000,Y=4.0000000)
    m_v2WeaponLagSmoothingFactor=(X=0.2000000,Y=0.2000000)
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake" class=TgGame.TgCameraShake
        bSingleInstance=true
        OscillationDuration=0.3000000
        OscillationBlendInTime=0.0000000
        OscillationBlendOutTime=0.3000000
        RotOscillation=(Pitch=(Amplitude=10.0000000,Frequency=60.0000000),Yaw=(Amplitude=10.0000000,Frequency=60.0000000),Roll=(Amplitude=50.0000000,Frequency=120.0000000))
    end object
    m_FireCameraShake=CameraShake
    m_nTracerFrequency=1
    m_TracerName="TracerBeam"
    m_fTracerLifetime=1.0000000
    m_HitTargetName="ProjectileExplosionHitTarget"
    m_HitWallName="ProjectileExplosionHitWall"
    m_BeamEmitterEndPointOffset=25.0000000
    m_nBeaconMeshId=5660
    TickGroup=ETickingGroup.TG_PostUpdateWork
}