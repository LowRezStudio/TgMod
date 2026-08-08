class TgDropShadowDecalComponent extends StaticMeshComponent
    native(Pawns)
    editinlinenew
    hidecategories(Object)
    config(Engine);

var transient float LastCachedZ;
var transient Vector LastOwnerPos;

native function UpdatePosition(TgPawn TgPOwner, const out Vector OwnerOffset, optional bool bIsInitial=false);  // Export UTgDropShadowDecalComponent::execUpdatePosition(FFrame&, void* const)

defaultproperties
{
    ReplacementPrimitive=none
    bAcceptsStaticDecals=false
    CollideActors=false
    BlockActors=false
    BlockZeroExtent=false
    BlockNonZeroExtent=false
    BlockRigidBody=false
    AlwaysLoadOnServer=false
    AbsoluteRotation=true
    TranslucencySortPriority=-1
}
