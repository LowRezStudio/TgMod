class TgDeviceFire_OracleInhand extends TgDeviceFire
    native(ChampOracle)
    config(Engine);

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator) { }
