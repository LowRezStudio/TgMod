class TgDeploy_SmokeScreen extends TgDeploy_EffectAura
    native(ChampSkye)
    placeable
    hidecategories(Navigation);

var TgPawn m_CachedPawnOwner;
var bool m_bHasAppliedOwnerStealth;
var repnotify float r_fRadiusForFX;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_fRadiusForFX;
}

// Export UTgDeploy_SmokeScreen::execApplyEffects(FFrame&, void* const)
native function ApplyEffects(Actor Target);

// Export UTgDeploy_SmokeScreen::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(Actor Target);

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_fRadiusForFX')
    {
        ScaleFX();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event ScaleFX()
{
    local array<Object> FxList;
    local TgSpecialFx Fx;
    local editinline ParticleSystemComponent PSC;
    local float fDamageRadius, fDamageRadiusUU;
    local int I, J;

    // End:0x1EF
    if(c_Mesh != none)
    {
        fDamageRadiusUU = r_fRadiusForFX;
        fDamageRadius = fDamageRadiusUU / float(16);
        FxList = c_Mesh.FxGetAll('AlwaysOn', 0);
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
                UpdateDecalScale(Fx, r_fRadiusScale);
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
    r_fRadiusForFX=15.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_SmokeScreen.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectAura.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}