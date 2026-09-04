class TgInvListener_CrackShot extends TgInvListener
    native(ChampOwl);

struct native CrackShotBonusDamageTarget
{
    var Actor pTarget;
    var float fBonusDamageEndTime;

    structdefaultproperties
    {
        pTarget=none
        fBonusDamageEndTime=0.0000000
    }
};

var array<CrackShotBonusDamageTarget> m_Targets;
