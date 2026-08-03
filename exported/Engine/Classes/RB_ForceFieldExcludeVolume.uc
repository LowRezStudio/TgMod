class RB_ForceFieldExcludeVolume extends Volume
    native(ForceField)
    placeable
    hidecategories(Navigation,Object,Movement,Display);

var() int ForceFieldChannel;
var native const int SceneIndex;

defaultproperties
{
    ForceFieldChannel=1
    // Reference: BrushComponent'Engine.Default__RB_ForceFieldExcludeVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        BlockNonZeroExtent=false
        bDisableAllRigidBody=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}