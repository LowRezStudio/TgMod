class TgDeploy_Transporter extends TgDeployable
    native(ChampKinessa)
    notplaceable
    hidecategories(Navigation);

var Vector m_StartLocation;
var Vector m_ProjectileEndLocation;
var float m_fProjectileHeight;
var TgSpecialFx m_DeploymentFX;
var repnotify Vector r_TeleportLocation;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_TeleportLocation;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x54
    if(VarName == 'r_TeleportLocation')
    {
        m_ProjectileEndLocation = r_TeleportLocation + ((vect(0.0000000, 0.0000000, 1.0000000) * m_fProjectileHeight) * float(16));
        SpawnDeployFX();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event SpawnDeployFX()
{
    local editinline ParticleSystemComponent PSC;
    local int I;

    // End:0x162
    if(c_Mesh != none)
    {
        m_DeploymentFX = TgSpecialFx(c_Mesh.FxGet('Generic1', 0));
        // End:0x162
        if(m_DeploymentFX != none)
        {
            I = 0;
            J0x68:

            // End:0x141 [Loop If]
            if(I < m_DeploymentFX.c_PSCList.Length)
            {
                PSC = m_DeploymentFX.c_PSCList[I].c_PSC;
                // End:0x133
                if(PSC != none)
                {
                    PSC.SetAbsolute(true, true, true);
                    PSC.SetTranslation(m_StartLocation);
                }
                I++;
                // [Loop Continue]
                goto J0x68;
            }
            m_DeploymentFX.Activate();
        }
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local Vector NewLocation;
    local editinline ParticleSystemComponent PSC;
    local int I;

    super.Tick(DeltaSeconds);
    // End:0x13E
    if(!IsZero(m_ProjectileEndLocation))
    {
        NewLocation = m_StartLocation;
        NewLocation += ((m_ProjectileEndLocation - m_StartLocation) * m_fCurrentDeployPercentage);
        SetLocation(NewLocation);
        // End:0x13E
        if(m_DeploymentFX != none)
        {
            I = 0;
            J0x87:

            // End:0x13E [Loop If]
            if(I < m_DeploymentFX.c_PSCList.Length)
            {
                PSC = m_DeploymentFX.c_PSCList[I].c_PSC;
                // End:0x130
                if(PSC != none)
                {
                    PSC.SetTranslation(NewLocation);
                }
                I++;
                // [Loop Continue]
                goto J0x87;
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_fProjectileHeight=7.5000000
    m_bFireOnDeploy=false
    m_bAdjustMeshToGround=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Transporter.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_Transporter.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[1]=CollisionCylinder
    bCollideActors=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}