class TgDeploy_Explosion extends TgDeploy_EffectAura
    native(Deployable)
    placeable
    hidecategories(Navigation);

simulated event DestroyIt(optional bool bSkipFx)
{
    local int I;
    local ImpactInfo Impact;

    // End:0x10
    if(m_bInDestroyedState)
    {
        return;
    }
    // End:0xF6
    if(m_FireMode != none)
    {
        I = 0;
        J0x2A:

        // End:0xF6 [Loop If]
        if(I < m_AffectedActors.Length)
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = m_FireMode;
            Impact.HitActor = m_AffectedActors[I];
            m_FireMode.ApplyHit(Impact, Instigator);
            ++I;
            // [Loop Continue]
            goto J0x2A;
        }
    }
    super.DestroyIt(true);
    // End:0x1A5
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x1A2
        if(!bSkipFx && c_Mesh != none)
        {
            c_Mesh.FxActivateGroup('Destroyed', 0);
            c_Mesh.FxDeactivateGroup('OnWhenDeployed', 0);
        }        
    }
    else
    {
        r_nReplicateDestroyIt = ((bSkipFx) ? 2 : 1);
    }
    //return;    
}

simulated event ScaleFX()
{
    local array<Object> FxList;
    local TgSpecialFx Fx;
    local editinline ParticleSystemComponent PSC;
    local TgProperty EffectRadiusProperty;
    local float fDamageRadius, fDamageRadiusUU;
    local int I, J;

    // End:0x5D5
    if((c_Mesh != none) && m_FireMode != none)
    {
        EffectRadiusProperty = m_FireMode.GetProperty(6);
        // End:0x5D5
        if(EffectRadiusProperty != none)
        {
            fDamageRadius = EffectRadiusProperty.m_fBase * r_fRadiusScale;
            // End:0x5D5
            if(fDamageRadius > 0.0000000)
            {
                fDamageRadiusUU = fDamageRadius * float(16);
                FxList = c_Mesh.FxGetAll('AlwaysOn', 0);
                I = 0;
                J0xFA:

                // End:0x26D [Loop If]
                if(I < FxList.Length)
                {
                    Fx = TgSpecialFx(FxList[I]);
                    // End:0x25F
                    if(Fx != none)
                    {
                        J = 0;
                        J0x152:

                        // End:0x243 [Loop If]
                        if(J < Fx.c_PSCList.Length)
                        {
                            PSC = Fx.c_PSCList[J].c_PSC;
                            // End:0x235
                            if(PSC != none)
                            {
                                PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                                PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                            }
                            J++;
                            // [Loop Continue]
                            goto J0x152;
                        }
                        UpdateDecalScale(Fx, r_fRadiusScale);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0xFA;
                }
                FxList = c_Mesh.FxGetAll('OnWhenDeployed', 0);
                I = 0;
                J0x2AE:

                // End:0x421 [Loop If]
                if(I < FxList.Length)
                {
                    Fx = TgSpecialFx(FxList[I]);
                    // End:0x413
                    if(Fx != none)
                    {
                        J = 0;
                        J0x306:

                        // End:0x3F7 [Loop If]
                        if(J < Fx.c_PSCList.Length)
                        {
                            PSC = Fx.c_PSCList[J].c_PSC;
                            // End:0x3E9
                            if(PSC != none)
                            {
                                PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                                PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                            }
                            J++;
                            // [Loop Continue]
                            goto J0x306;
                        }
                        UpdateDecalScale(Fx, r_fRadiusScale);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x2AE;
                }
                FxList = c_Mesh.FxGetAll('Destroyed', 0);
                I = 0;
                J0x462:

                // End:0x5D5 [Loop If]
                if(I < FxList.Length)
                {
                    Fx = TgSpecialFx(FxList[I]);
                    // End:0x5C7
                    if(Fx != none)
                    {
                        J = 0;
                        J0x4BA:

                        // End:0x5AB [Loop If]
                        if(J < Fx.c_PSCList.Length)
                        {
                            PSC = Fx.c_PSCList[J].c_PSC;
                            // End:0x59D
                            if(PSC != none)
                            {
                                PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                                PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                            }
                            J++;
                            // [Loop Continue]
                            goto J0x4BA;
                        }
                        UpdateDecalScale(Fx, r_fRadiusScale);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x462;
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    r_fRadiusScale=0.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Explosion.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectAura.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}