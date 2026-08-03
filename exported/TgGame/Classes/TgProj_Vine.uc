class TgProj_Vine extends TgProj_Simulated
    hidecategories(Navigation);

var TgDeviceForm_Vine m_VineForm;

simulated event SpawnFlightEffects()
{
    local TgPawn TgP;
    local int I;

    super(TgProjectile).SpawnFlightEffects();
    TgP = TgPawn(Instigator);
    // End:0xE0
    if(TgP != none)
    {
        I = 0;
        J0x40:

        // End:0xE0 [Loop If]
        if(I < 33)
        {
            m_VineForm = TgDeviceForm_Vine(TgP.c_EquipForm[I]);
            // End:0xD2
            if(m_VineForm != none)
            {
                m_VineForm.ConnectBeamToTarget(self, self.Location);
                return;
            }
            I++;
            // [Loop Continue]
            goto J0x40;
        }
    }
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x2B
    if(!m_bHasExploded)
    {
        StartPull(Target, HitLocation);
    }
    super.ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

simulated event Fizzle()
{
    // End:0x23
    if(!m_bHasExploded)
    {
        StartPull(none, Location);
    }
    super.Fizzle();
    //return;    
}

simulated function StartPull(Actor Target, Vector HitLocation)
{
    local TgPawn TgP;
    local TgDevice_Vine vineDev;
    local int I;

    TgP = TgPawn(Instigator);
    // End:0x14B
    if(TgP != none)
    {
        // End:0x14B
        if(int(WorldInfo.NetMode) != int(NM_Client))
        {
            I = 0;
            J0x5F:

            // End:0x14B [Loop If]
            if(I < 33)
            {
                vineDev = TgDevice_Vine(TgP.m_EquippedDevices[I]);
                // End:0x13D
                if(vineDev != none)
                {
                    // End:0x11E
                    if((Target != none) || (ImpactedActor != none) && ImpactedActor != self)
                    {
                        vineDev.PullToTarget(Target, HitLocation);                        
                    }
                    else
                    {
                        vineDev.MissPull();
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x5F;
            }
        }
    }
    // End:0x1DE
    if(m_VineForm != none)
    {
        // End:0x1BF
        if((Target != none) || (ImpactedActor != none) && ImpactedActor != self)
        {
            m_VineForm.ConnectBeamToTarget(Target, HitLocation);            
        }
        else
        {
            m_VineForm.DisconnectBeam();
        }
    }
    //return;    
}

defaultproperties
{
    m_bCanSpawnOnClientFirst=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Vine.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bPassThroughFriends=false,bPassThroughEnemies=true)
    // Reference: CylinderComponent'TgGame.Default__TgProj_Vine.CollisionCylinder'
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