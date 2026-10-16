class PortalVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Collision,Volume);

var array<PortalTeleporter> Portals;

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__PortalVolume.BrushComponent0'
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
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
}