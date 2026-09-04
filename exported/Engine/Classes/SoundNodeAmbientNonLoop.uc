class SoundNodeAmbientNonLoop extends SoundNodeAmbient
    native(Sound)
    editinlinenew
    dontsortcategories(Attenuation,LowPassFilter,Modulation,Sounds,Spatialization,Delay)
    hidecategories(Object,Object,Object)
    autoexpandcategories(Attenuation,LowPassFilter,Modulation,Sounds,Spatialization,Delay);

var(Delay) float DelayMin;
var(Delay) float DelayMax;
var deprecated RawDistributionFloat DelayTime;
