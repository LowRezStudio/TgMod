class CullDistanceVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Collision,Volume);

struct native CullDistanceSizePair
{
    var() float Size;
    var() float CullDistance;

    structdefaultproperties
    {
        Size=0.0000000
        CullDistance=0.0000000
    }
};

var() array<CullDistanceSizePair> CullDistances;
var() bool bEnabled;

defaultproperties
{
    CullDistances[0]=(Size=0.0000000,CullDistance=0.0000000)
    CullDistances[1]=(Size=10000.0000000,CullDistance=0.0000000)
    bEnabled=true
    // Reference: BrushComponent'Engine.Default__CullDistanceVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        CollideActors=false
        BlockNonZeroExtent=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bCollideActors=false
    CollisionComponent=BrushComponent0
    SupportedEvents=none
}