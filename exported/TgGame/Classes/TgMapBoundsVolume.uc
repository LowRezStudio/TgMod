class TgMapBoundsVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() Texture2D MinimapImage;

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPlayerController PC;

    // End:0x81
    if(TgPawn(Other) != none)
    {
        PC = TgPlayerController(TgPawn(Other).Controller);
        // End:0x81
        if(PC != none)
        {
            PC.UpdateMinimap(self);
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: BrushComponent'TgGame.Default__TgMapBoundsVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}