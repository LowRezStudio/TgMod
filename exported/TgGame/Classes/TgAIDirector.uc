class TgAIDirector extends Actor
    native
    notplaceable
    hidecategories(Navigation);

const PRACTICE_DIFFICULTY_CONFIG_ID = 62;
const EASY_DIFFICULTY_CONFIG_ID = 63;
const MEDIUM_DIFFICULTY_CONFIG_ID = 64;
const HARD_DIFFICULTY_CONFIG_ID = 65;
const PRO_DIFFICULTY_CONFIG_ID = 66;

struct native SkillLevelRawData
{
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

    structdefaultproperties
    {
        NumDeaths=0.0000000
        Damage=0.0000000
        Kills=0.0000000
        SoloKills=0.0000000
        Assists=0.0000000
        Healing=0.0000000
        Credits=0.0000000
        Killstreak=0.0000000
        ObjectiveTime=0.0000000
        Shielding=0.0000000
    }
};

struct native SkillLevelPercentageData
{
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

    structdefaultproperties
    {
        NumDeathsPercentage=0.0000000
        DamagePercentage=0.0000000
        KillsPercentage=0.0000000
        SoloKillsPercentage=0.0000000
        AssistsPercentage=0.0000000
        HealingPercentage=0.0000000
        CreditsPercentage=0.0000000
        ObjectiveTimePercentage=0.0000000
        ShieldingPercentage=0.0000000
        KillstreakMultiplier=0.0000000
    }
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

// Export UTgAIDirector::execGetDamageForPawn(FFrame&, void* const)
native function int GetDamageForPawn(TgPawn TgP);

// Export UTgAIDirector::execGetObjectiveTimeForPawn(FFrame&, void* const)
native function int GetObjectiveTimeForPawn(TgPawn TgP);

// Export UTgAIDirector::execGetShieldingForPawn(FFrame&, void* const)
native function int GetShieldingForPawn(TgPawn TgP);

// Export UTgAIDirector::execGetLeadAccuracyFromConfigSet(FFrame&, void* const)
native function float GetLeadAccuracyFromConfigSet(int ConfigSetID);

// Export UTgAIDirector::execGetMissLikelihoodFromConfigSet(FFrame&, void* const)
native function float GetMissLikelihoodFromConfigSet(int ConfigSetID);

// Export UTgAIDirector::execGetDegreeMissedMagnitudeFromConfigSet(FFrame&, void* const)
native function float GetDegreeMissedMagnitudeFromConfigSet(int ConfigSetID);

event PostBeginPlay()
{
    local TgGame_Paladins ChaosGame;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;
    local int DifficultyDataIndex, RawDataIndex;

    super.PostBeginPlay();
    // End:0x4EC
    if(m_bActive)
    {
        ChaosGame = TgGame_Paladins(WorldInfo.Game);
        // End:0x2B3
        if(((ChaosGame != none) && int(ChaosGame.m_GameType) != int(36)) && int(ChaosGame.m_GameType) != int(37))
        {
            // End:0x240
            foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
            {
                TgP = TgPawn(TgAI.Pawn);
                // End:0x23F
                if((TgP != none) && TgP.IsGod())
                {
                    DifficultyDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
                    // End:0x23F
                    if((DifficultyDataIndex >= 0) && DifficultyDataIndex < 2)
                    {
                        TgAI.Difficulty = ChaosGame.DifficultyData[DifficultyDataIndex].CurrentBotDifficultyLevel;
                        UpdateBotDifficultyParameters(TgAI, ChaosGame.DifficultyData[DifficultyDataIndex].CurrentBotDifficultyLevel);
                    }
                }                
            }            
            // End:0x2B3
            if((int(ChaosGame.m_GameType) == int(26)) || int(ChaosGame.m_GameType) == int(27))
            {
                m_fBaseUpperPayloadRate = 0.0035000;
                m_fBaseLowerPayloadRate = 0.0015000;
            }
        }
        RawDataIndex = 0;
        J0x2BE:

        // End:0x4EC [Loop If]
        if(RawDataIndex < 2)
        {
            PlayerSkillData[RawDataIndex].NumDeaths = 0.0000000;
            PlayerSkillData[RawDataIndex].Damage = 0.0000000;
            PlayerSkillData[RawDataIndex].Kills = 0.0000000;
            PlayerSkillData[RawDataIndex].ObjectiveTime = 0.0000000;
            PlayerSkillData[RawDataIndex].Shielding = 0.0000000;
            PlayerSkillData[RawDataIndex].Healing = 0.0000000;
            TeamSkillData[RawDataIndex].NumDeaths = 0.0000000;
            TeamSkillData[RawDataIndex].Damage = 0.0000000;
            TeamSkillData[RawDataIndex].Kills = 0.0000000;
            TeamSkillData[RawDataIndex].ObjectiveTime = 0.0000000;
            TeamSkillData[RawDataIndex].Shielding = 0.0000000;
            TeamSkillData[RawDataIndex].Healing = 0.0000000;
            RawDataIndex++;
            // [Loop Continue]
            goto J0x2BE;
        }
    }
    //return;    
}

event Tick(float DeltaTime)
{
    local TgGame_Paladins ChaosGame;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;

    super.Tick(DeltaTime);
    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    // End:0xFC
    if(((m_bActive && ChaosGame != none) && int(ChaosGame.m_GameType) != int(36)) && int(ChaosGame.m_GameType) != int(37))
    {
        m_fTimeSinceLastUpdate += DeltaTime;
        // End:0xFC
        if(m_fTimeSinceLastUpdate >= UpdateRate)
        {
            m_fTimeSinceLastUpdate = 0.0000000;
            UpdateDifficulty();
        }
    }
    // End:0x240
    if(((m_bActive && ChaosGame != none) && int(ChaosGame.m_GameType) == int(36)) && int(ChaosGame.m_GameType) != int(37))
    {
        // End:0x23F
        foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
        {
            TgP = TgPawn(TgAI.Pawn);
            // End:0x23E
            if((TgP != none) && TgP.IsGod())
            {
                TgAI.Difficulty = 5;
                UpdateBotDifficultyParameters(TgAI, 5);
            }            
        }        
    }
    //return;    
}

function SetActive(bool NewActive)
{
    local TgGame_Paladins ChaosGame;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;
    local int DifficultyDataIndex;

    // End:0x286
    if(NewActive && !m_bActive)
    {
        ChaosGame = TgGame_Paladins(WorldInfo.Game);
        // End:0x248
        if(((ChaosGame != none) && int(ChaosGame.m_GameType) != int(36)) && int(ChaosGame.m_GameType) != int(37))
        {
            // End:0x247
            foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
            {
                TgP = TgPawn(TgAI.Pawn);
                // End:0x246
                if((TgP != none) && TgP.IsGod())
                {
                    DifficultyDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
                    // End:0x246
                    if((DifficultyDataIndex >= 0) && DifficultyDataIndex < 2)
                    {
                        TgAI.Difficulty = ChaosGame.DifficultyData[DifficultyDataIndex].CurrentBotDifficultyLevel;
                        UpdateBotDifficultyParameters(TgAI, ChaosGame.DifficultyData[DifficultyDataIndex].CurrentBotDifficultyLevel);
                    }
                }                
            }            
        }
        // End:0x277
        if(!m_bCanAdjustNow)
        {
            m_bCanAdjustNow = true;
            ClearTimer('ReallowAdjustment');
        }
        m_bActive = true;        
    }
    else
    {
        // End:0x2B0
        if(!NewActive && m_bActive)
        {
            m_bActive = false;
        }
    }
    //return;    
}

function UpdateDifficulty()
{
    local int RawDataIndex;
    local TgAIController_BehaviorGod TgAI;
    local TgPlayerController TgPC;
    local TgPawn TgP;
    local TgGame_Paladins ChaosGame;
    local bool hasBots;

    // End:0xDA
    if(m_bFreezeAIDifficulty)
    {
        // End:0xD7
        foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
        {
            TgP = TgPawn(TgAI.Pawn);
            // End:0xD6
            if((TgP != none) && TgP.IsGod())
            {
                UpdateBotDifficultyParameters(TgAI, TgAI.Difficulty);
            }            
        }        
        return;
    }
    hasBots = false;
    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    // End:0x1BC
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        // End:0x1BB
        if((TgP != none) && TgP.IsGod())
        {
            hasBots = true;
        }        
    }    
    // End:0x276
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgP = TgPawn(TgPC.Pawn);
        // End:0x275
        if((((TgP != none) && TgP.IsGod()) && ChaosGame != none) && hasBots)
        {
        }        
    }    
    // End:0x424
    if((m_iTaskForce1PlayerCount > 0) && m_iTaskForce2PlayerCount > 0)
    {
        // End:0x420
        foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
        {
            TgP = TgPawn(TgAI.Pawn);
            // End:0x41F
            if((TgP != none) && TgP.IsGod())
            {
                TgAI.Difficulty = 3;
                UpdateBotDifficultyParameters(TgAI, 3);
                // End:0x41E
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {
                    TgP = TgPawn(TgPC.Pawn);
                    // End:0x41D
                    if((((TgP != none) && TgP.IsGod()) && ChaosGame != none) && hasBots)
                    {
                    }                    
                }                
            }            
        }                
    }
    else
    {
        // End:0x1052
        if(m_bCanAdjustNow)
        {
            PullRawData();
            CheckDisparity();
            // End:0x1052
            if(m_bDisparityDetected)
            {
                // End:0x4A5
                if(AdjustDifficulty())
                {
                    m_bCanAdjustNow = false;
                    SetTimer(LockoutTime, false, 'ReallowAdjustment');
                    // End:0x4A5
                    if(UpdateRate < 30.0000000)
                    {
                        UpdateRate += 5.0000000;
                    }
                }
                m_bDisparityDetected = false;
                m_bProlongedDisparityDetected = false;
                m_iIncreaseTF1Difficulty = 0;
                m_iIncreaseTF2Difficulty = 0;
                RawDataIndex = 0;
                J0x4DE:

                // End:0x8F8 [Loop If]
                if(RawDataIndex < 2)
                {
                    OldPlayerSkillData[RawDataIndex].NumDeaths = -PlayerSkillData[RawDataIndex].NumDeaths / float(2);
                    OldPlayerSkillData[RawDataIndex].Damage = -PlayerSkillData[RawDataIndex].Damage / float(2);
                    OldPlayerSkillData[RawDataIndex].Kills = -PlayerSkillData[RawDataIndex].Kills / float(2);
                    OldPlayerSkillData[RawDataIndex].ObjectiveTime = -PlayerSkillData[RawDataIndex].ObjectiveTime / float(2);
                    OldPlayerSkillData[RawDataIndex].Shielding = -PlayerSkillData[RawDataIndex].Shielding / float(2);
                    OldPlayerSkillData[RawDataIndex].Healing = -PlayerSkillData[RawDataIndex].Healing / float(2);
                    OldTeamSkillData[RawDataIndex].NumDeaths = -TeamSkillData[RawDataIndex].NumDeaths / float(2);
                    OldTeamSkillData[RawDataIndex].Damage = -TeamSkillData[RawDataIndex].Damage / float(2);
                    OldTeamSkillData[RawDataIndex].Kills = -TeamSkillData[RawDataIndex].Kills / float(2);
                    OldTeamSkillData[RawDataIndex].ObjectiveTime = -TeamSkillData[RawDataIndex].ObjectiveTime / float(2);
                    OldTeamSkillData[RawDataIndex].Shielding = -TeamSkillData[RawDataIndex].Shielding / float(2);
                    OldTeamSkillData[RawDataIndex].Healing = -TeamSkillData[RawDataIndex].Healing / float(2);
                    RawDataIndex++;
                    // [Loop Continue]
                    goto J0x4DE;
                }
                // End:0xD8F
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {
                    TgP = TgPawn(TgPC.Pawn);
                    // End:0xD8E
                    if((TgP != none) && TgP.IsGod())
                    {
                        RawDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
                        // End:0xD8E
                        if((RawDataIndex >= 0) && RawDataIndex < 2)
                        {
                            OldPlayerSkillData[RawDataIndex].NumDeaths += float(TgP.GetPRI().Deaths);
                            OldPlayerSkillData[RawDataIndex].Damage += float(GetDamageForPawn(TgP));
                            OldPlayerSkillData[RawDataIndex].Kills += float(TgP.GetPRI().r_Scores[1]);
                            OldPlayerSkillData[RawDataIndex].ObjectiveTime += float(GetObjectiveTimeForPawn(TgP));
                            OldPlayerSkillData[RawDataIndex].Shielding += float(GetShieldingForPawn(TgP));
                            OldPlayerSkillData[RawDataIndex].Healing += float(TgP.GetPRI().r_Scores[6]);
                            OldTeamSkillData[RawDataIndex].NumDeaths += float(TgP.GetPRI().Deaths);
                            OldTeamSkillData[RawDataIndex].Damage += float(GetDamageForPawn(TgP));
                            OldTeamSkillData[RawDataIndex].Kills += float(TgP.GetPRI().r_Scores[1]);
                            OldTeamSkillData[RawDataIndex].ObjectiveTime += float(GetObjectiveTimeForPawn(TgP));
                            OldTeamSkillData[RawDataIndex].Shielding += float(GetShieldingForPawn(TgP));
                            OldTeamSkillData[RawDataIndex].Healing += float(TgP.GetPRI().r_Scores[6]);
                        }
                    }                    
                }                
                // End:0x1051
                foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
                {
                    TgP = TgPawn(TgAI.Pawn);
                    // End:0x1050
                    if((TgP != none) && TgP.IsGod())
                    {
                        RawDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
                        // End:0x1050
                        if((RawDataIndex >= 0) && RawDataIndex < 2)
                        {
                            OldTeamSkillData[RawDataIndex].NumDeaths += float(TgP.GetPRI().Deaths);
                            OldTeamSkillData[RawDataIndex].Damage += float(GetDamageForPawn(TgP));
                            OldTeamSkillData[RawDataIndex].Kills += float(TgP.GetPRI().r_Scores[1]);
                            OldTeamSkillData[RawDataIndex].ObjectiveTime += float(GetObjectiveTimeForPawn(TgP));
                            OldTeamSkillData[RawDataIndex].Shielding += float(GetShieldingForPawn(TgP));
                            OldTeamSkillData[RawDataIndex].Healing += float(TgP.GetPRI().r_Scores[6]);
                        }
                    }                    
                }                
            }
        }
    }
    UpdateDebugInfo();
    //return;    
}

function PullRawData()
{
    local TgPlayerController TgPC;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;
    local int RawDataIndex;

    RawDataIndex = 0;
    J0x0B:

    // End:0x3DD [Loop If]
    if(RawDataIndex < 2)
    {
        PlayerSkillData[RawDataIndex].NumDeaths = -OldPlayerSkillData[RawDataIndex].NumDeaths;
        PlayerSkillData[RawDataIndex].Damage = -OldPlayerSkillData[RawDataIndex].Damage;
        PlayerSkillData[RawDataIndex].Kills = -OldPlayerSkillData[RawDataIndex].Kills;
        PlayerSkillData[RawDataIndex].ObjectiveTime = -OldPlayerSkillData[RawDataIndex].ObjectiveTime;
        PlayerSkillData[RawDataIndex].Shielding = -OldPlayerSkillData[RawDataIndex].Shielding;
        PlayerSkillData[RawDataIndex].Healing = -OldPlayerSkillData[RawDataIndex].Healing;
        TeamSkillData[RawDataIndex].NumDeaths = -OldTeamSkillData[RawDataIndex].NumDeaths;
        TeamSkillData[RawDataIndex].Damage = -OldTeamSkillData[RawDataIndex].Damage;
        TeamSkillData[RawDataIndex].Kills = -OldTeamSkillData[RawDataIndex].Kills;
        TeamSkillData[RawDataIndex].ObjectiveTime = -OldTeamSkillData[RawDataIndex].ObjectiveTime;
        TeamSkillData[RawDataIndex].Shielding = -OldTeamSkillData[RawDataIndex].Shielding;
        TeamSkillData[RawDataIndex].Healing = -OldTeamSkillData[RawDataIndex].Healing;
        RawDataIndex++;
        // [Loop Continue]
        goto J0x0B;
    }
    m_iTaskForce1PlayerCount = 0;
    m_iTaskForce2PlayerCount = 0;
    // End:0x49F
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgP = TgPawn(TgPC.Pawn);
        // End:0x49E
        if((TgP != none) && TgP.IsGod())
        {
            PullDataForPlayer(TgP);
        }        
    }    
    // End:0x54C
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        // End:0x54B
        if((TgP != none) && TgP.IsGod())
        {
            PullDataForBot(TgP);
        }        
    }    
    //return;    
}

function PullDataForPlayer(TgPawn TgP)
{
    local int RawDataIndex;

    RawDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
    // End:0x426
    if((RawDataIndex >= 0) && RawDataIndex < 2)
    {
        // End:0x6F
        if(RawDataIndex == 0)
        {
            m_iTaskForce1PlayerCount++;            
        }
        else
        {
            m_iTaskForce2PlayerCount++;
        }
        PlayerSkillData[RawDataIndex].NumDeaths += float(TgP.GetPRI().Deaths);
        PlayerSkillData[RawDataIndex].Damage += float(GetDamageForPawn(TgP));
        PlayerSkillData[RawDataIndex].Kills += float(TgP.GetPRI().r_Scores[1]);
        PlayerSkillData[RawDataIndex].ObjectiveTime += float(GetObjectiveTimeForPawn(TgP));
        PlayerSkillData[RawDataIndex].Shielding += float(GetShieldingForPawn(TgP));
        PlayerSkillData[RawDataIndex].Healing += float(TgP.GetPRI().r_Scores[6]);
        TeamSkillData[RawDataIndex].NumDeaths += float(TgP.GetPRI().Deaths);
        TeamSkillData[RawDataIndex].Damage += float(GetDamageForPawn(TgP));
        TeamSkillData[RawDataIndex].Kills += float(TgP.GetPRI().r_Scores[1]);
        TeamSkillData[RawDataIndex].ObjectiveTime += float(GetObjectiveTimeForPawn(TgP));
        TeamSkillData[RawDataIndex].Shielding += float(GetShieldingForPawn(TgP));
        TeamSkillData[RawDataIndex].Healing += float(TgP.GetPRI().r_Scores[6]);
    }
    //return;    
}

function PullDataForBot(TgPawn TgP)
{
    local int RawDataIndex;

    RawDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
    // End:0x24D
    if((RawDataIndex >= 0) && RawDataIndex < 2)
    {
        // End:0x24D
        if(TgP.GetPRI() != none)
        {
            TeamSkillData[RawDataIndex].NumDeaths += float(TgP.GetPRI().Deaths);
            TeamSkillData[RawDataIndex].Damage += float(GetDamageForPawn(TgP));
            TeamSkillData[RawDataIndex].Kills += float(TgP.GetPRI().r_Scores[1]);
            TeamSkillData[RawDataIndex].ObjectiveTime += float(GetObjectiveTimeForPawn(TgP));
            TeamSkillData[RawDataIndex].Shielding += float(GetShieldingForPawn(TgP));
            TeamSkillData[RawDataIndex].Healing += float(TgP.GetPRI().r_Scores[6]);
        }
    }
    //return;    
}

function bool CheckTeamStatsThreshold()
{
    // End:0x52
    if((TeamSkillData[0].Kills >= float(4)) || TeamSkillData[1].Kills >= float(4))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

function bool CheckParticipation(int tf)
{
    local float damageParticipation, killParticipation, objTimeParticipation, shieldingParticipation, healingParticipation;

    damageParticipation = PlayerSkillData[tf - 1].Damage / (TeamSkillData[tf - 1].Damage + 1.0000000);
    killParticipation = PlayerSkillData[tf - 1].Kills / (TeamSkillData[tf - 1].Kills + 1.0000000);
    objTimeParticipation = PlayerSkillData[tf - 1].ObjectiveTime / (TeamSkillData[tf - 1].ObjectiveTime + 1.0000000);
    shieldingParticipation = PlayerSkillData[tf - 1].Shielding / (TeamSkillData[tf - 1].Shielding + 1.0000000);
    healingParticipation = PlayerSkillData[tf - 1].Healing / (TeamSkillData[tf - 1].Healing + 1.0000000);
    // End:0x21C
    if((tf != 1) && tf != 2)
    {
        return false;
    }
    // End:0x266
    if((TeamSkillData[tf - 1].Damage >= 2000.0000000) && damageParticipation > 0.1500000)
    {
        return true;
    }
    // End:0x2AF
    if((TeamSkillData[tf - 1].Kills >= float(4)) && killParticipation > 0.1500000)
    {
        return true;
    }
    // End:0x2F9
    if((TeamSkillData[tf - 1].ObjectiveTime >= 30.0000000) && objTimeParticipation > 0.1500000)
    {
        return true;
    }
    // End:0x343
    if((TeamSkillData[tf - 1].Shielding >= 500.0000000) && shieldingParticipation > 0.1500000)
    {
        return true;
    }
    // End:0x38D
    if((TeamSkillData[tf - 1].Healing >= 300.0000000) && healingParticipation > 0.1500000)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

function CheckDisparity()
{
    local TgGame_Paladins ChaosGame;
    local TgPlayerController TgPC;
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;
    local TgRepInfo_Game TgGRI;
    local bool hasBots;
    local float killRatio, payloadProgressRate;
    local int attackingTaskForce;
    local float upperKillRatio, lowerKillRatio, upperPayloadRate, lowerPayloadRate;

    upperKillRatio = m_fBaseUpperKillRatio;
    lowerKillRatio = m_fBaseLowerKillRatio;
    upperPayloadRate = m_fBaseUpperPayloadRate;
    lowerPayloadRate = m_fBaseLowerPayloadRate;
    // End:0xF1
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        // End:0xF0
        if((TgP != none) && TgP.IsGod())
        {
            hasBots = true;
        }        
    }    
    // End:0x10F
    if(!hasBots)
    {
        m_bDisparityDetected = false;
        return;
    }
    // End:0x144
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {        
    }    
    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    // End:0x116F
    if(ChaosGame != none)
    {
        hasBots = false;
        TgGRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x116F
        if(!m_bDisparityDetected)
        {
            // End:0x116F
            if(CheckTeamStatsThreshold())
            {
                // End:0x651
                if((m_iTaskForce1PlayerCount > 0) && m_iTaskForce2PlayerCount == 0)
                {
                    // End:0x37D
                    if(((TgGRI.GetTaskForce(1).r_nScore - TgGRI.GetTaskForce(2).r_nScore) >= 2) || (TgGRI.GetTaskForce(2).r_nScore == 1) && (int(ChaosGame.m_GameType) == int(28)) || int(ChaosGame.m_GameType) == int(29))
                    {
                        upperKillRatio = 2.0000000;
                        lowerKillRatio = 0.8500000;
                        upperPayloadRate *= 1.3330000;
                        lowerPayloadRate *= 1.3330000;
                        // End:0x37C
                        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                        {                            
                        }                        
                    }
                    // End:0x47E
                    if(((TgGRI.GetTaskForce(2).r_nScore == 1) && !m_bHasLoweredDifficultyAtTie) && (int(ChaosGame.m_GameType) == int(28)) || int(ChaosGame.m_GameType) == int(29))
                    {
                        m_bDisparityDetected = true;
                        m_iIncreaseTF2Difficulty = -2;
                        m_bHasLoweredDifficultyAtTie = true;
                        // End:0x47D
                        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                        {                            
                        }                        
                    }
                    // End:0x567
                    if((TgGRI.GetTaskForce(2).r_nScore - TgGRI.GetTaskForce(1).r_nScore) >= 1)
                    {
                        upperKillRatio = 1.5000000;
                        lowerKillRatio = 0.6500000;
                        upperPayloadRate *= 0.6670000;
                        lowerPayloadRate *= 0.6670000;
                        // End:0x566
                        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                        {                            
                        }                        
                    }
                    // End:0x651
                    if((TgGRI.GetTaskForce(2).r_nScore - TgGRI.GetTaskForce(1).r_nScore) >= 2)
                    {
                        upperKillRatio = 1.3500000;
                        lowerKillRatio = 0.5500000;
                        upperPayloadRate *= 0.5000000;
                        lowerPayloadRate *= 0.5000000;
                        // End:0x650
                        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                        {                            
                        }                        
                    }
                }
                // End:0xA21
                if((m_iTaskForce2PlayerCount > 0) && m_iTaskForce1PlayerCount == 0)
                {
                    // End:0x6A6
                    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                    {                        
                    }                    
                    // End:0x7EF
                    if(((TgGRI.GetTaskForce(2).r_nScore - TgGRI.GetTaskForce(1).r_nScore) >= 2) || (TgGRI.GetTaskForce(1).r_nScore == 1) && (int(ChaosGame.m_GameType) == int(28)) || int(ChaosGame.m_GameType) == int(29))
                    {
                        upperKillRatio = 2.0000000;
                        lowerKillRatio = 0.8500000;
                        upperPayloadRate *= 1.3330000;
                        lowerPayloadRate *= 1.3330000;
                    }
                    // End:0x8B9
                    if(((TgGRI.GetTaskForce(1).r_nScore == 1) && !m_bHasLoweredDifficultyAtTie) && (int(ChaosGame.m_GameType) == int(28)) || int(ChaosGame.m_GameType) == int(29))
                    {
                        m_bDisparityDetected = true;
                        m_iIncreaseTF1Difficulty = -2;
                        m_bHasLoweredDifficultyAtTie = true;
                    }
                    // End:0x96D
                    if((TgGRI.GetTaskForce(1).r_nScore - TgGRI.GetTaskForce(2).r_nScore) >= 2)
                    {
                        upperKillRatio = 1.5000000;
                        lowerKillRatio = 0.6500000;
                        upperPayloadRate *= 0.6670000;
                        lowerPayloadRate *= 0.6670000;
                    }
                    // End:0xA21
                    if((TgGRI.GetTaskForce(1).r_nScore - TgGRI.GetTaskForce(2).r_nScore) >= 2)
                    {
                        upperKillRatio = 1.3500000;
                        lowerKillRatio = 0.5500000;
                        upperPayloadRate *= 0.5000000;
                        lowerPayloadRate *= 0.5000000;
                    }
                }
                killRatio = ((TeamSkillData[1].NumDeaths + PlayerSkillData[1].NumDeaths) + 1.0000000) / ((TeamSkillData[0].NumDeaths + PlayerSkillData[0].NumDeaths) + 1.0000000);
                // End:0xAEC
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {                    
                }                
                payloadProgressRate = (TgGRI.r_fPayloadProgressPercent - m_fLastPayloadPercent) / UpdateRate;
                m_fLastPayloadPercent = TgGRI.r_fPayloadProgressPercent;
                attackingTaskForce = -1;
                // End:0xBC6
                if(TgGRI.r_LanePusher != none)
                {
                    attackingTaskForce = int(TgGRI.r_LanePusher.GetTaskForceNumber());
                }
                // End:0xBE8
                if(attackingTaskForce == -1)
                {
                    m_fLastPayloadPercent = 0.0000000;
                }
                // End:0xF4C
                if((m_iTaskForce1PlayerCount > 0) && m_iTaskForce2PlayerCount == 0)
                {
                    // End:0xEEC
                    if(CheckParticipation(1))
                    {
                        // End:0xC7A
                        if(killRatio > upperKillRatio)
                        {
                            m_bDisparityDetected = true;
                            m_iIncreaseTF2Difficulty = 1;
                            // End:0xC79
                            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                            {                                
                            }                            
                        }
                        // End:0xCE2
                        if(killRatio < lowerKillRatio)
                        {
                            m_bDisparityDetected = true;
                            m_iIncreaseTF2Difficulty = -1;
                            // End:0xCE1
                            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                            {                                
                            }                            
                        }
                        // End:0xDDE
                        if((attackingTaskForce == 1) && ChaosGame.GetTimerCount('PayloadExpired') > UpdateRate)
                        {
                            // End:0xD86
                            if(payloadProgressRate < lowerPayloadRate)
                            {
                                m_iIncreaseTF2Difficulty = -1;
                                // End:0xD85
                                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                                {                                    
                                }                                
                            }
                            // End:0xDDE
                            if(payloadProgressRate > upperPayloadRate)
                            {
                                m_iIncreaseTF2Difficulty = 1;
                                // End:0xDDD
                                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                                {                                    
                                }                                
                            }
                        }
                        // End:0xEE9
                        if((attackingTaskForce == 2) && ChaosGame.GetTimerCount('PayloadExpired') > UpdateRate)
                        {
                            // End:0xE8A
                            if(payloadProgressRate > (upperPayloadRate * 0.7000000))
                            {
                                m_iIncreaseTF2Difficulty = -1;
                                // End:0xE89
                                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                                {                                    
                                }                                
                            }
                            // End:0xEE9
                            if(payloadProgressRate < (lowerPayloadRate * 0.7000000))
                            {
                                m_iIncreaseTF2Difficulty = 1;
                                // End:0xEE8
                                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                                {                                    
                                }                                
                            }
                        }                        
                    }
                    else
                    {
                        // End:0xF21
                        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                        {                            
                        }                        
                        m_bDisparityDetected = true;
                        m_iIncreaseTF1Difficulty = -1;
                        m_iIncreaseTF2Difficulty = -1;
                    }
                }
                // End:0xF81
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {                    
                }                
                // End:0x1131
                if((m_iTaskForce2PlayerCount > 0) && m_iTaskForce1PlayerCount == 0)
                {
                    // End:0x10D1
                    if(CheckParticipation(2))
                    {
                        // End:0xFDF
                        if(killRatio < lowerKillRatio)
                        {
                            m_bDisparityDetected = true;
                            m_iIncreaseTF1Difficulty = 1;
                        }
                        // End:0x1011
                        if(killRatio > upperKillRatio)
                        {
                            m_bDisparityDetected = true;
                            m_iIncreaseTF1Difficulty = -1;
                        }
                        // End:0x1069
                        if(attackingTaskForce == 2)
                        {
                            // End:0x1047
                            if(payloadProgressRate < lowerPayloadRate)
                            {
                                m_iIncreaseTF1Difficulty = -1;
                            }
                            // End:0x1069
                            if(payloadProgressRate < upperPayloadRate)
                            {
                                m_iIncreaseTF1Difficulty = 1;
                            }
                        }
                        // End:0x10CE
                        if(attackingTaskForce == 1)
                        {
                            // End:0x10A5
                            if(payloadProgressRate > (upperPayloadRate * 0.7000000))
                            {
                                m_iIncreaseTF1Difficulty = -1;
                            }
                            // End:0x10CE
                            if(payloadProgressRate < (lowerPayloadRate * 0.7000000))
                            {
                                m_iIncreaseTF1Difficulty = 1;
                            }
                        }                        
                    }
                    else
                    {
                        m_bDisparityDetected = true;
                        m_iIncreaseTF1Difficulty = -1;
                        m_iIncreaseTF2Difficulty = -1;
                        // End:0x1130
                        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                        {                            
                        }                        
                    }
                }
                // End:0x116F
                if(m_bDisparityDetected)
                {
                    // End:0x116F
                    if(UpdateRate <= 20.0000000)
                    {
                        m_iIncreaseTF1Difficulty *= float(2);
                        m_iIncreaseTF2Difficulty *= float(2);
                    }
                }
            }
        }
    }
    //return;    
}

function bool AdjustDifficulty()
{
    local TgGame_Paladins ChaosGame;
    local TgAIController_BehaviorGod TgAI;
    local TgPlayerController TgPC;
    local TgPawn TgP;
    local int DifficultyDataIndex;
    local bool AdjustmentMade, hasBots;
    local int newDifficultyTF1, newDifficultyTF2;

    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    AdjustmentMade = false;
    // End:0x9FF
    if(ChaosGame != none)
    {
        newDifficultyTF1 = Clamp(int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) + m_iIncreaseTF1Difficulty, 0, 6);
        newDifficultyTF2 = Clamp(int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) + m_iIncreaseTF2Difficulty, 0, 6);
        ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel = byte(newDifficultyTF1);
        ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel = byte(newDifficultyTF2);
        AdjustmentMade = true;
        // End:0x9FF
        if(AdjustmentMade)
        {
            // End:0x278
            if((m_iIncreaseTF1Difficulty > 0) && int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) > (int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) + int(2)))
            {
                ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel = byte(int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) - int(2));
            }
            // End:0x36F
            if((m_iIncreaseTF2Difficulty > 0) && int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) > (int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) + int(2)))
            {
                ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel = byte(int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) - int(2));
            }
            // End:0x466
            if((m_iIncreaseTF1Difficulty < 0) && int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) < (int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) - int(1)))
            {
                ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel = byte(int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) + int(1));
            }
            // End:0x55D
            if((m_iIncreaseTF2Difficulty < 0) && int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) < (int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) - int(1)))
            {
                ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel = byte(int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) + int(1));
            }
            // End:0x653
            if(((int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) > int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel)) && int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel) == int(3)) && m_iTaskForce1PlayerCount > 0)
            {
                ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel = 3;
            }
            // End:0x749
            if(((int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) > int(ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel)) && int(ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel) == int(3)) && m_iTaskForce2PlayerCount > 0)
            {
                ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel = 3;
            }
            hasBots = false;
            // End:0x8F4
            foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
            {
                TgP = TgPawn(TgAI.Pawn);
                // End:0x8F3
                if((TgP != none) && TgP.IsGod())
                {
                    hasBots = true;
                    DifficultyDataIndex = int(TgP.GetTaskForceNumber()) - int(1);
                    // End:0x8F3
                    if((DifficultyDataIndex >= 0) && DifficultyDataIndex < 2)
                    {
                        TgAI.Difficulty = ChaosGame.DifficultyData[DifficultyDataIndex].CurrentBotDifficultyLevel;
                        UpdateBotDifficultyParameters(TgAI, ChaosGame.DifficultyData[DifficultyDataIndex].CurrentBotDifficultyLevel);
                    }
                }                
            }            
            // End:0x9FC
            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
            {
                TgP = TgPawn(TgPC.Pawn);
                // End:0x9FB
                if((((TgP != none) && TgP.IsGod()) && ChaosGame != none) && hasBots)
                {
                    // End:0x9D5
                    if(TgPC.GetTaskForceNumber() == 1)
                    {
                        // End:0x9FB
                        continue;
                    }
                    // End:0x9FB
                    if(TgPC.GetTaskForceNumber() == 2)
                    {
                    }
                }                
            }            
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function UpdateBotDifficultyParameters(TgAIController_BehaviorGod TgAI, TgAIController_Behavior.EBotDifficultyLevel NewDifficulty)
{
    switch(NewDifficulty)
    {
        // End:0x87
        case 0:
            TgAI.m_fLeadAccuracy = 0.2000000;
            TgAI.m_fMissLikelihood = 0.9500000;
            TgAI.m_fDegreeMissedMagnitude = 35.0000000;
            // End:0x49E
            break;
        // End:0xFB
        case 1:
            TgAI.m_fLeadAccuracy = 0.2000000;
            TgAI.m_fMissLikelihood = 0.7500000;
            TgAI.m_fDegreeMissedMagnitude = 30.0000000;
            // End:0x49E
            break;
        // End:0x16F
        case 2:
            TgAI.m_fLeadAccuracy = 0.2500000;
            TgAI.m_fMissLikelihood = 0.6500000;
            TgAI.m_fDegreeMissedMagnitude = 25.0000000;
            // End:0x49E
            break;
        // End:0x1E3
        case 3:
            TgAI.m_fLeadAccuracy = 0.3000000;
            TgAI.m_fMissLikelihood = 0.5000000;
            TgAI.m_fDegreeMissedMagnitude = 20.0000000;
            // End:0x49E
            break;
        // End:0x257
        case 4:
            TgAI.m_fLeadAccuracy = 0.3500000;
            TgAI.m_fMissLikelihood = 0.4500000;
            TgAI.m_fDegreeMissedMagnitude = 15.0000000;
            // End:0x49E
            break;
        // End:0x2CB
        case 5:
            TgAI.m_fLeadAccuracy = 0.4000000;
            TgAI.m_fMissLikelihood = 0.4500000;
            TgAI.m_fDegreeMissedMagnitude = 12.5000000;
            // End:0x49E
            break;
        // End:0x33F
        case 6:
            TgAI.m_fLeadAccuracy = 0.4500000;
            TgAI.m_fMissLikelihood = 0.3500000;
            TgAI.m_fDegreeMissedMagnitude = 10.0000000;
            // End:0x49E
            break;
        // End:0x3B3
        case 7:
            TgAI.m_fLeadAccuracy = 0.5000000;
            TgAI.m_fMissLikelihood = 0.2000000;
            TgAI.m_fDegreeMissedMagnitude = 5.0000000;
            // End:0x49E
            break;
        // End:0x427
        case 8:
            TgAI.m_fLeadAccuracy = 0.6000000;
            TgAI.m_fMissLikelihood = 0.1000000;
            TgAI.m_fDegreeMissedMagnitude = 3.0000000;
            // End:0x49E
            break;
        // End:0x49B
        case 9:
            TgAI.m_fLeadAccuracy = 1.0000000;
            TgAI.m_fMissLikelihood = 0.1000000;
            TgAI.m_fDegreeMissedMagnitude = 0.0000000;
            // End:0x49E
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

function ReallowAdjustment()
{
    m_bCanAdjustNow = true;
    //return;    
}

function UpdateDebugInfo()
{
    local TgGame_Paladins ChaosGame;
    local TgRepInfo_Game GRI;

    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x5DF
    if((ChaosGame != none) && GRI != none)
    {
        GRI.r_DifficultyDebugData.CurrentlyActive = m_bActive;
        GRI.r_DifficultyDebugData.SkillPercentages[0] = SkillPercentages[0];
        GRI.r_DifficultyDebugData.SkillPercentages[1] = SkillPercentages[1];
        // End:0x40C
        if(m_bActive)
        {
            GRI.r_DifficultyDebugData.DisparityDetected = m_bDisparityDetected;
            GRI.r_DifficultyDebugData.ChangesLockedOut = !m_bCanAdjustNow;
            // End:0x242
            if(m_bDisparityDetected)
            {
                GRI.r_DifficultyDebugData.TimeBeforeTrigger = int(float(m_iTriggerTime) - (WorldInfo.TimeSeconds - float(m_iDisparityDetectionTime)));                
            }
            else
            {
                GRI.r_DifficultyDebugData.TimeBeforeTrigger = 0;
            }
            GRI.r_DifficultyDebugData.TaskForce1BotDifficulty = ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel;
            GRI.r_DifficultyDebugData.TaskForce2BotDifficulty = ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel;
            GRI.r_DifficultyDebugData.TaskForce1Skill = ChaosGame.DifficultyData[0].TeamSkillLevel;
            GRI.r_DifficultyDebugData.TaskForce2Skill = ChaosGame.DifficultyData[1].TeamSkillLevel;            
        }
        else
        {
            GRI.r_DifficultyDebugData.DisparityDetected = false;
            GRI.r_DifficultyDebugData.ChangesLockedOut = false;
            GRI.r_DifficultyDebugData.TimeBeforeTrigger = 0;
            GRI.r_DifficultyDebugData.TaskForce1BotDifficulty = ChaosGame.DifficultyData[0].CurrentBotDifficultyLevel;
            GRI.r_DifficultyDebugData.TaskForce2BotDifficulty = ChaosGame.DifficultyData[1].CurrentBotDifficultyLevel;
            GRI.r_DifficultyDebugData.TaskForce1Skill = 0.0000000;
            GRI.r_DifficultyDebugData.TaskForce2Skill = 0.0000000;
        }
    }
    //return;    
}

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