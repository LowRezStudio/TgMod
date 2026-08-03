class TgAnimNodeSequence extends AnimNodeSequence
    native(Anim)
    hidecategories(Object,Object,Object);

var() bool bAutoPlay;
var bool bResetOnActivate;
var() bool HasDynamicLength;
var() bool EnableFootControlsOnCease;
var(Group) bool SynchronizeGroupOnReplay;
var() bool bRandomStartPosition;
var() float ChainedSequenceDuration;
var(DisplayGroup) name m_nmDisplayGroup;

// Export UTgAnimNodeSequence::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);
