class TgPlayerCountVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int PlayerCountTarget;
var () int TaskForceNumber;
var () int MessageId;
var array<Pawn> Players;
var () bool Enabled;

native function Update(TgPawn Other);  // Export UTgPlayerCountVolume::execUpdate(FFrame&, void* const)

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event int GetCount() { }

defaultproperties
{}
