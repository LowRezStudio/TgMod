class TgElevatingVolume extends PhysicsVolume
    hidecategories(Navigation,Object,Movement,Display);

defaultproperties
{
    ZoneVelocity=(X=0.0000000,Y=0.0000000,Z=20.0000000)
    bVelocityAffectsWalking=false
    bEntryPain=false
    m_bIsElevating=true
    m_bClampPawnVelocity=true
    TerminalVelocity=300.0000000
    m_fClampedPawnVelocity=(X=20.0000000,Y=20.0000000)
    // Reference: BrushComponent'TgGame.Default__TgElevatingVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}