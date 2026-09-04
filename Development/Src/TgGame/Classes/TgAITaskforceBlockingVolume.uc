class TgAITaskforceBlockingVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int BlockTaskforce;
var bool m_bHasRegisteredObstacle;

native function RegisterObstacle();  // Export UTgAITaskforceBlockingVolume::execRegisterObstacle(FFrame&, void* const)

native function UnRegisterObstacle();  // Export UTgAITaskforceBlockingVolume::execUnRegisterObstacle(FFrame&, void* const)

event PostBeginPlay() { }

defaultproperties
{}
