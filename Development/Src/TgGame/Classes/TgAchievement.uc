class TgAchievement extends Object
    native(Achievement)
    config(Engine);

const TGACHIEVEMENT_JUMP_JUMP_ACTIVITY_ID = 1933;

var TgPlayerController Controller;
var const bool m_bCustomValue3IsBotId;
var bool m_bAwardsAllowTriggering;
var int m_nBotId;
var int m_nActivityId;
var int m_nCustomValue1;
var int m_nCustomValue2;
var int m_nCustomValue3;
var int m_nCustomValue4;
var int m_nCustomValue5;
var int m_nCurrentProgress;
var int m_nCurrentTarget;

native function float GetCustomValue1();  // Export UTgAchievement::execGetCustomValue1(FFrame&, void* const)

native function float GetCustomValue2();  // Export UTgAchievement::execGetCustomValue2(FFrame&, void* const)

native function float GetCustomValue3();  // Export UTgAchievement::execGetCustomValue3(FFrame&, void* const)

native function float GetCustomValue4();  // Export UTgAchievement::execGetCustomValue4(FFrame&, void* const)

native function float GetCustomValue5();  // Export UTgAchievement::execGetCustomValue5(FFrame&, void* const)

native function bool BelongsToBot(int BotId);  // Export UTgAchievement::execBelongsToBot(FFrame&, void* const)

native function StopTracking();  // Export UTgAchievement::execStopTracking(FFrame&, void* const)
