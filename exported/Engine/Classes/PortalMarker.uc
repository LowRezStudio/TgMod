class PortalMarker extends NavigationPoint
    native
    notplaceable
    hidecategories(Navigation,Lighting,LightColor,Force);

var PortalTeleporter MyPortal;

// Export UPortalMarker::execCanTeleport(FFrame&, void* const)
native function bool CanTeleport(Actor A);

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__PortalMarker.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__NavigationPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    bCollideWhenPlacing=false
    bHiddenEd=true
    CollisionComponent=CollisionCylinder
}