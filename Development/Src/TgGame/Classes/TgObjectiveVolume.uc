class TgObjectiveVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

native function bool IsObjective(Actor Other);  // Export UTgObjectiveVolume::execIsObjective(FFrame&, void* const)

native function SetCurrentObjective(Actor Other);  // Export UTgObjectiveVolume::execSetCurrentObjective(FFrame&, void* const)

native function ClearCurrentObjective();  // Export UTgObjectiveVolume::execClearCurrentObjective(FFrame&, void* const)

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

defaultproperties
{}
