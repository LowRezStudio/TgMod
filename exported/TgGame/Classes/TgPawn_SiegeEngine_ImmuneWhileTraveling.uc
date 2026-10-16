class TgPawn_SiegeEngine_ImmuneWhileTraveling extends TgPawn_Juggernaut
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    m_fDamageScaleWhileTraveling=0.0000000
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_Juggernaut.CollisionBox'
    begin object name="CollisionBox"
        ReplacementPrimitive=none
    end object
    m_CollisionBox=CollisionBox
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Juggernaut.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Juggernaut.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Juggernaut.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Juggernaut.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Juggernaut.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Juggernaut.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeEngine_ImmuneWhileTraveling.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Juggernaut.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    CollisionComponent=CollisionBox
}