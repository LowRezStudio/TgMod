class SeqAct_SetMesh extends SequenceAction
    native(Sequence)
    hidecategories(Object);

enum EMeshType
{
    MeshType_StaticMesh,            // 0
    MeshType_SkeletalMesh,          // 1
    MeshType_MAX                    // 2
};

var() SkeletalMesh NewSkeletalMesh;
var() StaticMesh NewStaticMesh;
var() SeqAct_SetMesh.EMeshType MeshType;
var() bool bIsAllowedToMove;
var() bool bAllowDecalsToReattach;

defaultproperties
{
    ObjName="Set Mesh"
}