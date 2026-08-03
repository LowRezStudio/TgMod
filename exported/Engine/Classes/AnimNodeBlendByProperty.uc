class AnimNodeBlendByProperty extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() name PropertyName;
var() bool bUseOwnersBase;
var const transient bool bForceUpdate;
var() bool bUseSpecificBlendTimes;
var(Editor) bool bSynchronizeNodesInEditor;
var transient name CachedPropertyName;
var native const transient Pointer CachedFloatProperty;
var native const transient Pointer CachedBoolProperty;
var native const transient Pointer CachedByteProperty;
var transient Actor CachedOwner;
var() float BlendTime;
var() float FloatPropMin;
var() float FloatPropMax;
var() float BlendToChild1Time;
var() float BlendToChild2Time;

defaultproperties
{
    bSynchronizeNodesInEditor=true
    BlendTime=0.1000000
    FloatPropMax=1.0000000
    BlendToChild1Time=0.1000000
    BlendToChild2Time=0.1000000
    bForceChildFullWeightWhenBecomingRelevant=false
    Children[0]=(Name="Child1",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Child2",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
}