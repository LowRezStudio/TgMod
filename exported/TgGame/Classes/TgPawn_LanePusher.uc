class TgPawn_LanePusher extends TgPawn_LanePusherBase
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const TG_PROXIMITY_SPEED_MOD_RADIUS = 20.0f;
const TG_PROXIMITY_SPEED_MAGNITUDE = 20.0f;
const TG_PROXIMITY_SPEED_STACK_MAX = 5;

enum EDestroyedAnimStages
{
    EngineDestruction_FullHealth_Idle,// 0
    EngineDestruction_FirstDestruction,// 1
    EngineDestruction_SecondDestruction,// 2
    EngineDestruction_MAX           // 3
};

var private bool m_bInIntroduction;
var bool r_bIsInsideBase;
var bool m_bHarvestTexturesForFadeMIC;
var bool m_bBroadcastDeath;
var TgPawn_LanePusher.EDestroyedAnimStages c_eDestroyedAnimStage;
var transient TgSpecialFx c_BeamFX;
var() float m_fBaseWheelSpeed;
var const int m_nMaxLevel;
var int m_nFriendlyFadeMaterialFXId;
var int m_nEnemyFadeMaterialFXId;
var array<MaterialInstanceConstant> m_FadeMICs;
var float m_fDamageScaleWhileTraveling;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bIsInsideBase;
}

// Export UTgPawn_LanePusher::execSetInitialLevel(FFrame&, void* const)
native function SetInitialLevel();

// Export UTgPawn_LanePusher::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

// Export UTgPawn_LanePusher::execDropHealthNugget(FFrame&, void* const)
native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_LanePusher::execDropHealthNuggetTeamOnly(FFrame&, void* const)
native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_LanePusher::execPawnOnPreDamageMitigation(FFrame&, void* const)
native function PawnOnPreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);

// Export UTgPawn_LanePusher::execReapplyLevelEffectGroups(FFrame&, void* const)
native function ReapplyLevelEffectGroups(optional int nPrevLevel = 0, optional int nCurrentLevel = 0, optional bool bPreserveParams = false);

// Export UTgPawn_LanePusher::execCalcDistanceFadeValue(FFrame&, void* const)
native function CalcDistanceFadeValue(float fDeltaTime);

// Export UTgPawn_LanePusher::execSetSpline(FFrame&, void* const)
native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);

// Export UTgPawn_LanePusher::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_LanePusher::execIsImmuneToDamage(FFrame&, void* const)
native function bool IsImmuneToDamage();

simulated function PostBeginPlay()
{
    super(TgPawn_Biped).PostBeginPlay();
    SetTimer(1.2000000, false, 'IntroTimer');
    //return;    
}

// Export UTgPawn_LanePusher::execInitializeFadeInMaterial(FFrame&, void* const)
native function InitializeFadeInMaterial();

// Export UTgPawn_LanePusher::execUpdateMaterialFade(FFrame&, void* const)
native function UpdateMaterialFade();

simulated function PlayInitialSpawnFX()
{
    super(TgPawn).PlayInitialSpawnFX();
    PlayFullBodyAnim('Deploy', 1.0000000, 0.0000000, 0.1000000, false, true);
    InitializeFadeInMaterial();
    //return;    
}

simulated function IntroTimer()
{
    ClearTimer('IntroTimer');
    m_bInIntroduction = false;
    UpdateMoving();
    // End:0x66
    if((int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || Mesh == none)
    {
        return;
    }
    RecalculateMaterial(IsFriendlyWithLocalPawn(), true);
    //return;    
}

event ModifyHealthProp(int nDamage)
{
    super(TgPawn).ModifyHealthProp(nDamage);
    //return;    
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super(TgPawn).PostInitAnimTree(SkelComp);
    PlayFullBodyAnim('Deploy', 1.0000000, 0.0000000, 0.0000000, false, false);
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local int I;
    local SkelControlWheel Wheel;
    local float Speed;

    super.Tick(DeltaSeconds);
    // End:0x153
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Mesh != none)
    {
        Speed = -Velocity Dot Vector(Rotation);
        // End:0x153
        if(Abs(Speed) > 0.0010000)
        {
            I = 0;
            J0x8F:

            // End:0x153 [Loop If]
            if(I < Mesh.SkelControlTickArray.Length)
            {
                Wheel = SkelControlWheel(Mesh.SkelControlTickArray[I]);
                // End:0x145
                if(Wheel != none)
                {
                    Wheel.WheelRoll += ((m_fBaseWheelSpeed * Speed) * DeltaSeconds);
                }
                I++;
                // [Loop Continue]
                goto J0x8F;
            }
        }
    }
    //return;    
}

simulated event ReceivedPropValues()
{
    super(TgPawn).ReceivedPropValues();
    //return;    
}

simulated function PlayDeathAnimation()
{
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    PlayFullBodyAnim('Death', 1.0000000, 0.0000000, -1.0000000, false, true);
    //return;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local TgGame_Paladins ChaosGame;
    local TgPawn attackerPawn;
    local TgPawn_Character TgP;

    super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    // End:0x8D
    if(ChaosGame == none)
    {
        return;
    }
    attackerPawn = TgPawn(InstigatedBy.Pawn);
    // End:0xCF
    if(attackerPawn == none)
    {
        return;
    }
    TgP = TgPawn_Character(attackerPawn);
    // End:0x131
    if(TgP != none)
    {
        TgP.m_fSiegeDamagePercent += (float(Damage) / (GetMaxHealth()));
    }
    //return;    
}

event int GetHPScalingValue()
{
    return TgGame_PaladinsExtended(WorldInfo.Game).m_nRegLanePusherHPScaling;
    //return ReturnValue;    
}

event int GetPowerScalingValue()
{
    return TgGame_PaladinsExtended(WorldInfo.Game).m_nRegLanePusherPowerScaling;
    //return ReturnValue;    
}

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining)
{
    super(TgPawn).OnDeviceFormStartFire(nEquipSlot, FireDuration, nFireMode, nAmmoRemaining);
    PlayFullBodyAnim('Fire', 1.0000000, 0.0000000, 0.0000000, false, true);
    //return;    
}

simulated event Vector GetWeaponStartTraceLocation(TgDevice Dev)
{
    return (GetPawnViewLocation()) + ((Dev.GetProjectileSpawnOffset() + FireLocationOffsets[int(Dev.r_eEquippedAt)]) >> (GetBaseAimRotation(Dev)));
    //return ReturnValue;    
}

simulated event Destroyed()
{
    ClearFromGRI();
    super(TgPawn).Destroyed();
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local TgPawn_SiegeWall SiegeWall;
    local bool bDied;

    // End:0xC6
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_SiegeWall', SiegeWall)
    {
        // End:0xC5
        if(SiegeWall.GetHealth() < (SiegeWall.GetMaxHealth() / float(2)))
        {
            SiegeWall.SetHealth(int(SiegeWall.GetMaxHealth() / float(2)));
        }        
    }    
    SetPhysics(0);
    bDied = super(TgPawn).Died(Killer, dmgType, HitLocation);
    // End:0x113
    if(bDied)
    {
        ClearFromGRI();
    }
    return bDied;
    //return ReturnValue;    
}

function ClearFromGRI()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x156
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
        // End:0x156
        if(GRI.r_LanePusher == self)
        {
            GRI.r_LanePusher = none;
        }
    }
    //return;    
}

defaultproperties
{
    m_bInIntroduction=true
    m_bBroadcastDeath=true
    m_fBaseWheelSpeed=1.0000000
    m_nMaxLevel=15
    m_nFriendlyFadeMaterialFXId=6511
    m_nEnemyFadeMaterialFXId=6512
    m_fDamageScaleWhileTraveling=0.5000000
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_LanePusher.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_LanePusherBase.CollisionBox'
    begin object name="CollisionBox"
        ReplacementPrimitive=none
    end object
    m_CollisionBox=CollisionBox
    m_fAcceleration=1.5000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_LanePusher.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_LanePusherBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    FireLocationOffsets[1]=(X=130.0000000,Y=4.0000000,Z=20.0000000)
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_LanePusher.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_LanePusherBase.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_LanePusher.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_LanePusherBase.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_LanePusher.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_LanePusherBase.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_LanePusher.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_LanePusherBase.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_LanePusher.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_LanePusher.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_LanePusherBase.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    CollisionComponent=CollisionBox
}