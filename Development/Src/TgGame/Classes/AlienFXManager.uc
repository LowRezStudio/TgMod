class AlienFXManager extends Object
    native
    config(Engine);

const PALADINS_COLOR_CYAN = 0x000fff;

const PALADINS_COLOR_BLUE = 0x195766;

const PALADINS_COLOR_DARK = 0x243745;

const PALADINS_COLOR_RED = 0xbe1e2d;

enum FXOverlay {
    FXO_NONE,  // 0
    FXO_MENU,  // 1
    FXO_CHESTOPENING,  // 2
    FXO_CHESTREVEAL,  // 3
    FXO_UNLOCKEDCHAMP,  // 4
    FXO_MATCHLOBBY,  // 5
    FXO_MATCHSETUP,  // 6
    FXO_GAMEPLAY,  // 7
    FXO_MATCHOVERTIME,  // 8
    FXO_MATCHVICTORY,  // 9
    FXO_MATCHDEFEAT,  // 10
    FXO_POINTVICTORY,  // 11
    FXO_POINTDEFEAT,  // 12
    FXO_ULT,  // 13
};

var bool m_bGood;
var bool m_bLoaded;
var int m_nChestRevealRarity;
var float m_fTransitionTimestamp;
var float m_fTimespan;
var float m_fFrequency;
var dword m_dwPrimaryColor;
var float m_fDecayLambda;
var float c_fUltHalflife;
var AlienFXManager.FXOverlay ePrevOverlay;
var AlienFXManager.FXOverlay eCurrOverlay;

native function Initialize();  // Export UAlienFXManager::execInitialize(FFrame&, void* const)

native function Close();  // Export UAlienFXManager::execClose(FFrame&, void* const)

native function OnChampionUnlocked();  // Export UAlienFXManager::execOnChampionUnlocked(FFrame&, void* const)

native function OnChestOpening();  // Export UAlienFXManager::execOnChestOpening(FFrame&, void* const)

native function OnMatchSoon(float fTimeLeft);  // Export UAlienFXManager::execOnMatchSoon(FFrame&, void* const)

native function OnMatchSetup(float fTimeLeft);  // Export UAlienFXManager::execOnMatchSetup(FFrame&, void* const)

native function OnMatchPoint(bool bWon);  // Export UAlienFXManager::execOnMatchPoint(FFrame&, void* const)

native function OnMatchOvertime();  // Export UAlienFXManager::execOnMatchOvertime(FFrame&, void* const)

native function OnMatchConcluded(bool bVictorious);  // Export UAlienFXManager::execOnMatchConcluded(FFrame&, void* const)

native function OnChestOpened(int nRarity);  // Export UAlienFXManager::execOnChestOpened(FFrame&, void* const)

native function SetOverlay(byte Type, optional bool bAlwaysTimestamp);  // Export UAlienFXManager::execSetOverlay(FFrame&, void* const)

native function UpdateOverlay(float DeltaTime);  // Export UAlienFXManager::execUpdateOverlay(FFrame&, void* const)

native function Start();  // Export UAlienFXManager::execStart(FFrame&, void* const)

native function Tick(float DeltaTime);  // Export UAlienFXManager::execTick(FFrame&, void* const)

native function float LongMorph(float fTime, float fFrequency);  // Export UAlienFXManager::execLongMorph(FFrame&, void* const)

native function float Breathe(float fTime, float fFrequency);  // Export UAlienFXManager::execBreathe(FFrame&, void* const)

native function float Decay(float fLevel, float fLambda);  // Export UAlienFXManager::execDecay(FFrame&, void* const)

native function Reset();  // Export UAlienFXManager::execReset(FFrame&, void* const)

defaultproperties
{
    c_fUltHalflife=1.0000000
}
