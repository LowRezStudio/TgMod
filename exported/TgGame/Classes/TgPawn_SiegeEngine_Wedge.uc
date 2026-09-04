class TgPawn_SiegeEngine_Wedge extends TgPawn_SiegeEngine_CaptureAndPayload
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var int m_nCollisionMeshId;

defaultproperties
{
    m_nCollisionMeshId=5959
    m_bApplySplinePitchToActor=true
    c_bApplySplinePitchToMesh=false
    // Reference: TgStaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.NewCollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'NewCollisionBox'
    begin object name="NewCollisionBox" class=TgGame.TgStaticMeshComponent
        StaticMesh=StaticMesh'GOD_CommonAssets.Meshes.1_unit_Box_Xaxis'
        ReplacementPrimitive=none
        HiddenGame=true
        bSeenByAI=true
    end object
    m_CollisionBox=NewCollisionBox
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_Wedge.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_Wedge.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_CaptureAndPayload.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=NewCollisionBox
    CollisionComponent=NewCollisionBox
}