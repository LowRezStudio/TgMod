class TgKAsset_ClientSideSim extends KAsset
    native
    hidecategories(Navigation);

var() float m_fDamageImpulse;
var export editinline ArrowComponent m_Arrow;
var export editinline SpriteComponent m_ForceSprite;
var(Wind) bool m_bEnableWind;
var(Wind) bool m_bEnableGusts;
var() bool bAnimates;
var(Wind) float m_fWindForceMin;
var(Wind) float m_fWindForceMax;
var float m_fWindForceStrength;
var float m_fWindForceTargetStrength;
var(Wind) float m_fWindFrequency;
var float m_fWindForceRemainingTime;
var(Wind) Vector m_vWindDirection;
var(Wind) float m_fForceDistance;
var(Wind) float m_fForceZOffsetMultiplier;
var(Wind) float m_fGustActiveTime;
var(Wind) Vector2D m_vTimeBetweenGusts;
var float m_fGustActiveRemainingTime;
var float m_fTimeTillNextGust;
var(WindManager) Vector2D m_WindFrequencyMultiplier;
var(WindManager) Vector2D m_WindForceMultiplier;

// Export UTgKAsset_ClientSideSim::execOnHit(FFrame&, void* const)
native function OnHit(Vector HitLocation, Vector HitNormal, optional Actor SourceActor, optional TraceHitInfo HitInfo);

defaultproperties
{
    m_fDamageImpulse=500.0000000
    // Reference: SpriteComponent'TgGame.Default__TgKAsset_ClientSideSim.Sprite'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Sprite'
    begin object name="Sprite" class=Engine.SpriteComponent
        ReplacementPrimitive=none
        AlwaysLoadOnClient=false
        AlwaysLoadOnServer=false
    end object
    m_ForceSprite=Sprite
    m_fWindForceMax=10.0000000
    m_fWindFrequency=2.0000000
    m_vWindDirection=(X=0.0000000,Y=1.0000000,Z=0.0000000)
    m_fForceDistance=300.0000000
    m_fForceZOffsetMultiplier=1.2000000
    m_fGustActiveTime=4.0000000
    m_vTimeBetweenGusts=(X=4.0000000,Y=8.0000000)
    m_WindFrequencyMultiplier=(X=0.8000000,Y=1.1000000)
    m_WindForceMultiplier=(X=0.8000000,Y=1.1000000)
    // Reference: SkeletalMeshComponent'TgGame.Default__TgKAsset_ClientSideSim.KAssetSkelMeshComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'KAssetSkelMeshComponent'
    // Archetype: SkeletalMeshComponent'Engine.Default__KAsset.KAssetSkelMeshComponent'
    begin object name="KAssetSkelMeshComponent"
        bUpdateSkelWhenNotRendered=false
        bSyncActorLocationToRootRigidBody=false
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgKAsset_ClientSideSim.MyLightEnvironment'
        CanBlockCamera=false
    end object
    SkeletalMeshComponent=KAssetSkelMeshComponent
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgKAsset_ClientSideSim.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__KAsset.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    Components[0]=MyLightEnvironment
    Components[1]=KAssetSkelMeshComponent
    Components[2]=none
    Components[3]=Sprite
    RemoteRole=ENetRole.ROLE_None
    CollisionType=ECollisionType.COLLIDE_TouchWeapons
    bReplicateMovement=false
    bSkipActorPropertyReplication=true
    BlockRigidBody=true
    CollisionComponent=KAssetSkelMeshComponent
}