class TgSoundInsulationVolume extends ReverbVolume
    dontsortcategories(ReverbVolume)
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Volume,Toggle);

defaultproperties
{
    Settings=(bApplyReverb=false)
    AmbientZoneSettings=(InsulationDistanceMin=480.0000000,InsulationDistanceMax=800.0000000)
    // Reference: BrushComponent'TgGame.Default__TgSoundInsulationVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__ReverbVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}