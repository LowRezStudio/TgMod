class TgInventoryManager extends InventoryManager
    native(Inventory)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

struct transient InventoryData {
    var init int nInvId;
    var init int nItemId;
    var init int nPower;
    var init int nInstanceCount;
    var init bool bBoundFlag;
    var init float fAcquiredDatetime;
    var init int nEquipSlotValueId;
    structdefaultproperties {}
};

var int r_ItemCount;
var int m_nPreviousDeviceInstanceId;
var bool m_bNeedsInvUpdate;
var Weapon m_PreviousWeapon;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetOwner) r_ItemCount;
}

native function RequestInventory();  // Export UTgInventoryManager::execRequestInventory(FFrame&, void* const)

native function TgDevice AddDevice(int nDeviceId, int nEquipPoint, optional TgDevice parentDevice, optional bool bReplaceIfOccupied, optional int nPower);  // Export UTgInventoryManager::execAddDevice(FFrame&, void* const)

native function RemoveDevice(TgInventoryObject_Device pInv);  // Export UTgInventoryManager::execRemoveDevice(FFrame&, void* const)

native function SwapDevices(TgInventoryObject_Device pInv, int nEquipPoint);  // Export UTgInventoryManager::execSwapDevices(FFrame&, void* const)

native function TgDevice GetDeviceByInstanceId(int nDeviceInstanceId);  // Export UTgInventoryManager::execGetDeviceByInstanceId(FFrame&, void* const)

native function TgInventoryObject GetInventoryById(int nInventoryId);  // Export UTgInventoryManager::execGetInventoryById(FFrame&, void* const)

native function TgInventoryObject GetInventoryByEquipPoint(TgObject.TG_EQUIP_POINT ePoint, int nItemType);  // Export UTgInventoryManager::execGetInventoryByEquipPoint(FFrame&, void* const)

native function TgInventoryObject GetInventoryByName(string sName);  // Export UTgInventoryManager::execGetInventoryByName(FFrame&, void* const)

native function bool IsValid();  // Export UTgInventoryManager::execIsValid(FFrame&, void* const)

native function SetInventoryDirty();  // Export UTgInventoryManager::execSetInventoryDirty(FFrame&, void* const)

native function ApplyAllPassiveItemEffects(bool bRemove);  // Export UTgInventoryManager::execApplyAllPassiveItemEffects(FFrame&, void* const)

native function TestShowInventory();  // Export UTgInventoryManager::execTestShowInventory(FFrame&, void* const)

native function InventoryCleanup();  // Export UTgInventoryManager::execInventoryCleanup(FFrame&, void* const)

simulated function PostBeginPlay() { }

event Destroyed() { }

reliable server event ServerTestShowInventory() { }

reliable server event ServerSetInventoryDirty() { }

simulated function SetPendingWeapon(Weapon DesiredWeapon) { }

reliable client function SetCurrentWeapon(Weapon DesiredWeapon) { }

reliable server event ServerSetCurrentWeapon(Weapon DesiredWeapon) { }

simulated function ChangedWeapon() { }

defaultproperties
{
    r_ItemCount=-1
    s_bThrottleNetRelevancy=true
    bAlwaysTick=true
}
