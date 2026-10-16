class AnimNodeCrossfader extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object,Object);

var() name DefaultAnimSeqName;
var const bool bDontBlendOutOneShot;
var const float PendingBlendOutTimeOneShot;

// Export UAnimNodeCrossfader::execPlayOneShotAnim(FFrame&, void* const)
native final function PlayOneShotAnim(name AnimSeqName, optional float BlendInTime, optional float BlendOutTime, optional bool bDontBlendOut, optional float Rate);

// Export UAnimNodeCrossfader::execBlendToLoopingAnim(FFrame&, void* const)
native final function BlendToLoopingAnim(name AnimSeqName, optional float BlendInTime, optional float Rate);

// Export UAnimNodeCrossfader::execGetAnimName(FFrame&, void* const)
native final function name GetAnimName();

// Export UAnimNodeCrossfader::execGetActiveChild(FFrame&, void* const)
native final function AnimNodeSequence GetActiveChild();
