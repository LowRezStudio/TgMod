class TgProj_Tracer extends TgProjectile
    hidecategories(Navigation);

var export editinline TgParticleSystemComponent PSC;

simulated function InitTracer(TgSpecialFx Fx, bool bIsEnemy, bool bConfused)
{
    PSC = new Class'TgGame.TgParticleSystemComponent';
    PSC.SetTickGroup(5);
    PSC.bAutoActivate = false;
    PSC.SetTemplate(Fx.c_PSCList[0].c_PSCTemplate);
    PSC.m_ParticleChannels.Friendly = !bIsEnemy && !bConfused;
    PSC.m_ParticleChannels.Enemy = bIsEnemy || bConfused;
    AttachComponent(PSC);
    PSC.ActivateSystem();
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    // End:0x3C
    if(!m_bIsShutDown)
    {
        // End:0x3C
        if(!CheckProjectileRange())
        {
            RangeReached();
        }
    }
    //return;    
}

simulated function bool CheckProjectileRange(optional Vector vLocOverride)
{
    local Vector vLoc;

    // End:0x2A
    if(VSizeSq(vLocOverride) > float(0))
    {
        vLoc = vLocOverride;        
    }
    else
    {
        vLoc = Location;
    }
    // End:0x50
    if(r_fRange == float(0))
    {
        return true;
    }
    // End:0x76
    if(VSize(vLoc - r_vSpawnLocation) > r_fRange)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated function ShutDown()
{
    // End:0x2E
    if(PSC != none)
    {
        PSC.DeactivateSystem();
    }
    super.ShutDown();
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Tracer.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProjectile.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Speed=6750.0000000
    MaxSpeed=30000.0000000
    // Reference: CylinderComponent'TgGame.Default__TgProj_Tracer.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProjectile.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
        CollideActors=true
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}