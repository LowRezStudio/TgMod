class TgThreatModel extends Object
    native(ThreatModel)
    config(Game);

var array<TgPawn> m_PawnsWithThreatLevels;
var bool m_bThreatSystemEnabled;
var bool m_bOcclusionSystemEnabled;
var bool m_bDebugThreatSystem;
var config float m_fThreatCoefficientProximity;
var config float m_fThreatCoefficientOcclusion;
var config float m_fThreatCoefficientBinnedOcclusion;
var config float m_fThreatCoefficientUlt;
var config float m_fThreatCoefficientShotAt;
var config float m_fThreatCoefficientSeenBy;
var config float m_fThreatCoefficientDamaged;
var config float m_fThreatCoefficientFocused;
var config float m_fThreatCoefficientFocusTarget;
var config float m_fThreatDecayCoefficientShotAt;
var config float m_fThreatDecayCoefficientSeenBy;
var config float m_fThreatDecayCoefficientUlt;
var string m_DebugThreatSystemChannel;

defaultproperties
{
    m_bThreatSystemEnabled=true
    m_bOcclusionSystemEnabled=true
}
