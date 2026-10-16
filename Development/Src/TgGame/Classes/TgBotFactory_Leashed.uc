class TgBotFactory_Leashed extends TgBotFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement)
    config(Engine);

var (Leashing) Vector LeashLocation;
var (Leashing) float LeashRange;
var (Leashing) Volume LeashVolume;

native function Actor SpawnBotAdjusted(SpawnQueueEntry Entry);  // Export UTgBotFactory_Leashed::execSpawnBotAdjusted(FFrame&, void* const)

defaultproperties
{}
