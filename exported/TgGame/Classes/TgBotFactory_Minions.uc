class TgBotFactory_Minions extends TgBotFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement);

enum MinionFactoryType
{
    MFT_Conquest,                   // 0
    MFT_Joust,                      // 1
    MFT_Assault,                    // 2
    MFT_Mayan,                      // 3
    MFT_Other,                      // 4
    MFT_MAX                         // 5
};

var() TgBotFactory_Minions.MinionFactoryType m_eFactoryType;
var transient bool m_OverrideShouldSpawnSuperMinions;
var transient int m_nWaveNumber;
var transient int m_nLastBonusWave;
var transient int m_nLanePushersInQueue;
var transient float m_fLastBonusActivationTime;
var transient float m_fSuperMinionEndTime;

// Export UTgBotFactory_Minions::execSetSuperMinionsActive(FFrame&, void* const)
native function SetSuperMinionsActive(float fSeconds);

// Export UTgBotFactory_Minions::execShouldSpawnSuperMinions(FFrame&, void* const)
native function bool ShouldSpawnSuperMinions();

// Export UTgBotFactory_Minions::execShouldSpawnBonusMinions(FFrame&, void* const)
native function bool ShouldSpawnBonusMinions();

// Export UTgBotFactory_Minions::execBuildQueue(FFrame&, void* const)
native function BuildQueue();

// Export UTgBotFactory_Minions::execBotDied(FFrame&, void* const)
native function BotDied(TgPawn Pawn, TgAIController aic);

defaultproperties
{
    m_eFactoryType=MinionFactoryType.MFT_Other
    bUseSmiteStaggerSpawning=true
    bSpawnAsSquad=true
    m_SquadClass=Class'TgGame.TgAISquad_Minion'
    // Reference: TgStaticMeshComponent'TgGame.Default__TgBotFactory_Minions.RespawnIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RespawnIndicator'
    // Archetype: TgStaticMeshComponent'TgGame.Default__TgBotFactory.RespawnIndicator'
    begin object name="RespawnIndicator"
        ReplacementPrimitive=none
    end object
    m_RespawnIndicator=RespawnIndicator
    // Reference: SpriteComponent'TgGame.Default__TgBotFactory_Minions.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    // Archetype: SpriteComponent'TgGame.Default__TgBotFactory.WorldIcon'
    begin object name="WorldIcon"
        ReplacementPrimitive=none
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=WorldIcon
    Components[2]=none
    Components[3]=RespawnIndicator
    Components[4]=none
}