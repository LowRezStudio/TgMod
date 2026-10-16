class TgDeploy_Geometry extends TgDeployable
    native(Deployable)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var array<Actor> m_OverlappingActors;
var array<Vector> m_DesiredPushDirection;
var bool m_bPushOverlappingActors;
var bool m_bAllyPassthrough;
var bool m_bEnemyPassthrough;
var float m_fPushFactor;

native function bool IsPushable(const Actor Other);  // Export UTgDeploy_Geometry::execIsPushable(FFrame&, void* const)

native function bool ShouldSelfDestructWhenTouchedBy(const Actor Other);  // Export UTgDeploy_Geometry::execShouldSelfDestructWhenTouchedBy(FFrame&, void* const)

native function FindOverlappingActors();  // Export UTgDeploy_Geometry::execFindOverlappingActors(FFrame&, void* const)

native function Vector CalcPushDirection(Vector HitLocation, Vector HitNormal);  // Export UTgDeploy_Geometry::execCalcPushDirection(FFrame&, void* const)

native function PushOverlappingActors(float DeltaSeconds);  // Export UTgDeploy_Geometry::execPushOverlappingActors(FFrame&, void* const)

defaultproperties
{}
