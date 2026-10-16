class TgHelpAlertVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int TaskForceNumber;
var () array<int> GameTipIdList;

native function AddGameTips(TgPlayerController aPC);  // Export UTgHelpAlertVolume::execAddGameTips(FFrame&, void* const)

native function RemoveGameTips(TgPlayerController aPC);  // Export UTgHelpAlertVolume::execRemoveGameTips(FFrame&, void* const)

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

defaultproperties
{}
