class TgPawn_LanePusherRace extends TgPawn_LanePusherBase
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var const float s_fTotalSplineLength;
var const float s_fPreviousSplineLength;
var const float r_fProgressPercent;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fProgressPercent;
}

// Export UTgPawn_LanePusherRace::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_LanePusherRace::execSetSpline(FFrame&, void* const)
native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);

// Export UTgPawn_LanePusherRace::execIsNonCombat(FFrame&, void* const)
native function bool IsNonCombat();

// Export UTgPawn_LanePusherRace::execUpdateTeamScore(FFrame&, void* const)
native function UpdateTeamScore();

function ClearFromGRI()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x112
    if((GRI != none) && !GRI.bDeleteMe || GRI.IsPendingKill())
    {
        // End:0xCE
        if(GRI.r_LanePusher1 == self)
        {
            GRI.r_LanePusher1 = none;
        }
        // End:0x112
        if(GRI.r_LanePusher2 == self)
        {
            GRI.r_LanePusher2 = none;
        }
    }
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    // End:0x34
    if(super(TgPawn).Died(Killer, dmgType, HitLocation))
    {
        ClearFromGRI();
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event Destroyed()
{
    ClearFromGRI();
    super(TgPawn).Destroyed();
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_LanePusherRace.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_LanePusherBase.CollisionBox'
    begin object name="CollisionBox"
        ReplacementPrimitive=none
    end object
    m_CollisionBox=CollisionBox
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_LanePusherRace.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_LanePusherBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_LanePusherRace.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_LanePusherBase.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_LanePusherRace.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_LanePusherBase.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_LanePusherRace.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_LanePusherBase.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_LanePusherRace.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_LanePusherBase.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_LanePusherRace.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_LanePusherBase.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_LanePusherRace.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_LanePusherBase.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    CollisionComponent=CollisionBox
}