class TgPawn_SiegeWall_Base extends TgPawn_SiegeWall
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var bool m_bHasAlertedLowHealth;
var float m_fLowHealthTrigger;

// Export UTgPawn_SiegeWall_Base::execSendAttackAlert(FFrame&, void* const)
native function SendAttackAlert();

// Export UTgPawn_SiegeWall_Base::execSendLowHealthAlert(FFrame&, void* const)
native function SendLowHealthAlert();

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
            ((int(GetTaskForceNumber()) == int(1)) ? ChaosGame.m_TF1BaseObjective == self : ChaosGame.m_TF2BaseObjective == self);
        }
    }
    //return;    
}

simulated function name GetWallImpactKismetName()
{
    return ((int(GetTaskForceNumber()) == int(1)) ? 'TF1_DoorBase_Hit' : 'TF2_DoorBase_Hit');
    //return ReturnValue;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local bool bReturn;

    bReturn = super.Died(Killer, dmgType, HitLocation);
    // End:0x9B
    if(TgGame_Battle(WorldInfo.Game) != none)
    {
        TgGame_Battle(WorldInfo.Game).NexusWasDestroyed(self);
    }
    return bReturn;
    //return ReturnValue;    
}

event int GetHPScalingValue()
{
    return TgGame_PaladinsExtended(WorldInfo.Game).m_nBaseObjectiveHPScaling;
    //return ReturnValue;    
}

event RegisterWithGRI()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x9E
    if(GRI != none)
    {
        // End:0x7B
        if(int(GetTaskForceNumber()) == int(1))
        {
            GRI.r_pSiegeWallTF1[2] = self;            
        }
        else
        {
            GRI.r_pSiegeWallTF2[2] = self;
        }
    }
    //return;    
}

function UnRegisterWithGRI()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x9E
    if(GRI != none)
    {
        // End:0x7B
        if(int(GetTaskForceNumber()) == int(1))
        {
            GRI.r_pSiegeWallTF1[2] = none;            
        }
        else
        {
            GRI.r_pSiegeWallTF2[2] = none;
        }
    }
    //return;    
}

defaultproperties
{
    m_fLowHealthTrigger=40.0000000
    // Reference: TgMarkComponent'TgGame.Default__TgPawn_SiegeWall_Base.TowerDamageScaler'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TowerDamageScaler'
    // Archetype: TgMarkComponent'TgGame.Default__TgPawn_SiegeWall.TowerDamageScaler'
    begin object name="TowerDamageScaler"
    end object
    s_DamageScaler=TowerDamageScaler
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeWall_Base.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeWall.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeWall_Base.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeWall.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeWall_Base.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_SiegeWall.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeWall_Base.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeWall.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeWall_Base.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_SiegeWall.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeWall_Base.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeWall_Base.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeWall.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=TowerDamageScaler
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeWall_Base.CollisionMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionMesh'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_SiegeWall.CollisionMesh'
    begin object name="CollisionMesh"
        StaticMesh=StaticMesh'NPC_SiegeWall.Mesh.bsp_shape_b'
        ReplacementPrimitive=none
    end object
    Components[8]=CollisionMesh
    CollisionComponent=CollisionMesh
    SupportedEvents=/* Array type was not detected. */
}