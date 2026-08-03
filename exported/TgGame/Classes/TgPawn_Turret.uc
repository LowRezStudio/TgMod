class TgPawn_Turret extends TgPawn_Pet
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var repnotify bool r_bLockdownIsOn;
var repnotify bool r_bHasHealingStation;
var bool m_bFirstAidNuggetOverride;
var int m_nLockdownPostureID;
var TgDevice m_SpawningDevice;
var AkEvent m_TargetingNotificationAkEvent;
var Actor m_PrevTargetActor;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasHealingStation, r_bLockdownIsOn;
}

// Export UTgPawn_Turret::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_Turret::execDropHealthNuggetTeamOnly(FFrame&, void* const)
native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_Turret::execToggleLockdownMode(FFrame&, void* const)
native function ToggleLockdownMode(bool bSetActive);

// Export UTgPawn_Turret::execToggleLockdownFX(FFrame&, void* const)
native function ToggleLockdownFX();

// Export UTgPawn_Turret::execToggleHealingStationFX(FFrame&, void* const)
native function ToggleHealingStationFX();

// Export UTgPawn_Turret::execSetTargetActor(FFrame&, void* const)
native function SetTargetActor(Actor Target);

// Export UTgPawn_Turret::execPlayTargetingSound(FFrame&, void* const)
native function PlayTargetingSound();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x24
    if(VarName == 'r_bLockdownIsOn')
    {
        ToggleLockdownFX();        
    }
    else
    {
        // End:0x48
        if(VarName == 'r_bHasHealingStation')
        {
            ToggleHealingStationFX();            
        }
        else
        {
            // End:0x69
            if(VarName == 'r_TargetActor')
            {
                PlayTargetingSound();
            }
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function PlayDeathAnimation()
{
    super.PlayDeathAnimation();
    c_bMeshHiddenDueToDeath = false;
    //return;    
}

simulated function RagdollPawn()
{
    local Vector turretImpulseDirection, turretVerticalImpulse;
    local float turretHorizontalImpulseScale;

    Mesh.MinDistFactorForKinematicUpdate = 0.0000000;
    InitRagdoll();
    // End:0x11E
    if(!IsZero(r_DeathInfo.Momentum))
    {
        turretImpulseDirection = r_DeathInfo.Momentum;
        turretImpulseDirection.Z = 0.0000000;
        turretImpulseDirection = Normal(turretImpulseDirection);
        turretVerticalImpulse = vect(0.0000000, 0.0000000, 200.0000000);
        turretHorizontalImpulseScale = 300.0000000;
        Mesh.AddImpulse((turretImpulseDirection * turretHorizontalImpulseScale) + turretVerticalImpulse, Location);
    }
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    // End:0x35
    if(super(TgPawn).Died(Killer, dmgType, HitLocation))
    {
        ToggleLockdownMode(false);
        return true;
    }
    return false;
    //return ReturnValue;    
}

state Intro
{
    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0x4D
        if(Mesh != none)
        {
            Mesh.FxDeactivateGroup('Spawned', 0);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_TURRET
    m_bUseSilhouettes=true
    m_bWaitForIntroAnimToEnd=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Turret.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Pet.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    FireLocationOffsets[1]=(X=32.0000000,Y=0.0000000,Z=32.0000000)
    m_fMaxAimAssistStacks=0.1000000
    m_nInitHUDOverlayDisplayMask=105
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Turret.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Pet.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Turret.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Pet.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Turret.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Pet.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Turret.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Pet.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    r_fIntroTime=5.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Turret.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Pet.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Turret.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Pet.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    CollisionComponent=CollisionCylinder
}