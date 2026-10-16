class TgDeploy_BlackHole extends TgDeployable
    native(Deployable)
    placeable
    hidecategories(Navigation);

var repnotify float r_fRadiusScale;
var float m_fMaxPullSpeed;
var float m_fMinPullSpeed;
var float m_fDistanceWithMaxSpeed;
var float m_fEventHorizonDistance;
var float m_fInnerRadius;
var array<Actor> m_ActorsInRange;
var TgPawn m_CachedPawnOwner;
var TgRepInfo_TaskForce m_CachedEnemyTaskForce;
var bool r_bPullActive;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fRadiusScale;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_bPullActive;
}

// Export UTgDeploy_BlackHole::execApplyPullEffects(FFrame&, void* const)
native function ApplyPullEffects(TgPawn Target, float DeltaTime);

simulated event ReplicatedEvent(name VarName)
{
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event ClearAllTouched()
{
    local TgPawn NextPawn;

    J0x00:
    // End:0xAC [Loop If]
    if(m_ActorsInRange.Length > 0)
    {
        NextPawn = TgPawn(m_ActorsInRange[0]);
        // End:0x60
        if(NextPawn != none)
        {
            NextPawn.m_CurrentBlackHoleList.RemoveItem(self);
        }
        // End:0x9C
        if(m_FireMode != none)
        {
            m_FireMode.RemoveHitSpecial(m_ActorsInRange[0], true);
        }
        m_ActorsInRange.Remove(0, 1);
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

simulated event Destroyed()
{
    ClearAllTouched();
    super.Destroyed();
    //return;    
}

defaultproperties
{
    r_fRadiusScale=1.0000000
    m_fMaxPullSpeed=160.0000000
    m_fMinPullSpeed=1.6000000
    m_fDistanceWithMaxSpeed=160.0000000
    m_fEventHorizonDistance=560.0000000
    m_fInnerRadius=20.0000000
    r_bPullActive=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_BlackHole.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}