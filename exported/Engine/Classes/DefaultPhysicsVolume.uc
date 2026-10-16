class DefaultPhysicsVolume extends PhysicsVolume
    transient
    native
    notplaceable
    hidecategories(Navigation,Object,Movement,Display);

event Destroyed()
{
    // DebugMode: 0
    assert(false);
    //return;    
}

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__DefaultPhysicsVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bNoDelete=false
    CollisionComponent=BrushComponent0
}