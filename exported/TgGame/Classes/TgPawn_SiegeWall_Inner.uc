class TgPawn_SiegeWall_Inner extends TgPawn_SiegeWall
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

// Export UTgPawn_SiegeWall_Inner::execSendAttackAlert(FFrame&, void* const)
native function SendAttackAlert();

simulated function PostBeginPlay()
{
    local TgGame_PaladinsExtended ChaosGame;

    super.PostBeginPlay();
    // End:0xB7
    if(int(Role) == int(ROLE_Authority))
    {
        ChaosGame = TgGame_PaladinsExtended(WorldInfo.Game);
        // End:0xB7
        if(ChaosGame != none)
        {
            ((int(GetTaskForceNumber()) == int(1)) ? ChaosGame.m_TF1InnerWall == self : ChaosGame.m_TF2InnerWall == self);
        }
    }
    //return;    
}

simulated function name GetWallImpactKismetName()
{
    return ((int(GetTaskForceNumber()) == int(1)) ? 'TF1_DoorInner_Hit' : 'TF2_DoorInner_Hit');
    //return ReturnValue;    
}

event int GetHPScalingValue()
{
    return TgGame_PaladinsExtended(WorldInfo.Game).m_nInnerGateHPScaling;
    //return ReturnValue;    
}

event RegisterWithGRI()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x9C
    if(GRI != none)
    {
        // End:0x7A
        if(int(GetTaskForceNumber()) == int(1))
        {
            GRI.r_pSiegeWallTF1[1] = self;            
        }
        else
        {
            GRI.r_pSiegeWallTF2[1] = self;
        }
    }
    //return;    
}

function UnRegisterWithGRI()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x9C
    if(GRI != none)
    {
        // End:0x7A
        if(int(GetTaskForceNumber()) == int(1))
        {
            GRI.r_pSiegeWallTF1[1] = none;            
        }
        else
        {
            GRI.r_pSiegeWallTF2[1] = none;
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgMarkComponent'TgGame.Default__TgPawn_SiegeWall_Inner.TowerDamageScaler'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TowerDamageScaler'
    // Archetype: TgMarkComponent'TgGame.Default__TgPawn_SiegeWall.TowerDamageScaler'
    begin object name="TowerDamageScaler"
    end object
    s_DamageScaler=TowerDamageScaler
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeWall_Inner.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeWall.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeWall_Inner.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeWall.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeWall_Inner.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_SiegeWall.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeWall_Inner.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeWall.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeWall_Inner.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeWall.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeWall_Inner.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_SiegeWall.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeWall_Inner.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeWall.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=TowerDamageScaler
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeWall_Inner.CollisionMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionMesh'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_SiegeWall.CollisionMesh'
    begin object name="CollisionMesh"
        StaticMesh=StaticMesh'NPC_SiegeWall.Mesh.bsp_shape_b'
        ReplacementPrimitive=none
    end object
    Components[8]=CollisionMesh
    CollisionComponent=CollisionMesh
}