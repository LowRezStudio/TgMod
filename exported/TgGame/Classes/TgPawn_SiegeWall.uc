class TgPawn_SiegeWall extends TgPawn_Tower
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var() float m_fImpactEffectXRange;
var() float m_fImpactEffectYRange;
var Vector r_vNextImpactEffectLocation;
var() float m_fImpactRecoveryTime;
var float m_fRemainingImpactRecoveryTime;
var() float m_fMaxImpactSize;
var MaterialInstanceConstant m_ImpactMIC;
var bool c_bIsVulnerable;
var bool m_bHasRegisteredObstacle;
var bool m_bSpawnedThisFrame;
var bool m_bQueriedBorderEdges;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_vNextImpactEffectLocation;
}

// Export UTgPawn_SiegeWall::execIsDebuffImmune(FFrame&, void* const)
native function bool IsDebuffImmune();

// Export UTgPawn_SiegeWall::execGenerateNewImpactEffectLocation(FFrame&, void* const)
native function GenerateNewImpactEffectLocation();

// Export UTgPawn_SiegeWall::execPlaySpecialEffectEvent(FFrame&, void* const)
native function PlaySpecialEffectEvent(int PlaySpecialEffectIndex, Vector vLoc, Vector vHitNormal, optional Actor inActor);

// Export UTgPawn_SiegeWall::execSendAttackAlert(FFrame&, void* const)
native function SendAttackAlert();

// Export UTgPawn_SiegeWall::execSendDeathAlert(FFrame&, void* const)
native function SendDeathAlert();

// Export UTgPawn_SiegeWall::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_SiegeWall::execRegisterObstacle(FFrame&, void* const)
native function RegisterObstacle();

// Export UTgPawn_SiegeWall::execUnRegisterObstacle(FFrame&, void* const)
native function UnRegisterObstacle();

// Export UTgPawn_SiegeWall::execApplyPawnSetup(FFrame&, void* const)
native function bool ApplyPawnSetup();

// Export UTgPawn_SiegeWall::execIsVulnerable(FFrame&, void* const)
native final function bool IsVulnerable();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    GenerateNewImpactEffectLocation();
    // End:0x3C
    if(int(Role) == int(ROLE_Authority))
    {
        RegisterWithGRI();
        RegisterObstacle();
    }
    //return;    
}

event RegisterWithGRI()
{
    //return;    
}

function UnRegisterWithGRI()
{
    //return;    
}

simulated function name GetWallImpactKismetName()
{
    return 'None';
    //return ReturnValue;    
}

simulated event PlayWallImpact()
{
    local AnimNodePlayCustomAnim CustomAnimNode;
    local GameSkelCtrl_Recoil RecoilControl;
    local int I;

    // End:0x13F
    if(Mesh != none)
    {
        CustomAnimNode = AnimNodePlayCustomAnim(Mesh.FindAnimNode('CustomAnim'));
        // End:0x8E
        if(CustomAnimNode != none)
        {
            CustomAnimNode.PlayCustomAnim('Impact', 1.0000000, 0.0000000);
        }
        I = 0;
        J0x99:

        // End:0x13F [Loop If]
        if(I < Mesh.SkelControlTickArray.Length)
        {
            RecoilControl = GameSkelCtrl_Recoil(Mesh.SkelControlTickArray[I]);
            // End:0x131
            if(RecoilControl != none)
            {
                RecoilControl.bPlayRecoil = true;
            }
            I++;
            // [Loop Continue]
            goto J0x99;
        }
    }
    //return;    
}

event int GetHPScalingValue()
{
    return 0;
    //return ReturnValue;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local TgPawn KillerPawn;

    UnRegisterWithGRI();
    UnRegisterObstacle();
    // End:0x85
    if(Killer != none)
    {
        KillerPawn = TgPawn(Killer.Pawn);
        // End:0x85
        if(KillerPawn != none)
        {
            KillerPawn.PlayEmoteAtWorldLocation(22);
        }
    }
    return super.Died(Killer, dmgType, HitLocation);
    //return ReturnValue;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local TgPawn_Character TgP;

    super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    TgP = TgPawn_Character(InstigatedBy.Pawn);
    // End:0xC2
    if(TgP != none)
    {
        TgP.m_fWallDamagePercent += (float(Damage) / (GetMaxHealth()));
    }
    //return;    
}

defaultproperties
{
    m_fImpactEffectXRange=150.0000000
    m_fImpactEffectYRange=75.0000000
    m_fImpactRecoveryTime=0.5000000
    m_fMaxImpactSize=100.0000000
    // Reference: TgMarkComponent'TgGame.Default__TgPawn_SiegeWall.TowerDamageScaler'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TowerDamageScaler'
    // Archetype: TgMarkComponent'TgGame.Default__TgPawn_Tower.TowerDamageScaler'
    begin object name="TowerDamageScaler"
    end object
    s_DamageScaler=TowerDamageScaler
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_SiegeWall.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Tower.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_SiegeWall.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Tower.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_SiegeWall.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Tower.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeWall.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Tower.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_SiegeWall.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Tower.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fHUDOverlayZOffset=-200.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_SiegeWall.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Tower.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_SiegeWall.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Tower.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=TowerDamageScaler
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_SiegeWall.CollisionMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionMesh'
    begin object name="CollisionMesh" class=Engine.StaticMeshComponent
        StaticMesh=StaticMesh'NPC_SiegeWall.Mesh.bsp_shape_a'
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        HiddenGame=true
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true)
        Rotation=(Pitch=0,Yaw=16384,Roll=0)
    end object
    Components[8]=CollisionMesh
    bCanBeFrictionedTo=false
    CollisionComponent=CollisionMesh
}