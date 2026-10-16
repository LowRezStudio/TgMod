class TgInvListener_CrackShot extends TgInvListener
    native(ChampOwl)
    config(Engine);

struct CrackShotBonusDamageTarget {
    var Actor pTarget;
    var float fBonusDamageEndTime;
    structdefaultproperties {}
};

var array<CrackShotBonusDamageTarget> m_Targets;
