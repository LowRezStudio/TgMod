class TgPawn_SiegeEngine_CaptureAndPayload extends TgPawn_SiegeEngine_Payload
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var private const float r_fMinimumPayloadTravelTime;
var private const float r_fTravelSpeedScaleBeforeBase;
var private const TgObject.ELanePusherActionPoint r_eSpeedScaledTravelPoint;
var private const bool r_bIsPassedSpeedScaledTravelPoint;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fTravelSpeedScaleBeforeBase;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_bIsPassedSpeedScaledTravelPoint, r_eSpeedScaledTravelPoint, 
        r_fMinimumPayloadTravelTime;
}

// Export UTgPawn_SiegeEngine_CaptureAndPayload::execSetSpline(FFrame&, void* const)
native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);

defaultproperties
{
    r_fTravelSpeedScaleBeforeBase=1.0000000
    r_eSpeedScaledTravelPoint=ELanePusherActionPoint.LPAP_Checkpoint1
    r_bIsPassedSpeedScaledTravelPoint=true
    m_bHarvestTexturesForFadeMIC=true
    m_nFriendlyFadeMaterialFXId=6951
    m_nEnemyFadeMaterialFXId=6952
    s_bStopBackpeddlingAtCheckpoints=false
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.CollisionBox'
    begin object name="CollisionBox"
        ReplacementPrimitive=none
    end object
    m_CollisionBox=CollisionBox
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_Payload.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    CollisionComponent=CollisionBox
}