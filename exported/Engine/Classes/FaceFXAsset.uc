class FaceFXAsset extends Object
    native
    hidecategories(Object);

var native const Pointer FaceFXActor;
var native const array<byte> RawFaceFXActorBytes;
var native const array<byte> RawFaceFXSessionBytes;
var transient array<FaceFXAnimSet> MountedFaceFXAnimSets;
var int NumLoadErrors;

// Export UFaceFXAsset::execMountFaceFXAnimSet(FFrame&, void* const)
native final function MountFaceFXAnimSet(FaceFXAnimSet AnimSet);

// Export UFaceFXAsset::execUnmountFaceFXAnimSet(FFrame&, void* const)
native final function UnmountFaceFXAnimSet(FaceFXAnimSet AnimSet);
