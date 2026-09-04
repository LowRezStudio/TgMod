class TgNearObjectiveVolume extends Volume
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event UnTouch(Actor Other) { }

defaultproperties
{}
