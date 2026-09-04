class TgItemShopVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int TaskforceIndex;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event UnTouch(Actor Other) { }

simulated function int GetSupportedTaskforce() { }

event SetPurchaseFlag(Actor Other, bool bCanPurchase) { }

defaultproperties
{}
