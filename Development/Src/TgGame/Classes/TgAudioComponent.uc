class TgAudioComponent extends AudioComponent
    native(FX)
    editinlinenew
    collapsecategories
    hidecategories(Object,ActorComponent)
    config(Engine);

var bool m_bCanBeHeardDuringStealth;
var float m_fStealthFadeInTime;
var float m_fStealthFadeOutTime;
var float m_fStealthVolumeMultiplier;

native function ApplyAdditionalPriority();  // Export UTgAudioComponent::execApplyAdditionalPriority(FFrame&, void* const)

event OcclusionChanged(bool bNowOccluded) { }

defaultproperties
{
    m_fStealthFadeInTime=0.2000000
    m_fStealthFadeOutTime=0.3000000
    m_fStealthVolumeMultiplier=1.0000000
}
