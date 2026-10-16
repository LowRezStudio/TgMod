class TgDeploy_TurretLinked extends TgDeploy_MatchParentFireMode
    native(ChampBarik)
    placeable
    hidecategories(Navigation);

var TgPawn_Turret m_ParentTurret;

simulated function Tick(float DeltaSeconds)
{
    super(TgDeployable).Tick(DeltaSeconds);
    // End:0x5C
    if((m_ParentTurret != none) && int(m_ParentTurret.m_nIsInIntroState) == int(0))
    {
        r_fTimeToDeploySecs = 0.0000000;
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_TurretLinked.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_MatchParentFireMode.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}