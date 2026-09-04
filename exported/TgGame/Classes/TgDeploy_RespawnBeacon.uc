class TgDeploy_RespawnBeacon extends TgDeployable
    notplaceable
    hidecategories(Navigation);

simulated function DeployComplete()
{
    local TgDevice_RespawnBeacon spawningDev;

    super.DeployComplete();
    // End:0xD3
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xC8
        if(s_SpawnerDeviceMode != none)
        {
            spawningDev = TgDevice_RespawnBeacon(s_SpawnerDeviceMode.m_Owner);
            // End:0xC8
            if((spawningDev != none) && spawningDev.s_BeaconExit != none)
            {
                spawningDev.s_BeaconExit.PlaceFromDeploy(self);
            }
        }
        DestroyIt();
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_RespawnBeacon.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}