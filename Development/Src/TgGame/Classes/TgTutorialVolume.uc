class TgTutorialVolume extends Volume
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var bool m_bHasLocalPawn;
var bool m_bHasSeenLocalPawnBefore;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event UnTouch(Actor Other) { }

defaultproperties
{}
