class TgObjectiveVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

// Export UTgObjectiveVolume::execIsObjective(FFrame&, void* const)
native function bool IsObjective(Actor Other);

// Export UTgObjectiveVolume::execSetCurrentObjective(FFrame&, void* const)
native function SetCurrentObjective(Actor Other);

// Export UTgObjectiveVolume::execClearCurrentObjective(FFrame&, void* const)
native function ClearCurrentObjective();

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
            SetCurrentObjective(Other);
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
    // End:0x75
    if(aPawn != none)
    {
        aPC = TgPlayerController(aPawn.Controller);
        // End:0x75
        if(aPC != none)
        {
            ClearCurrentObjective();
        }
    }
    super(Actor).UnTouch(Other);
    //return;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgObjectiveVolume.BrushComponent0'
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