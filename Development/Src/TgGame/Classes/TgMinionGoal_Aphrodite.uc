class TgMinionGoal_Aphrodite extends TgMinionGoal
    native(AI)
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
