class TgDeviceFire_OracleInhand extends TgDeviceFire
    native(ChampOracle);

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator)
{
    // End:0x74
    if(super.ApplyHit(Impact, DamageInstigator))
    {
        // End:0x72
        if(Impact.HitActor != none)
        {
            ApplyHitSpecial(Impact.HitActor, Impact);
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}
