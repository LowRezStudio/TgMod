class TgPickupFactory extends PickupFactory
    abstract
    native(Inventory)
    hidecategories(Navigation,Lighting,LightColor,Force,Display,Collision)
    config(Engine);

var bool bRotatingPickup;
var float YawRotationRate;
var Controller TeamOwner[4];
var export editinline PrimitiveComponent BaseMesh;

function bool ShouldCamp(TgAIController B, float MaxWait) { }

simulated function UpdateHUD(TgHUD H) { }

function RespawnEffect() { }

simulated function bool StopsProjectile(Projectile P) { }

defaultproperties
{}
