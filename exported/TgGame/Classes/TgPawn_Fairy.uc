class TgPawn_Fairy extends TgPawn_Character
    native(ChampFairy)
    config(Game)
    hidecategories(Navigation);

var float m_fFairyFlySpeedModifier;
var(Fairy) float m_fFlightAccelerationPerSecond;
var(Fairy) float m_fFlightDecelerationPerSecond;
var(Fairy) float m_fFlightMaxRiseSpeed;
var(Fairy) float m_fAscentDecelerationPerSecond;
var(Fairy) float m_fFaeFlightFriction;
var float m_fPreviousAscentVelocity;
var TgDevice_Flutter m_CachedFlutterDevice;
var TgDevice_FaeFlight m_CachedFaeFlightDevice;

// Export UTgPawn_Fairy::execHasFlutterDevice(FFrame&, void* const)
native function bool HasFlutterDevice();

// Export UTgPawn_Fairy::execHasFaeFlightDevice(FFrame&, void* const)
native function bool HasFaeFlightDevice();

// Export UTgPawn_Fairy::execGetChargeDirection(FFrame&, void* const)
native function Vector GetChargeDirection();

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x51
        case 1:
            return "PC_Fairy_Skin00A.Anims.AS_PC_Fairy_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    m_fFairyFlySpeedModifier=1.0000000
    m_fFlightAccelerationPerSecond=2000.0000000
    m_fFlightDecelerationPerSecond=1500.0000000
    m_fFlightMaxRiseSpeed=500.0000000
    m_fFaeFlightFriction=1.0000000
    m_fMountZoomOverride=1.1000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Fairy.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Fairy.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bEndChargeInFalling=true
    m_bAirAccuracyPenalty=false
    m_sGameplayPackage="Willo"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Fairy.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=0.9000000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Fairy.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Fairy.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Fairy.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Fairy.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=30.0000000
    EyeHeight=30.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Fairy.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Fairy.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}