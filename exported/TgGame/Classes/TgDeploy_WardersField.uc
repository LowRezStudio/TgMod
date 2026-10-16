class TgDeploy_WardersField extends TgDeploy_EffectField
    native(ChampBarrierTank)
    placeable
    hidecategories(Navigation);

var repnotify float r_fRadiusForFX;
var repnotify float r_fRadiusScaleForDecal;
var repnotify bool r_bEarthenGuardActive;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bEarthenGuardActive, r_fRadiusForFX, 
        r_fRadiusScaleForDecal;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x3D
    if((VarName == 'r_fRadiusForFX') || VarName == 'r_fRadiusScaleForDecal')
    {
        ScaleAbilityFX();        
    }
    else
    {
        // End:0xCB
        if(VarName == 'r_bEarthenGuardActive')
        {
            // End:0xCB
            if(c_Mesh != none)
            {
                // End:0xA0
                if(r_bEarthenGuardActive)
                {
                    c_Mesh.FxActivateGroup('Generic4', 0);                    
                }
                else
                {
                    c_Mesh.FxDeactivateGroup('Generic4', 0);
                }
            }
        }
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

simulated event ScaleAbilityFX()
{
    local array<Object> FxList;
    local TgSpecialFx Fx;
    local editinline ParticleSystemComponent PSC;
    local float fDamageRadius, fDamageRadiusUU;
    local int I, J;

    // End:0x1EF
    if(c_Mesh != none)
    {
        fDamageRadius = r_fRadiusForFX / float(16);
        fDamageRadiusUU = r_fRadiusForFX;
        FxList = c_Mesh.FxGetAll('OnWhenDeployed', 0);
        I = 0;
        J0x7C:

        // End:0x1EF [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x1E1
            if(Fx != none)
            {
                J = 0;
                J0xD4:

                // End:0x1C5 [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x1B7
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                        PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0xD4;
                }
                UpdateDecalScale(Fx, r_fRadiusScaleForDecal);
            }
            I++;
            // [Loop Continue]
            goto J0x7C;
        }
    }
    //return;    
}

defaultproperties
{
    r_fRadiusScaleForDecal=1.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_WardersField.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=56
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_WardersField.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[1]=CollisionCylinder
    bCollideActors=true
    bCollideWorld=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}