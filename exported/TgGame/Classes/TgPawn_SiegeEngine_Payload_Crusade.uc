class TgPawn_SiegeEngine_Payload_Crusade extends TgPawn_SiegeEngine_Payload
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.CollisionBox'
    begin object name="CollisionBox"
        ReplacementPrimitive=none
    end object
    m_CollisionBox=CollisionBox
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_Payload.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_Payload_Crusade.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_Payload.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    CollisionComponent=CollisionBox
}