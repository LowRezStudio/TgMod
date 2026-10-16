class TgProj_IceStorm extends TgProj_Simulated
    hidecategories(Navigation);

var bool m_bStopped;
var bool m_bCheckLOSForHit;

simulated function CompleteInitialization()
{
    local float fTickDuration;

    super.CompleteInitialization();
    // End:0x6D
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x6D
        if(m_OwnerFireMode != none)
        {
            fTickDuration = m_OwnerFireMode.GetPersistPulse();
            SetTimer(fTickDuration, true, 'HandleTick');
        }
    }
    //return;    
}

function HandleTick()
{
    local Actor nextTarget;
    local int I;
    local bool hitValid;
    local Vector blockingLocation;

    I = m_PassThroughTargets.Length - 1;
    J0x17:

    // End:0x13A [Loop If]
    if(I >= 0)
    {
        nextTarget = m_PassThroughTargets[I];
        hitValid = true;
        // End:0x12C
        if(nextTarget != none)
        {
            // End:0xC2
            if(m_bCheckLOSForHit)
            {
                TraceWorldPhysicalGeometry(Location, nextTarget.Location, blockingLocation);
                // End:0xC2
                if(!IsZero(blockingLocation))
                {
                    hitValid = false;
                }
            }
            // End:0x12C
            if(hitValid)
            {
                ApplyHit(nextTarget, nextTarget.Location, Normal(nextTarget.Location - Location));
            }
        }
        I--;
        // [Loop Continue]
        goto J0x17;
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local Rotator rRotation;

    super.Tick(DeltaSeconds);
    // End:0x72
    if(Rotation.Pitch != 0)
    {
        rRotation = Rotation;
        rRotation.Pitch = 0;
        SetRotation(rRotation);
    }
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x84
    if(!m_bStopped && (Target != none) || ImpactedActor != none)
    {
        m_bStopped = true;
        LifeSpan = GetRemainingTime();
        SetLocation(HitLocation - Normal(Velocity));
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);        
    }
    else
    {
        super.ExplodeOnTarget(Target, HitLocation, HitNormal);
    }
    //return;    
}

simulated function float GetRemainingTime()
{
    local float fRangeRemaining, fSpeed;

    // End:0x15
    if(!m_bIsInitialized)
    {
        return 0.0000000;
    }
    fRangeRemaining = float(Max(0, int(r_fRange - VSize(Location - r_vSpawnLocation))));
    fSpeed = VSize(Velocity);
    // End:0x73
    if(fSpeed == float(0))
    {
        return 0.0000000;
    }
    return fRangeRemaining / fSpeed;
    //return ReturnValue;    
}

defaultproperties
{
    m_bCheckLOSForHit=true
    m_bTrackProjectileForTimelapse=true
    m_bCanSpawnOnClientFirst=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_IceStorm.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bPassThroughShields=true,bPassThroughBlocker=true,bHitAndPassThrough=true,bHitOnTick=true,bOnlyHitOnceOnPassThrough=false)
    // Reference: CylinderComponent'TgGame.Default__TgProj_IceStorm.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}