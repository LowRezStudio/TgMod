class PComVoiceInterfaceCurseConfig extends Object
    native
    config(Game);

struct native PComCursePromo
{
    var() string PromoName;
    var() int ActivityId;

    structdefaultproperties
    {
        PromoName=""
        ActivityId=0
    }
};

var config array<config PComCursePromo> Promos;
