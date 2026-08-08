class TgCollisionProxy_Vortex extends TgCollisionProxy
    native
    placeable
    hidecategories(Navigation)
    config(Engine);

var () float m_fGroundSpeedStrafePct;
var () float m_fGroundSpeedToVortex;
var () float m_fGroundSpeedPctRetained;
var () float m_fInnerRadius;
var () bool m_bEnabled;
var () bool m_bOnlyAffectCurrentTarget;
var transient Pawn m_LastInstigator;

simulated event Tick(float DeltaTime) { }

simulated event InstigatorChanged() { }

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

simulated event bool ShouldIgnoreActor(TgPawn aPawn) { }

simulated function OnPlayerAdded(TgPawn aPawn) { }

simulated function OnPlayerRemoved(TgPawn aPawn) { }

defaultproperties
{}
