class TgDropShadowDecalComponent extends StaticMeshComponent
    native(Pawns)
    editinlinenew
    hidecategories(Object);

var transient float LastCachedZ;
var transient Vector LastOwnerPos;

// Export UTgDropShadowDecalComponent::execUpdatePosition(FFrame&, void* const)
native function UpdatePosition(TgPawn TgPOwner, const out Vector OwnerOffset, optional bool bIsInitial = false);

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