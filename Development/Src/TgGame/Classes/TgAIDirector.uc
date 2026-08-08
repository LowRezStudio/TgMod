class TgAIDirector extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine)
    dependson(TgAIController_Behavior);

const PRACTICE_DIFFICULTY_CONFIG_ID = 62;

const EASY_DIFFICULTY_CONFIG_ID = 63;

const MEDIUM_DIFFICULTY_CONFIG_ID = 64;

const HARD_DIFFICULTY_CONFIG_ID = 65;

const PRO_DIFFICULTY_CONFIG_ID = 66;

struct SkillLevelRawData {
    var float NumDeaths;
    var float Damage;
    var float Kills;
    var float SoloKills;
    var float Assists;
    var float Healing;
    var float Credits;
    var float Killstreak;
    var float ObjectiveTime;
    var float Shielding;
    structdefaultproperties {}
};

struct SkillLevelPercentageData {
    var float NumDeathsPercentage;
    var float DamagePercentage;
    var float KillsPercentage;
    var float SoloKillsPercentage;
    var float AssistsPercentage;
    var float HealingPercentage;
    var float CreditsPercentage;
    var float ObjectiveTimePercentage;
    var float ShieldingPercentage;
    var float KillstreakMultiplier;
    structdefaultproperties {}
};

var bool m_bActive;
var bool m_bCanAdjustNow;
var bool m_bDisparityDetected;
var bool m_bProlongedDisparityDetected;
var bool m_bHasLoweredDifficultyAtTie;
var bool m_bFreezeAIDifficulty;
var float m_fTimeSinceLastUpdate;
var float m_fLastSkillDisparity;
var int m_iIncreaseTF1Difficulty;
var int m_iIncreaseTF2Difficulty;
var int m_iDisparityDetectionTime;
var int m_iTriggerTime;
var int m_iTaskForce1PlayerCount;
var int m_iTaskForce2PlayerCount;
var float LockoutTime;
var float SkillDisparityTrigger;
var float UpdateRate;
var float m_fLastPayloadPercent;
var float m_fBaseUpperKillRatio;
var float m_fBaseLowerKillRatio;
var float m_fBaseUpperPayloadRate;
var float m_fBaseLowerPayloadRate;
var float NumDeaths_Weight;
var float Damage_Weight;
var float Kills_Weight;
var float SoloKills_Weight;
var float Assists_Weight;
var float ObjectiveTime_Weight;
var float Healing_Weight;
var float Shielding_Weight;
var float Credits_Weight;
var float Accuracy_Weight;
var float Killstreak_Multiplier;
var float numDeathsBase0;
var float numDeathsBase1;
var SkillLevelRawData PlayerSkillData[2];
var SkillLevelRawData TeamSkillData[2];
var SkillLevelRawData OldPlayerSkillData[2];
var SkillLevelRawData OldTeamSkillData[2];
var SkillLevelPercentageData SkillPercentages[4];

native function int GetDamageForPawn(TgPawn TgP);  // Export UTgAIDirector::execGetDamageForPawn(FFrame&, void* const)

native function int GetObjectiveTimeForPawn(TgPawn TgP);  // Export UTgAIDirector::execGetObjectiveTimeForPawn(FFrame&, void* const)

native function int GetShieldingForPawn(TgPawn TgP);  // Export UTgAIDirector::execGetShieldingForPawn(FFrame&, void* const)

native function float GetLeadAccuracyFromConfigSet(int ConfigSetID);  // Export UTgAIDirector::execGetLeadAccuracyFromConfigSet(FFrame&, void* const)

native function float GetMissLikelihoodFromConfigSet(int ConfigSetID);  // Export UTgAIDirector::execGetMissLikelihoodFromConfigSet(FFrame&, void* const)

native function float GetDegreeMissedMagnitudeFromConfigSet(int ConfigSetID);  // Export UTgAIDirector::execGetDegreeMissedMagnitudeFromConfigSet(FFrame&, void* const)

event PostBeginPlay() { }

event Tick(float DeltaTime) { }

function SetActive(bool NewActive) { }

function UpdateDifficulty() { }

function PullRawData() { }

function PullDataForPlayer(TgPawn TgP) { }

function PullDataForBot(TgPawn TgP) { }

function bool CheckTeamStatsThreshold() { }

function bool CheckParticipation(int tf) { }

function CheckDisparity() { }

function bool AdjustDifficulty() { }

function UpdateBotDifficultyParameters(TgAIController_BehaviorGod TgAI, TgAIController_Behavior.EBotDifficultyLevel NewDifficulty) { }

function ReallowAdjustment() { }

function UpdateDebugInfo() { }

defaultproperties
{
    m_bActive=true
    m_bCanAdjustNow=true
    m_iTriggerTime=5
    LockoutTime=15.0000000
    SkillDisparityTrigger=7.0000000
    UpdateRate=10.0000000
    m_fBaseUpperKillRatio=1.7500000
    m_fBaseLowerKillRatio=0.7500000
    m_fBaseUpperPayloadRate=0.0150000
    m_fBaseLowerPayloadRate=0.0050000
    NumDeaths_Weight=-1.0000000
}
