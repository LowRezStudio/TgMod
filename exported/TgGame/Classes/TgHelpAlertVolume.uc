class TgHelpAlertVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() int TaskForceNumber;
var() array<int> GameTipIdList;

// Export UTgHelpAlertVolume::execAddGameTips(FFrame&, void* const)
native function AddGameTips(TgPlayerController aPC);

// Export UTgHelpAlertVolume::execRemoveGameTips(FFrame&, void* const)
native function RemoveGameTips(TgPlayerController aPC);

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn aPawn;
    local TgPlayerController aPC;

    aPawn = TgPawn(Other);
    // End:0x7E
    if(aPawn != none)
    {
        aPC = TgPlayerController(aPawn.Controller);
        // End:0x7E
        if(aPC != none)
        {
            AddGameTips(aPC);
        }
    }
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event UnTouch(Actor Other)
{
    local TgPawn aPawn;
    local TgPlayerController aPC;

    aPawn = TgPawn(Other);
    // End:0x7E
    if(aPawn != none)
    {
        aPC = TgPlayerController(aPawn.Controller);
        // End:0x7E
        if(aPC != none)
        {
            RemoveGameTips(aPC);
        }
    }
    super(Actor).UnTouch(Other);
    //return;    
}

defaultproperties
{
    bLocalPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgHelpAlertVolume.BrushComponent0'
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