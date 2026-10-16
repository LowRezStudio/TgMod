class TgDeviceFire_SnakeToss extends TgDeviceFire
    native(ChampMalDamba)
    config(Engine);

struct RecentStunnedTarget {
    var Actor Target;
    var float fTimestamp;
    structdefaultproperties {}
};

var array<RecentStunnedTarget> m_RecentStunnedTargets;

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator) { }
