class TgCharacterPerformance extends TgGame
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

struct native DeviceToCharacterID
{
    var int CharacterID;
    var int DeviceID;

    structdefaultproperties
    {
        CharacterID=0
        DeviceID=0
    }
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

event PostBeginPlay()
{
    BasePerformanceCapture.InitializePerformanceCaptureSettings();
    CollectCharacterPlacementsAndSkins();
    //return;    
}

// Export UTgCharacterPerformance::execCollectCharacterPlacementsAndSkins(FFrame&, void* const)
native final function CollectCharacterPlacementsAndSkins();

// Export UTgCharacterPerformance::execCollectAllSkins(FFrame&, void* const)
native final function CollectAllSkins();

// Export UTgCharacterPerformance::execMoveCameraToNode(FFrame&, void* const)
native final function MoveCameraToNode();

// Export UTgCharacterPerformance::execSpawnCharacters(FFrame&, void* const)
native final function SpawnCharacters();

// Export UTgCharacterPerformance::execSpawnBotByIdForPerformance(FFrame&, void* const)
native final function TgPawn SpawnBotByIdForPerformance(int nBotId, int nSkinId, int nHeadId, int nWeaponSkinId, Vector vLocation, Rotator rRotation);

// Export UTgCharacterPerformance::execDoNextAction(FFrame&, void* const)
native final function DoNextAction();

// Export UTgCharacterPerformance::execPrintAllSkins(FFrame&, void* const)
native final function PrintAllSkins();

defaultproperties
{
    // Reference: PComPerformanceCaptureBase'TgGame.Default__TgCharacterPerformance.MyPerformanceBase'
    begin object name="MyPerformanceBase" class=PlatformCommon.PComPerformanceCaptureBase
    end object
    BasePerformanceCapture=MyPerformanceBase
    // Reference: TgManifestGroup'TgGame.Default__TgCharacterPerformance.ManifestGroup0'
    begin object name="ManifestGroup0" class=TgGame.TgManifestGroup
    end object
    ManifestGroup=ManifestGroup0
    HUDType=none
}