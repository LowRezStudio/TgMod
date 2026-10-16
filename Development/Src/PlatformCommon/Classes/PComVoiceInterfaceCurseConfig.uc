class PComVoiceInterfaceCurseConfig extends Object
    native
    config(Game);

struct PComCursePromo {
    var () string PromoName;
    var () int ActivityId;
    structdefaultproperties {}
};

var config array<config PComCursePromo> Promos;
