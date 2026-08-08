class TgSkeletalMeshActor extends SkeletalMeshActor
    native(Pawns)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var MeshAssets c_MeshAssets;
var () bool c_bLoadMeshAssetts;

native function bool AttachToSocket(Actor Attachment, name BoneName);  // Export UTgSkeletalMeshActor::execAttachToSocket(FFrame&, void* const)

native function TgSkeletalMeshComponent CreateSkeletalMeshComponent(int MeshAsmId, optional TgSkeletalMeshComponent DestComponent, optional bool bPartialFixup=false);  // Export UTgSkeletalMeshActor::execCreateSkeletalMeshComponent(FFrame&, void* const)

native function TgStaticMeshComponent CreateStaticMeshComponent(int MeshAsmId, optional TgStaticMeshComponent DestComponent);  // Export UTgSkeletalMeshActor::execCreateStaticMeshComponent(FFrame&, void* const)

native function MeshComponent CreateMeshComponent(int MeshAsmId, optional MeshComponent DestComponent, optional bool bPartialFixup=false);  // Export UTgSkeletalMeshActor::execCreateMeshComponent(FFrame&, void* const)

native function LoadClientOnlyMeshAssets();  // Export UTgSkeletalMeshActor::execLoadClientOnlyMeshAssets(FFrame&, void* const)

function OnParentAnimComponent(TgSeqAct_ParentAnimComponent Action) { }

function DoKismetAttachment(Actor Attachment, SeqAct_AttachToActor Action) { }

defaultproperties
{}
