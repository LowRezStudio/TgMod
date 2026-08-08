class TgModifyPawnPropertiesVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var (Object) editconst int m_nMapObjectId;
var () bool m_bDisableJump;
var () bool m_bDisableBlockActors;
var () bool m_bDisableHanging;
var () bool m_bDisableAllDevices;
var () bool m_bTriggerUseEvent;
var () bool m_bOneWayMovement;
var Rotator m_vOnewWay;
var export editinline ArrowComponent m_DirArrow;
var () int s_nLootTableId;

native function LoadObjectConfig();  // Export UTgModifyPawnPropertiesVolume::execLoadObjectConfig(FFrame&, void* const)

native function Used(Actor Other);  // Export UTgModifyPawnPropertiesVolume::execUsed(FFrame&, void* const)

event PostBeginPlay() { }

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

defaultproperties
{}
