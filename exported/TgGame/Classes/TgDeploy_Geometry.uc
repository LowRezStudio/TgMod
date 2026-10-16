class TgDeploy_Geometry extends TgDeployable
    native(Deployable)
    notplaceable
    hidecategories(Navigation);

var array<Actor> m_OverlappingActors;
var array<Vector> m_DesiredPushDirection;
var bool m_bPushOverlappingActors;
var bool m_bAllyPassthrough;
var bool m_bEnemyPassthrough;
var float m_fPushFactor;

// Export UTgDeploy_Geometry::execIsPushable(FFrame&, void* const)
native function bool IsPushable(const Actor Other);

// Export UTgDeploy_Geometry::execShouldSelfDestructWhenTouchedBy(FFrame&, void* const)
native function bool ShouldSelfDestructWhenTouchedBy(const Actor Other);

// Export UTgDeploy_Geometry::execFindOverlappingActors(FFrame&, void* const)
native function FindOverlappingActors();

// Export UTgDeploy_Geometry::execCalcPushDirection(FFrame&, void* const)
native function Vector CalcPushDirection(Vector HitLocation, Vector HitNormal);

// Export UTgDeploy_Geometry::execPushOverlappingActors(FFrame&, void* const)
native function PushOverlappingActors(float DeltaSeconds);

defaultproperties
{
    m_bPushOverlappingActors=true
    m_fPushFactor=3200.0000000
    m_bAdjustMeshToGround=false
    m_bIsVisionBlocker=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Geometry.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(mCollisionMode=AdvancedCollisionMode.ACM_Geometry,bUseMeshForCollision=true,bBlockFriendlyFire=true)
    m_nInitHUDOverlayDisplayMask=56
    Components[0]=MyLightEnvironment
    bCanStepUpOn=false
    BlockRigidBody=true
    bCollideActors=true
    bBlockActors=true
    bProjTarget=true
    bNoEncroachCheck=true
    bCollideAsEncroacher=true
}