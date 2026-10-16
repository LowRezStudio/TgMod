class TgActorFactory extends Actor
    abstract
    native(Factory)
    notplaceable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display)
    config(Engine)
    dependson(TgObject);

enum eSelectionMethod {
    TGSM_RANDOM,  // 0
    TGSM_SEQUENTIAL,  // 1
};

var (Object) editconst int m_nMapObjectId;
var () bool s_bAutoSpawn;
var editconst int s_nTeamNumber;
var () byte s_nTaskForce;
var () TgObject.MinimapFactoryType m_MinimapType;
var () TgActorFactory.eSelectionMethod s_eSelectionMethod;
var int s_nSelectionListId;
var int s_nSelectedObjectId;
var int m_nSelectionListPropId;
var int s_nNameId;
var transient int s_nFactoryId;
var transient TgRepInfo_Factory m_FRI;
var Class<TgRepInfo_Factory> m_FRIClass;
var int s_nCurListIndex;
var () export editinline SpriteComponent m_WorldIconSprite;

native function LoadObjectConfig();  // Export UTgActorFactory::execLoadObjectConfig(FFrame&, void* const)

native function SpawnObject();  // Export UTgActorFactory::execSpawnObject(FFrame&, void* const)

native function CalcFactoryPlacement(Vector Extent, bool bCenterOnGround, out Vector OutLocation, out Rotator OutRotation);  // Export UTgActorFactory::execCalcFactoryPlacement(FFrame&, void* const)

native function SetTaskForceNumber(int nNewTaskForce);  // Export UTgActorFactory::execSetTaskForceNumber(FFrame&, void* const)

simulated function PreBeginPlay() { }

simulated function PostBeginPlay() { }

simulated function Destroyed() { }

defaultproperties
{}
