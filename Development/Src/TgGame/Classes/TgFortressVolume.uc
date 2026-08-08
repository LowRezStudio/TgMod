class TgFortressVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int TaskforceIndex;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event UnTouch(Actor Other) { }

event PostBeginPlay() { }

defaultproperties
{}
