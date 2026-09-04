class TgDeploy_HealingTotem extends TgDeployable
    native(ChampGrohk)
    placeable
    hidecategories(Navigation);

var repnotify float r_fRadiusScale;
var repnotify bool r_bHasHealingRain;
var repnotify bool r_bHasWindTotem;
var repnotify float r_fMonolithReduction;
var TgPawn m_CachedPawnOwner;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasHealingRain, r_bHasWindTotem, 
        r_fMonolithReduction, r_fRadiusScale;
}

// Export UTgDeploy_HealingTotem::execAdjustHeal(FFrame&, void* const)
native function AdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);

// Export UTgDeploy_HealingTotem::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

// Export UTgDeploy_HealingTotem::execToggleHealingRainFX(FFrame&, void* const)
native function ToggleHealingRainFX();

// Export UTgDeploy_HealingTotem::execToggleWindTotemFX(FFrame&, void* const)
native function ToggleWindTotemFX();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x24
    if(VarName == 'r_bHasHealingRain')
    {
        ToggleHealingRainFX();        
    }
    else
    {
        // End:0x48
        if(VarName == 'r_bHasWindTotem')
        {
            ToggleWindTotemFX();            
        }
        else
        {
            // End:0x69
            if(VarName == 'r_fRadiusScale')
            {
                ScaleAbilityFX();
            }
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

event ScaleAbilityRadius()
{
    local TgProperty EffectRadiusProperty;
    local float EffectRadius;

    // End:0xCE
    if((m_FireMode != none) && r_fRadiusScale > 0.0000000)
    {
        EffectRadiusProperty = m_FireMode.GetProperty(6);
        // End:0xCE
        if(EffectRadiusProperty != none)
        {
            EffectRadius = EffectRadiusProperty.m_fBase * r_fRadiusScale;
            // End:0xCE
            if(EffectRadius > 0.0000000)
            {
                m_FireMode.SetProperty(6, EffectRadius);
            }
        }
    }
    //return;    
}

simulated event ScaleAbilityFX()
{
    local array<Object> FxList;
    local TgSpecialFx Fx;
    local editinline ParticleSystemComponent PSC;
    local TgProperty EffectRadiusProperty;
    local float fDamageRadius, fDamageRadiusUU;
    local int I, J;

    // End:0x79F
    if(c_Mesh != none)
    {
        fDamageRadius = 0.0000000;
        fDamageRadiusUU = 0.0000000;
        // End:0xC2
        if(m_FireMode != none)
        {
            EffectRadiusProperty = m_FireMode.GetProperty(6);
            // End:0xC2
            if(EffectRadiusProperty != none)
            {
                fDamageRadius = EffectRadiusProperty.m_fBase * r_fRadiusScale;
                fDamageRadiusUU = fDamageRadius * float(16);
            }
        }
        FxList = c_Mesh.FxGetAll('AlwaysOn', 0);
        I = 0;
        J0x103:

        // End:0x276 [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x268
            if(Fx != none)
            {
                J = 0;
                J0x15B:

                // End:0x24C [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x23E
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                        PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x15B;
                }
                UpdateDecalScale(Fx, r_fRadiusScale);
            }
            I++;
            // [Loop Continue]
            goto J0x103;
        }
        FxList = c_Mesh.FxGetAll('OnWhenDeployed', 0);
        I = 0;
        J0x2B7:

        // End:0x42A [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x41C
            if(Fx != none)
            {
                J = 0;
                J0x30F:

                // End:0x400 [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x3F2
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                        PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x30F;
                }
                UpdateDecalScale(Fx, r_fRadiusScale);
            }
            I++;
            // [Loop Continue]
            goto J0x2B7;
        }
        FxList = c_Mesh.FxGetAll('Destroyed', 0);
        I = 0;
        J0x46B:

        // End:0x5DE [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x5D0
            if(Fx != none)
            {
                J = 0;
                J0x4C3:

                // End:0x5B4 [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x5A6
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                        PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x4C3;
                }
                UpdateDecalScale(Fx, r_fRadiusScale);
            }
            I++;
            // [Loop Continue]
            goto J0x46B;
        }
        // End:0x79F
        if(r_bHasWindTotem)
        {
            FxList = c_Mesh.FxGetAll('Totem_WindTotem', 0);
            I = 0;
            J0x62C:

            // End:0x79F [Loop If]
            if(I < FxList.Length)
            {
                Fx = TgSpecialFx(FxList[I]);
                // End:0x775
                if(Fx != none)
                {
                    J = 0;
                    J0x684:

                    // End:0x775 [Loop If]
                    if(J < Fx.c_PSCList.Length)
                    {
                        PSC = Fx.c_PSCList[J].c_PSC;
                        // End:0x767
                        if(PSC != none)
                        {
                            PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                            PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                        }
                        J++;
                        // [Loop Continue]
                        goto J0x684;
                    }
                }
                UpdateDecalScale(Fx, r_fRadiusScale);
                I++;
                // [Loop Continue]
                goto J0x62C;
            }
        }
    }
    //return;    
}

defaultproperties
{
    r_fRadiusScale=1.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_HealingTotem.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=56
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_HealingTotem.CollisionCylinder'
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