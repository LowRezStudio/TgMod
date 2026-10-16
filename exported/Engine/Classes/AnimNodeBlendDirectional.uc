class AnimNodeBlendDirectional extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() float DirDegreesPerSecond;
var float DirAngle;
var() int SingleAnimAtOrAboveLOD;
var Rotator RotationOffset;
var() bool bUseAcceleration;

defaultproperties
{
    DirDegreesPerSecond=360.0000000
    SingleAnimAtOrAboveLOD=1000
    Children[0]=(Name="Forward",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Backward",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[2]=(Name="Left",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[3]=(Name="Right",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}