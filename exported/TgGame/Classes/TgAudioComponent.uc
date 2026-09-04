class TgAudioComponent extends AudioComponent
    native(FX)
    editinlinenew
    collapsecategories
    hidecategories(Object,ActorComponent);

var bool m_bCanBeHeardDuringStealth;
var float m_fStealthFadeInTime;
var float m_fStealthFadeOutTime;
var float m_fStealthVolumeMultiplier;

// Export UTgAudioComponent::execApplyAdditionalPriority(FFrame&, void* const)
native function ApplyAdditionalPriority();

event OcclusionChanged(bool bNowOccluded)
{
    VolumeMultiplier *= ((bNowOccluded) ? 0.5000000 : 2.0000000);
    LastOcclusionCheckTime += 0.0001000;
    //return;    
}

defaultproperties
{
    m_fStealthFadeInTime=0.2000000
    m_fStealthFadeOutTime=0.3000000
    m_fStealthVolumeMultiplier=1.0000000
}