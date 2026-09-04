class TgCharacterPerformance extends TgGame
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

struct DeviceToCharacterID {
    var int CharacterID;
    var int DeviceID;
    structdefaultproperties {}
};

var transient PComPerformanceCaptureBase BasePerformanceCapture;
var PComPerformanceCaptureBase.EPComPerformanceCaptureState CurrentCaptureState;
var string CharacterInput;
var string SkinInput;
var int CurrentCharacterIndex;
var int CurrentSkinIndex;
var transient array<TgSkeletalMeshActor_Loader> CharacterPlacements;
var transient array<string> CharactersToTest;
var array<int> AllSkinIDs;
var array<DeviceToCharacterID> DeviceToCharacterIDPairs;
var array<PComPerformanceCaptureStatsPerSkin> StatsPerSkin;
var array<TgPawn> CharacterPawns;
var TgManifestGroup ManifestGroup;

event PostBeginPlay() { }

native function CollectCharacterPlacementsAndSkins();  // Export UTgCharacterPerformance::execCollectCharacterPlacementsAndSkins(FFrame&, void* const)

native function CollectAllSkins();  // Export UTgCharacterPerformance::execCollectAllSkins(FFrame&, void* const)

native function MoveCameraToNode();  // Export UTgCharacterPerformance::execMoveCameraToNode(FFrame&, void* const)

native function SpawnCharacters();  // Export UTgCharacterPerformance::execSpawnCharacters(FFrame&, void* const)

native function TgPawn SpawnBotByIdForPerformance(int nBotId, int nSkinId, int nHeadId, int nWeaponSkinId, Vector vLocation, Rotator rRotation);  // Export UTgCharacterPerformance::execSpawnBotByIdForPerformance(FFrame&, void* const)

native function DoNextAction();  // Export UTgCharacterPerformance::execDoNextAction(FFrame&, void* const)

native function PrintAllSkins();  // Export UTgCharacterPerformance::execPrintAllSkins(FFrame&, void* const)

defaultproperties
{}
