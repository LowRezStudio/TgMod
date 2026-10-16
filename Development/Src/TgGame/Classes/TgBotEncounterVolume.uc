class TgBotEncounterVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var (BotFactory) const array<TgBotFactory> m_Factories;
var int m_nPlayers;

simulated function PostBeginPlay() { }

function CheckTouching() { }

defaultproperties
{}
