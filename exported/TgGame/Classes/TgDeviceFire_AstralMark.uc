class TgDeviceFire_AstralMark extends TgDeviceFire
    native(ChampAstro);

var float m_InitialLifetime;
var float m_OverflowTime;
var float m_BaseLifetime;

// Export UTgDeviceFire_AstralMark::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator)
{
    local TgPawn_Astro pAstro;
    local TgPawn pTarget;
    local TgEffectManager pEffectManager;
    local TgEffectGroup pEffectGroup;
    local TgDeviceFire pFireMode;
    local float fExistingBuffTime, fNewBuffTime;
    local int I;

    pTarget = TgPawn(Impact.HitActor);
    pAstro = TgPawn_Astro(DamageInstigator);
    // End:0x2F9
    if((pTarget != none) && pAstro != none)
    {
        pEffectManager = pTarget.GetEffectManager();
        // End:0x2F9
        if(pEffectManager != none)
        {
            pEffectGroup = pEffectManager.GetEffectGroupByCategory(16627);
            // End:0x20D
            if(pEffectGroup == none)
            {
                // End:0x1DD
                if(pAstro.HasDeviceCached(0))
                {
                    I = 0;
                    J0x10F:

                    // End:0x1DD [Loop If]
                    if(I < s_EffectGroupList.Length)
                    {
                        pEffectGroup = s_EffectGroupList[I];
                        // End:0x1CF
                        if(pEffectGroup != none)
                        {
                            pFireMode = pAstro.m_AstralCycleCard.GetCurrentFire();
                            pEffectGroup.m_fLifeTime = pFireMode.GetCustomValue1();
                        }
                        I++;
                        // [Loop Continue]
                        goto J0x10F;
                    }
                }
                m_BaseLifetime = s_EffectGroupList[0].GetLifeTime(true);                
            }
            else
            {
                fExistingBuffTime = pEffectGroup.GetTimeRemaining();
                // End:0x2B3
                if(fExistingBuffTime > float(0))
                {
                    fNewBuffTime = fExistingBuffTime + m_BaseLifetime;
                    // End:0x2B3
                    if(fNewBuffTime > (m_BaseLifetime * ((GetCustomValue1()) / float(100))))
                    {
                        fNewBuffTime = m_BaseLifetime * ((GetCustomValue1()) / float(100));
                    }
                }
                pEffectGroup.m_fLifeTime = fNewBuffTime;
            }
            super.ApplyHit(Impact, DamageInstigator);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_bUseTargetingEncroachmentActor=true
    m_bScaleEncroachmentWithRangeMod=true
    m_bEnchroachmentFireLOSCheck=false
    m_nTargetingEncroachmentActorOverride=7075
    m_vActorEncroachmentBaseScale=(X=9.0000000,Y=9.0000000,Z=9.0000000)
}