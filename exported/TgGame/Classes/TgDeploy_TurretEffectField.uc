class TgDeploy_TurretEffectField extends TgDeploy_EffectField
    native(ChampBarik)
    placeable
    hidecategories(Navigation);

var array<Actor> m_DeployTimePendingTargets;
var TgPawn_Turret m_ParentTurret;

function TouchAllPendingTargets()
{
    local ImpactInfo Impact;
    local Actor nextTarget;

    J0x00:
    // End:0x151 [Loop If]
    if(m_DeployTimePendingTargets.Length > 0)
    {
        nextTarget = m_DeployTimePendingTargets[0];
        m_DeployTimePendingTargets.RemoveItem(nextTarget);
        // End:0x14E
        if(m_TouchingPawns.Find(nextTarget) == -1)
        {
            // End:0x14E
            if((m_FireMode != none) && m_FireMode.IsValidTarget(nextTarget))
            {
                Impact.bDirectHit = true;
                Impact.DeviceModeReference = m_FireMode;
                Impact.HitActor = nextTarget;
                m_FireMode.ApplyHitSpecial(nextTarget, Impact);
                m_TouchingPawns.AddItem(nextTarget);
            }
        }
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x25
    if(m_bInDestroyedState || int(Role) != int(ROLE_Authority))
    {
        return;
    }
    // End:0x90
    if((m_ParentTurret != none) && int(m_ParentTurret.m_nIsInIntroState) == int(0))
    {
        super.OnProxyTouch(Other, OtherComp, HitLocation, HitNormal);        
    }
    else
    {
        // End:0x127
        if((m_TouchingPawns.Find(Other) == -1) && m_DeployTimePendingTargets.Find(Other) == -1)
        {
            // End:0x127
            if((m_FireMode != none) && m_FireMode.IsValidTarget(Other))
            {
                m_DeployTimePendingTargets.AddItem(Other);
            }
        }
    }
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    // End:0x16
    if(int(Role) != int(ROLE_Authority))
    {
        return;
    }
    // End:0x66
    if((m_ParentTurret != none) && int(m_ParentTurret.m_nIsInIntroState) == int(0))
    {
        super.OnProxyUnTouch(Other);        
    }
    else
    {
        // End:0x9C
        if(m_DeployTimePendingTargets.Find(Other) != -1)
        {
            m_DeployTimePendingTargets.RemoveItem(Other);
        }
        // End:0x10C
        if(m_TouchingPawns.Find(Other) != -1)
        {
            // End:0xF6
            if(m_FireMode != none)
            {
                m_FireMode.RemoveHitSpecial(Other, true);
            }
            m_TouchingPawns.RemoveItem(Other);
        }
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super(TgDeployable).Tick(DeltaSeconds);
    // End:0x89
    if((m_ParentTurret != none) && int(m_ParentTurret.m_nIsInIntroState) == int(0))
    {
        // End:0x6F
        if(r_fTimeToDeploySecs > 0.0000000)
        {
            r_fTimeToDeploySecs = 0.0000000;
        }
        // End:0x89
        if(m_DeployTimePendingTargets.Length > 0)
        {
            TouchAllPendingTargets();
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_TurretEffectField.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}