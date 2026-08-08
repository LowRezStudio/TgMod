class TgBotFactory_Minions extends TgBotFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement)
    config(Engine);

enum MinionFactoryType {
    MFT_Conquest,  // 0
    MFT_Joust,  // 1
    MFT_Assault,  // 2
    MFT_Mayan,  // 3
    MFT_Other,  // 4
};

var () TgBotFactory_Minions.MinionFactoryType m_eFactoryType;
var transient bool m_OverrideShouldSpawnSuperMinions;
var transient int m_nWaveNumber;
var transient int m_nLastBonusWave;
var transient int m_nLanePushersInQueue;
var transient float m_fLastBonusActivationTime;
var transient float m_fSuperMinionEndTime;

native function SetSuperMinionsActive(float fSeconds);  // Export UTgBotFactory_Minions::execSetSuperMinionsActive(FFrame&, void* const)

native function bool ShouldSpawnSuperMinions();  // Export UTgBotFactory_Minions::execShouldSpawnSuperMinions(FFrame&, void* const)

native function bool ShouldSpawnBonusMinions();  // Export UTgBotFactory_Minions::execShouldSpawnBonusMinions(FFrame&, void* const)

native function BuildQueue();  // Export UTgBotFactory_Minions::execBuildQueue(FFrame&, void* const)

native function BotDied(TgPawn Pawn, TgAIController aic);  // Export UTgBotFactory_Minions::execBotDied(FFrame&, void* const)

defaultproperties
{}
