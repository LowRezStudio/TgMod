class TgDeploy_ShieldBarikDome extends TgDeploy_Shield
    native(ChampBarik)
    notplaceable
    hidecategories(Navigation);

simulated event DestroyIt(optional bool bSkipFx)
{
    local TgPawn PawnOwner;
    local TgPawn_Turret turretPawn;
    local int I;

    PawnOwner = TgPawn(Instigator);
    // End:0x125
    if((PawnOwner != none) && r_Owner != none)
    {
        I = PawnOwner.c_ActivePets - 1;
        J0x68:

        // End:0x125 [Loop If]
        if(I >= 0)
        {
            turretPawn = TgPawn_Turret(PawnOwner.s_Pets[I]);
            // End:0x117
            if((turretPawn != none) && turretPawn.m_SpawningDevice == r_Owner)
            {
                PawnOwner.KillPet(turretPawn);
            }
            --I;
            // [Loop Continue]
            goto J0x68;
        }
    }
    super(TgDeployable).DestroyIt(bSkipFx);
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_ShieldBarikDome.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}