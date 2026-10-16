class TgDeploy_Molotov extends TgDeploy_EffectSpots
    native(ChampTyra)
    placeable
    hidecategories(Navigation)
    config(Engine);

const MOLOTOV_CENTER_POINTS = 18;

const MOLOTOV_NO_NEIGHBOR = -1;

const MOLOTOV_BLOCK_NEIGHBOR = -2;

struct MolotovPointInfo {
    var Vector vLocation;
    var Rotator rRotation;
    var int nEffectSpotIndex;
    var float fHeatLevel;
    var array<int> nTriNeighbors;
    structdefaultproperties {}
};

struct MolotovCenterInfo {
    var int ChildrenFront[3];
    var int ChildrenFrontLeft[3];
    var int ChildrenFrontRight[3];
    var int ChildrenBack[3];
    var int ChildrenBackLeft[3];
    var int ChildrenBackRight[3];
    structdefaultproperties {}
};

struct MolotovTriangleInfo {
    var int index1;
    var int index2;
    var int index3;
    var int neighborIndex1;
    var int neighborIndex2;
    var int neighborIndex3;
    var int nRank;
    var float fHeatLevel;
    var Vector vTriCenter;
    var Vector vCenterDirection;
    structdefaultproperties {}
};

struct MolotovStrandInfo {
    var Vector vStartDirection;
    var float fAllowanceWeight;
    var int nHeadIndex;
    var int nAllowableSize;
    var array<int> nStrandTrace;
    structdefaultproperties {}
};

struct MolotovGrowthInfo {
    var int nStrandAllotment;
    var int nMaxSpots;
    var int nMaxInitialStrands;
    var float fStrandGrowthFraction;
    var bool bStrandsAreSaturated;
    var int nCenterGrowthVariance;
    var int nSpreadsPerTick;
    structdefaultproperties {}
};

struct MolotovGeneralSettings {
    var Vector vBiasDirection;
    var float fUpFactor;
    var const float fSpotRadius;
    var const float fSpotHeight;
    structdefaultproperties {}
};

struct MolotovEligibilityRecord {
    var bool bIsEligible;
    var Vector vLocation;
    var Vector vHitNormal;
    structdefaultproperties {}
};

var array<MolotovPointInfo> m_PointInfos;
var MolotovCenterInfo m_CenterInfo;
var array<MolotovTriangleInfo> m_TriInfos;
var array<MolotovStrandInfo> m_StrandInfos;
var MolotovGrowthInfo m_GrowthInfo;
var MolotovGeneralSettings m_Settings;

native function MolotovEligibilityRecord GetSpawnEligibility(Vector StartLocation, float Radius, float Height);  // Export UTgDeploy_Molotov::execGetSpawnEligibility(FFrame&, void* const)

native function RemoveEffects(Actor Target);  // Export UTgDeploy_Molotov::execRemoveEffects(FFrame&, void* const)

simulated event bool CheckItemShopVolumeFailure(Vector TestLocation) { }

simulated function Tick(float DeltaSeconds) { }

function CompleteSaturationLevel5Points() { }

function UpdateHeatLevels() { }

function float CalcHeatLevel(int triIndex) { }

function UpdateStrandAllowances() { }

function bool IsInStrand(int triIndex, int strandIndex) { }

function float GetStrandSpreadWeight(int strandNum, int neighborNum) { }

function PushStrandToTip(int strandNum) { }

function SpawnFromStrand(int strandNum) { }

function SpawnFromPeripheral() { }

function bool IsSaturated(int triIndex) { }

function SpawnFromCenter() { }

function Vector GetNewSpotLocation(int index1, int index2) { }

function int SpawnFromTriangle(int triIndex, optional int neighborNum=0) { }

function LinkNeighbors(int triIndex) { }

function UpdateAllRanks() { }

simulated event SetMomentumDirection(Vector projVelocity, Vector HitNormal) { }

function Rotator AlignSpotByRotation(Vector HitNormal, Rotator rRotation) { }

function int AddNewPoint(Vector vLocation, Rotator rRotation, bool bAddEffectSpot, optional bool bSkipEligibilityCheck=false) { }

function SetPointIntensity(int PointIndex, int nIntensityLevel) { }

simulated function DeployComplete() { }

function SpawnInitialCenter() { }

function SpawnInitialStrands() { }

function bool SpawnStrandFromCenter(int Region) { }

simulated function UpdateParticleParams(int spotIndex) { }

simulated event DestroyIt(optional bool bSkipFx) { }

defaultproperties
{}
