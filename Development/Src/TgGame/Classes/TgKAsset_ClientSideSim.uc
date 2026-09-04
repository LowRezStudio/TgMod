class TgKAsset_ClientSideSim extends KAsset
    native
    hidecategories(Navigation)
    config(Engine);

var () float m_fDamageImpulse;
var export editinline ArrowComponent m_Arrow;
var export editinline SpriteComponent m_ForceSprite;
var (Wind) bool m_bEnableWind;
var (Wind) bool m_bEnableGusts;
var () bool bAnimates;
var (Wind) float m_fWindForceMin;
var (Wind) float m_fWindForceMax;
var float m_fWindForceStrength;
var float m_fWindForceTargetStrength;
var (Wind) float m_fWindFrequency;
var float m_fWindForceRemainingTime;
var (Wind) Vector m_vWindDirection;
var (Wind) float m_fForceDistance;
var (Wind) float m_fForceZOffsetMultiplier;
var (Wind) float m_fGustActiveTime;
var (Wind) Vector2D m_vTimeBetweenGusts;
var float m_fGustActiveRemainingTime;
var float m_fTimeTillNextGust;
var (WindManager) Vector2D m_WindFrequencyMultiplier;
var (WindManager) Vector2D m_WindForceMultiplier;

native function OnHit(Vector HitLocation, Vector HitNormal, optional Actor SourceActor, optional TraceHitInfo HitInfo);  // Export UTgKAsset_ClientSideSim::execOnHit(FFrame&, void* const)

defaultproperties
{}
