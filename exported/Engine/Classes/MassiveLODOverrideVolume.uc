class MassiveLODOverrideVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display,Collision,Brush,Attachment,Physics,Volume);

defaultproperties
{
    BrushColor=(R=120,G=80,B=80,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__MassiveLODOverrideVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_Nothing
        CollideActors=false
        BlockNonZeroExtent=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bCollideActors=false
    CollisionComponent=BrushComponent0
}