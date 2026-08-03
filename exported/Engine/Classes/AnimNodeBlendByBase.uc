class AnimNodeBlendByBase extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBaseBlendType
{
    BBT_ByActorTag,                 // 0
    BBT_ByActorClass,               // 1
    BBT_MAX                         // 2
};

var() AnimNodeBlendByBase.EBaseBlendType Type;
var() name ActorTag;
var() Class<Actor> ActorClass;
var() float BlendTime;
var transient Actor CachedBase;

defaultproperties
{
    BlendTime=0.2000000
    Children[0]=(Name="Normal",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Based",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}