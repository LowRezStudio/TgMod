class SkeletalMeshSocket extends Object
    native(SkeletalMesh)
    hidecategories(Object,Actor);

var() editconst name SocketName;
var() editconst name BoneName;
var() Vector RelativeLocation;
var() Rotator RelativeRotation;
var() Vector RelativeScale;
var() const editconst export editinline transient SkeletalMeshComponent PreviewSkelComp;

defaultproperties
{
    RelativeScale=(X=1.0000000,Y=1.0000000,Z=1.0000000)
}