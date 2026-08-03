class TgPlayerCountVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() int PlayerCountTarget;
var() int TaskForceNumber;
var() int MessageId;
var array<Pawn> Players;
var() bool Enabled;

// Export UTgPlayerCountVolume::execUpdate(FFrame&, void* const)
native function Update(TgPawn Other);

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn OtherPawn;

    OtherPawn = TgPawn(Other);
    // End:0xAF
    if(((OtherPawn != none) && TgPlayerController(OtherPawn.Controller) != none) && (TaskForceNumber == 0) || int(OtherPawn.GetTaskForceNumber()) == TaskForceNumber)
    {
        Update(OtherPawn);
    }
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event int GetCount()
{
    return Players.Length;
    //return ReturnValue;    
}

defaultproperties
{
    PlayerCountTarget=4
    TaskForceNumber=1
    MessageId=37340
    Enabled=true
    // Reference: BrushComponent'TgGame.Default__TgPlayerCountVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
    SupportedEvents=/* Array type was not detected. */
}