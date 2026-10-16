class TgDeviceFire_SnakeToss extends TgDeviceFire
    native(ChampMalDamba);

struct native RecentStunnedTarget
{
    var Actor Target;
    var float fTimestamp;

    structdefaultproperties
    {
        Target=none
        fTimestamp=0.0000000
    }
};

var array<RecentStunnedTarget> m_RecentStunnedTargets;

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator)
{
    local bool ret;
    local int I;

    ret = super.ApplyHit(Impact, DamageInstigator);
    I = m_RecentStunnedTargets.Length - 1;
    J0x3E:

    // End:0x12F [Loop If]
    if(I >= 0)
    {
        // End:0xCF
        if((m_Owner.WorldInfo.TimeSeconds - m_RecentStunnedTargets[I].fTimestamp) >= (GetCustomValue5()))
        {
            m_RecentStunnedTargets.Remove(I, 1);            
        }
        else
        {
            // End:0x121
            if(m_RecentStunnedTargets[I].Target == Impact.HitActor)
            {
                return ret;
            }
        }
        I--;
        // [Loop Continue]
        goto J0x3E;
    }
    ApplyHitSpecial(Impact.HitActor, Impact);
    return ret;
    //return ReturnValue;    
}
