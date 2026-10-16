class TgDestructibleFactory extends TgActorFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display)
    config(Engine);

var () const editconst export editinline LightEnvironmentComponent LightEnvironment;

native function SpawnObject();  // Export UTgDestructibleFactory::execSpawnObject(FFrame&, void* const)

defaultproperties
{}
