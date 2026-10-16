class AnimNodeBlendList extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var array<float> TargetWeight;
var float BlendTimeToGo;
var int ActiveChildIndex;
var() bool bPlayActiveChild;
var(Performance) bool bForceChildFullWeightWhenBecomingRelevant;
var(Performance) bool bSkipBlendWhenNotRendered;
var() array<int> PlayActiveChildExceptionList;
var const float SliderPosition;

// Export UAnimNodeBlendList::execSetActiveChild(FFrame&, void* const)
native function SetActiveChild(int ChildIndex, float BlendTime);

defaultproperties
{
    bForceChildFullWeightWhenBecomingRelevant=true
    bSkipBlendWhenNotRendered=true
    Children[0]=(Name="Child1",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
}