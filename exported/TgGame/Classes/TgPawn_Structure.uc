class TgPawn_Structure extends TgPawn
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var float s_fLastDamageTime;
var float s_fDamageNotificationDelay;

// Export UTgPawn_Structure::execCanMove(FFrame&, void* const)
native function bool CanMove();

function SendAttackAlert()
{
    //return;    
}

function SendDeathAlert()
{
    //return;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    // End:0xA8
    if((WorldInfo.TimeSeconds > (s_fLastDamageTime + s_fDamageNotificationDelay)) && !ClassIsChildOf(DamageType, Class'TgGame.TgDamageType_AbilityCost'))
    {
        SendAttackAlert();
    }
    s_fLastDamageTime = WorldInfo.TimeSeconds;
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local bool bReturn;

    // End:0x6B
    if(TgGame_Battle(WorldInfo.Game) != none)
    {
        TgGame_Battle(WorldInfo.Game).StructureDied(self);
    }
    // End:0xA2
    if(TgGame_Battle_Training(WorldInfo.Game) == none)
    {
        SendDeathAlert();
    }
    bReturn = super.Died(Killer, dmgType, HitLocation);
    c_bMeshHiddenDueToDeath = true;
    return bReturn;
    //return ReturnValue;    
}

simulated event PlayDeathAnimation()
{
    super.PlayDeathAnimation();
    c_bMeshHiddenDueToDeath = true;
    //return;    
}

simulated event PostDemoRewind()
{
    super.PostDemoRewind();
    // End:0x27
    if(Health <= 0)
    {
        SetHidden(true);        
    }
    else
    {
        SetHidden(false);
    }
    //return;    
}

function SetMovementPhysics()
{
    SetPhysics(0);
    //return;    
}

state Intro
{
    function IntroTimer()
    {
        GotoState('None');
        //return;        
    }
    stop;    
}

defaultproperties
{
    s_fDamageNotificationDelay=10.0000000
    m_bCannotBeVolumeStealthed=true
    m_bIsVisionBlocker=true
    m_bApplyDistanceFade=false
    m_bCanBeKnockedBack=false
    m_bUseSmoothNetReceiveRotation=false
    c_bApplyDropShadow=false
    m_bBlockCamera=true
    m_bIgnoreTearOffMomentum=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Structure.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn.MyLightEnvironment'
    begin object name="MyLightEnvironment"
        bDynamic=false
        bIsCharacterLightEnvironment=false
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Structure.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Structure.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Structure.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Structure.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    bSimulateGravity=false
    bIgnoreForces=true
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Structure.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
        BlockNonZeroExtent=false
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Structure.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    bPushedByEncroachers=false
    bAlwaysRelevant=true
    CollisionComponent=CollisionCylinder
}