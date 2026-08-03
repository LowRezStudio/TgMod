class TgDeviceFire_FlakInHand extends TgDeviceFire
    native(ChampFlak);

var int m_BaseKnockback;

// Export UTgDeviceFire_FlakInHand::execAddEffectiveRangeReduction(FFrame&, void* const)
native function AddEffectiveRangeReduction(out ImpactInfo Impact, Actor DamageInstigator, Vector OriginLocation, optional bool bUseRadius = false);

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator)
{
    local TgEffect Effect;
    local float Range, hitDistance, pctKnockback;
    local int I;

    I = 0;
    J0x0B:

    // End:0x1AD [Loop If]
    if(I < s_EffectGroupList.Length)
    {
        Effect = s_EffectGroupList[I].m_Effects[0];
        // End:0x19F
        if(Effect != none)
        {
            // End:0x19F
            if(Effect.m_nPropertyId == 1507)
            {
                Range = GetRange();
                hitDistance = VSizeSq(Impact.HitActor.Location - DamageInstigator.Location);
                // End:0x19F
                if(hitDistance <= (Range * Range))
                {
                    m_GameplayCurves.GetPrimaryDistributionValueByType(20, hitDistance / (Range * Range), pctKnockback);
                    Effect.m_fBase = pctKnockback * float(m_BaseKnockback);
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return super.ApplyHit(Impact, DamageInstigator);
    //return ReturnValue;    
}

defaultproperties
{
    m_bUseAccurateEncroachment=true
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=7948
    m_vActorEncroachmentBaseScale=(X=13.5000000,Y=30.0000000,Z=20.0000000)
    m_GameplayCurves=TgGameplayCurves'GP_Flak.DeviceInhand'
}