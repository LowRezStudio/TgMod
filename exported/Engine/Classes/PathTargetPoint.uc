class PathTargetPoint extends Keypoint
    native(AI)
    placeable
    hidecategories(Navigation);

// Export UPathTargetPoint::execShouldBeHiddenBySHOW_NavigationNodes(FFrame&, void* const)
native function bool ShouldBeHiddenBySHOW_NavigationNodes();

defaultproperties
{
    Components[0]=none
    Components[1]=none
    // Reference: CylinderComponent'Engine.Default__PathTargetPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=73.0000000
        CollisionRadius=50.0000000
        ReplacementPrimitive=none
    end object
    Components[2]=CollisionCylinder
    bStatic=false
    bHidden=false
    bNoDelete=true
    CollisionComponent=CollisionCylinder
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
    SupportedEvents[1]=Class'Engine.SeqEvent_Destroyed'
    SupportedEvents[2]=Class'Engine.SeqEvent_TakeDamage'
    SupportedEvents[3]=Class'Engine.SeqEvent_HitWall'
    SupportedEvents[4]=Class'Engine.SeqEvent_AIReachedRouteActor'
    SupportedEvents[5]=Class'Engine.SeqEvent_MobileTouch'
}