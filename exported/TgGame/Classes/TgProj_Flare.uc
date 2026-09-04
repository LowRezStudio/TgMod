class TgProj_Flare extends TgProj_FreeGrenade
    native(ChampOwl)
    hidecategories(Navigation);

var bool m_bStartedPulse;
var float m_fLifetimeForPhysicsSubstep;

simulated function StartPulse()
{
    // End:0x0F
    if(m_bStartedPulse)
    {
        return;
    }
    m_bStartedPulse = true;
    PulseVisibility();
    SetTimer(m_fPersistHitPulse, true, 'PulseVisibility');
    SetTimer(m_fPersistTime, false, 'ShutDown');
    //return;    
}

event PostProjectileInitialize()
{
    super(TgProjectile).PostProjectileInitialize();
    StartPulse();
    //return;    
}

simulated function PulseVisibility()
{
    local array<ImpactInfo> ImpactInfoList;
    local AimData Aim;
    local int I;

    // End:0x18D
    if(!m_bHasExploded)
    {
        // End:0x18A
        if(m_OwnerFireMode != none)
        {
            Aim.StartTrace = Location;
            Aim.EndTrace = Location;
            Aim.AimVector = Vector(Rotation);            
            m_OwnerFireMode.CalcAoeFire(self, Aim, ImpactInfoList, false, s_fAoeRewindTime);
            I = 0;
            J0xE2:

            // End:0x18A [Loop If]
            if(I < ImpactInfoList.Length)
            {
                ImpactInfoList[I].Projectile = self;
                m_OwnerFireMode.ApplyHitSpecial(ImpactInfoList[I].HitActor, ImpactInfoList[I]);
                I++;
                // [Loop Continue]
                goto J0xE2;
            }
        }        
    }
    else
    {
        // End:0x1A6
        if(!m_bIsShutDown)
        {
            ShutDown();
        }
    }
    //return;    
}

event bool UseAOE()
{
    return false;
    //return ReturnValue;    
}

// Export UTgProj_Flare::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

defaultproperties
{
    m_bTrackProjectileForTimelapse=true
    m_bRequireAccurateTicksForPrediction=true
    m_fTossZ=0.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Flare.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Flare.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}