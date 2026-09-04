class CylinderComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    noexport;

var() const export float CollisionHeight;
var() const export float CollisionRadius;
var() const Color CylinderColor;
var const bool bDrawBoundingBox;
var const bool bDrawNonColliding;
var const bool bAlwaysRenderIfSelected;

// Export UCylinderComponent::execSetCylinderSize(FFrame&, void* const)
native final function SetCylinderSize(float NewRadius, float NewHeight);

defaultproperties
{
    CollisionHeight=22.0000000
    CollisionRadius=22.0000000
    CylinderColor=(R=223,G=149,B=157,A=255)
    bDrawBoundingBox=true
    ReplacementPrimitive=none
    HiddenGame=true
    bAcceptsDynamicDecals=false
    bCastDynamicShadow=false
    BlockZeroExtent=true
    BlockNonZeroExtent=true
}