class TgPawn_Kinessa extends TgPawn_Character
    native(ChampKinessa)
    config(Game)
    hidecategories(Navigation);

const TGPAWN_KINESSA_OVERLAY_FRIEND_FX_ID = 6861;
const TGPAWN_KINESSA_OVERLAY_ENEMY_FX_ID = 6862;

var float m_fPreviousPitchMin;
var float m_fPreviousPitchMax;
var repnotify Vector r_vHyperTargetEndLocation;
var repnotify Vector r_vHyperShotEndLocation;
var bool m_bPendingMovementPenaltyOnLanded;
var bool r_bIsZoomed;
var bool m_bIsInInhandPostFire;
var bool c_bHeadHunterFiring;
var bool r_bTeleportOverlayActive;
var float m_fScopedSpeedModifier;
var float m_fZoomChargeTimestamp;
var float r_fFullChargeDelay;
var float r_fTeleportOverlayMaxStrength;
var float c_fTeleportOverlayStrength;
var float r_fTeleportOverlayUpRate;
var float r_fTeleportOverlayDownRate;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bIsZoomed, r_bTeleportOverlayActive, 
        r_fFullChargeDelay, r_fTeleportOverlayDownRate, 
        r_fTeleportOverlayMaxStrength, r_fTeleportOverlayUpRate, 
        r_vHyperShotEndLocation, r_vHyperTargetEndLocation;
}

// Export UTgPawn_Kinessa::execGetOverlayMaterial(FFrame&, void* const)
native function MaterialInstanceConstant GetOverlayMaterial(TgPawn.OverlayMICType Type);

// Export UTgPawn_Kinessa::execPlayTeleportFx(FFrame&, void* const)
native function PlayTeleportFx(int nTeleportState, Vector vLoc);

simulated function SetHyperTargetLocation(Vector beamEnd)
{
    r_vHyperTargetEndLocation = beamEnd;
    bNetDirty = true;
    // End:0x52
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        PlayHyperTargetEffects();
    }
    //return;    
}

simulated function SetHyperShotLocation(Vector beamEnd)
{
    r_vHyperShotEndLocation = beamEnd;
    bNetDirty = true;
    // End:0x52
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        PlayHyperShotEffects();
    }
    //return;    
}

simulated function ClearHyperShotLocations()
{
    r_vHyperTargetEndLocation.X = 0.0000000;
    r_vHyperTargetEndLocation.Y = 0.0000000;
    r_vHyperTargetEndLocation.Z = 0.0000000;
    r_vHyperShotEndLocation.X = 0.0000000;
    r_vHyperShotEndLocation.Y = 0.0000000;
    r_vHyperShotEndLocation.Z = 0.0000000;
    bNetDirty = true;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x35
    if(VarName == 'r_vHyperTargetEndLocation')
    {
        // End:0x32
        if(!IsZero(r_vHyperTargetEndLocation))
        {
            PlayHyperTargetEffects();
        }        
    }
    else
    {
        // End:0x6A
        if(VarName == 'r_vHyperShotEndLocation')
        {
            // End:0x67
            if(!IsZero(r_vHyperShotEndLocation))
            {
                PlayHyperShotEffects();
            }            
        }
        else
        {
            super.ReplicatedEvent(VarName);
        }
    }
    //return;    
}

simulated function PlayHyperTargetEffects()
{
    local editinline TgSkeletalMeshComponent TgSMC;
    local TgSpecialFx Fx;

    // End:0x11E
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgSMC = TgSkeletalMeshComponent(Mesh);
        // End:0x11E
        if(TgSMC != none)
        {
            Mesh.FxSpawnEmitter('KinessaHyperTargetEmitters', 0, Location, Normal(r_vHyperTargetEndLocation - Location));
            Fx = TgSpecialFx(Mesh.FxGet('KinessaHyperTarget', 0));
            // End:0x11E
            if(Fx != none)
            {
                Fx.UpdateBeamFx(r_vHyperTargetEndLocation, Location);
            }
        }
    }
    //return;    
}

simulated function PlayHyperShotEffects()
{
    local editinline TgSkeletalMeshComponent TgSMC;
    local TgSpecialFx Fx;

    // End:0x11E
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgSMC = TgSkeletalMeshComponent(Mesh);
        // End:0x11E
        if(TgSMC != none)
        {
            Mesh.FxSpawnEmitter('KinessaHyperShotEmitters', 0, Location, Normal(r_vHyperShotEndLocation - Location));
            Fx = TgSpecialFx(Mesh.FxGet('KinessaHyperShot', 0));
            // End:0x11E
            if(Fx != none)
            {
                Fx.UpdateBeamFx(r_vHyperShotEndLocation, Location);
            }
        }
    }
    //return;    
}

simulated function SetZoomState(bool bIsZoomed, float fSpeedModifier, float fChargeDelay)
{
    local TgDevice inhandDevice;

    m_bPendingMovementPenaltyOnLanded = bIsZoomed;
    m_fScopedSpeedModifier = ((fSpeedModifier > 0.0000000) ? fSpeedModifier : 1.0000000);
    // End:0x161
    if(bIsZoomed)
    {
        // End:0xD3
        if(!r_bIsZoomed)
        {
            inhandDevice = GetDeviceByEqPoint(1);
            // End:0xD0
            if((inhandDevice != none) && !inhandDevice.IsFiring())
            {
                m_fZoomChargeTimestamp = WorldInfo.TimeSeconds;
            }            
        }
        else
        {
            m_fZoomChargeTimestamp = WorldInfo.TimeSeconds - ((GetZoomChargePercentage()) * ((fChargeDelay > 0.0000000) ? fChargeDelay : r_fFullChargeDelay));
        }
        r_fFullChargeDelay = ((fChargeDelay > 0.0000000) ? fChargeDelay : r_fFullChargeDelay);
    }
    r_bIsZoomed = bIsZoomed;
    bNetDirty = true;
    //return;    
}

simulated event float GetZoomChargePercentage()
{
    // End:0x63
    if(r_bIsZoomed && r_fFullChargeDelay > 0.0000000)
    {
        return FClamp((WorldInfo.TimeSeconds - m_fZoomChargeTimestamp) / r_fFullChargeDelay, 0.0000000, 1.0000000);
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated function UpdateWeaponZoomEffects(optional float fZoomAmt = 0.0000000)
{
    local TgPlayerController TgPC;

    super.UpdateWeaponZoomEffects(fZoomAmt);
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0xA7
    if((TgPC != none) && TgPC.GetTgPawn() == self)
    {
        TgPC.SetHUDOverlay(((fZoomAmt > 0.0000000) ? 1 : 0));
    }
    //return;    
}

simulated function OnDeviceFormStopFire(int nEquipSlot)
{
    super(TgPawn).OnDeviceFormStopFire(nEquipSlot);
    // End:0x71
    if(nEquipSlot == 1)
    {
        m_bIsInInhandPostFire = false;
        m_fZoomChargeTimestamp = WorldInfo.TimeSeconds;
        // End:0x6E
        if(r_bIsZoomed)
        {
            SetScopeChargeSound(true);
        }        
    }
    else
    {
        // End:0x8C
        if(nEquipSlot == 16)
        {
            SetScopeChargeSound(false);
        }
    }
    //return;    
}

simulated function OnDeviceFormFire(int nEquipSlot, float fRefireTime, int nFireMode)
{
    super(TgPawn).OnDeviceFormFire(nEquipSlot, fRefireTime, nFireMode);
    // End:0x7A
    if(nEquipSlot == 16)
    {
        // End:0x77
        if(!m_bIsInInhandPostFire)
        {
            m_fZoomChargeTimestamp = WorldInfo.TimeSeconds;
            SetScopeChargeSound(true);
        }        
    }
    else
    {
        // End:0xA0
        if(nEquipSlot == 1)
        {
            m_bIsInInhandPostFire = true;
            SetScopeChargeSound(false);
        }
    }
    //return;    
}

simulated function SetScopeChargeSound(bool IsActive)
{
    local TgPlayerController TgPC;
    local array<Object> FxList;
    local int I;
    local TgSpecialFx Fx;
    local name FXName;

    FXName = ((IsActive) ? 'KinessaScopeChargeUpStart' : 'KinessaScopeChargeUpStop');
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x16A
    if(((TgPC != none) && TgPC.GetTgPawn() == self) && Mesh != none)
    {
        FxList = Mesh.FxGetAll(FXName, 0);
        I = 0;
        J0xD0:

        // End:0x16A [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x15C
            if(Fx != none)
            {
                Fx.c_Owner = self;
                Fx.PlaySound();
            }
            I++;
            // [Loop Continue]
            goto J0xD0;
        }
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x48
        case 1:
            return "PC_Kinessa.Anims.AS_PC_Kinessa_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function bool ShouldUseScopeSensitivity()
{
    return r_bIsZoomed;
    //return ReturnValue;    
}

defaultproperties
{
    m_fScopedSpeedModifier=1.0000000
    r_fFullChargeDelay=1.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Kinessa.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Kinessa.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Kinessa"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Kinessa.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Kinessa.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Kinessa.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Kinessa.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Kinessa.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=45.0000000
    EyeHeight=45.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Kinessa.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Kinessa.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}