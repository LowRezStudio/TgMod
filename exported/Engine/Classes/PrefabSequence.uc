class PrefabSequence extends Sequence
    native(Sequence)
    hidecategories(Object);

var protected PrefabInstance OwnerPrefab;

// Export UPrefabSequence::execSetOwnerPrefab(FFrame&, void* const)
native final function SetOwnerPrefab(PrefabInstance InOwner);

// Export UPrefabSequence::execGetOwnerPrefab(FFrame&, void* const)
native final function PrefabInstance GetOwnerPrefab();

defaultproperties
{
    ObjName="PrefabSequence"
    bDeletable=false
}