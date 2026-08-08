class TgMinionGoal extends NavigationPoint
    native(AI)
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

var () int m_nLaneNum;
var () int m_nTaskForce;
var () TgActionPoint m_EndPoint;
var () bool m_bUseForFinalDestination;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
