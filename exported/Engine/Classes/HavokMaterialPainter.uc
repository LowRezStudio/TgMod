class HavokMaterialPainter extends Volume
    native(Havok)
    placeable
    hidecategories(Navigation,Object,Movement,Display);

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__HavokMaterialPainter.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionType=ECollisionType.COLLIDE_NoCollision
    CollisionComponent=BrushComponent0
}