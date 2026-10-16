class TgAILocalPositionSolver extends Object within Actor
    native(AI)
    implements(Interface_ActorPathConstraints);

enum ERepulsorWeightMethod
{
    RWM_Cubic,                      // 0
    RWM_Lerp,                       // 1
    RWM_Slerp,                      // 2
    RWM_MAX                         // 3
};

struct native DefaultRepulsorData
{
    var byte TargetType;
    var float MaxEnemyWeight;
    var float MaxFriendlyWeight;
    var TgAILocalPositionSolver.ERepulsorWeightMethod SolverType;

    structdefaultproperties
    {
        TargetType=0
        MaxEnemyWeight=0.0000000
        MaxFriendlyWeight=0.0000000
        SolverType=ERepulsorWeightMethod.RWM_Cubic
    }
};

var private native const noexport Pointer VfTable_IInterface_ActorPathConstraints;
var array<DefaultRepulsorData> DefaultWeights;
var transient TgAIController_Behavior OuterController;
var transient float LastQueryTime;
var transient Vector LastQueryPoint;
var transient Vector LastSolvePoint;
var bool bSolveDistanceThreshold;
var bool bSolveWeights;

// Export UTgAILocalPositionSolver::execSolveConstraints(FFrame&, void* const)
native function SolveConstraints(const Vector InitialPosition, const float MaxDistance, out Vector OutDesiredPosition);

defaultproperties
{
    DefaultWeights[0]=(TargetType=1,MaxEnemyWeight=-20.0000000,MaxFriendlyWeight=10.0000000,SolverType=ERepulsorWeightMethod.RWM_Lerp)
    DefaultWeights[1]=(TargetType=11,MaxEnemyWeight=-40.0000000,MaxFriendlyWeight=0.0000000,SolverType=ERepulsorWeightMethod.RWM_Lerp)
    DefaultWeights[2]=(TargetType=6,MaxEnemyWeight=-20.0000000,MaxFriendlyWeight=-30.0000000,SolverType=ERepulsorWeightMethod.RWM_Lerp)
    DefaultWeights[3]=(TargetType=7,MaxEnemyWeight=-20.0000000,MaxFriendlyWeight=-30.0000000,SolverType=ERepulsorWeightMethod.RWM_Lerp)
    DefaultWeights[4]=(TargetType=3,MaxEnemyWeight=-30.0000000,MaxFriendlyWeight=-20.0000000,SolverType=ERepulsorWeightMethod.RWM_Lerp)
    bSolveDistanceThreshold=true
    bSolveWeights=true
}