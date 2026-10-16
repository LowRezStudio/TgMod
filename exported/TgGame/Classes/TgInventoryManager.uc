class TgInventoryManager extends InventoryManager
    native(Inventory)
    hidecategories(Navigation);

struct native transient InventoryData
{
    var init int nInvId;
    var init int nItemId;
    var init int nPower;
    var init int nInstanceCount;
    var init bool bBoundFlag;
    var init float fAcquiredDatetime;
    var init int nEquipSlotValueId;

    structdefaultproperties
    {
        nInvId=0
        nItemId=0
        nPower=0
        nInstanceCount=0
        bBoundFlag=false
        fAcquiredDatetime=0.0000000
        nEquipSlotValueId=0
    }
};

var int r_ItemCount;
var int m_nPreviousDeviceInstanceId;
var bool m_bNeedsInvUpdate;
var Weapon m_PreviousWeapon;
var init native map{VOID,VOID} m_InventoryMap;
var init native map{VOID,VOID} s_ReplicateMap;
var init native map{VOID,VOID} s_DeletionMap;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetOwner)
        r_ItemCount;
}

// Export UTgInventoryManager::execRequestInventory(FFrame&, void* const)
native function RequestInventory();

// Export UTgInventoryManager::execAddDevice(FFrame&, void* const)
native function TgDevice AddDevice(int nDeviceId, int nEquipPoint, optional TgDevice parentDevice, optional bool bReplaceIfOccupied, optional int nPower);

// Export UTgInventoryManager::execRemoveDevice(FFrame&, void* const)
native function RemoveDevice(TgInventoryObject_Device pInv);

// Export UTgInventoryManager::execSwapDevices(FFrame&, void* const)
native function SwapDevices(TgInventoryObject_Device pInv, int nEquipPoint);

// Export UTgInventoryManager::execGetDeviceByInstanceId(FFrame&, void* const)
native function TgDevice GetDeviceByInstanceId(int nDeviceInstanceId);

// Export UTgInventoryManager::execGetInventoryById(FFrame&, void* const)
native function TgInventoryObject GetInventoryById(int nInventoryId);

// Export UTgInventoryManager::execGetInventoryByEquipPoint(FFrame&, void* const)
native function TgInventoryObject GetInventoryByEquipPoint(TgObject.TG_EQUIP_POINT ePoint, int nItemType);

// Export UTgInventoryManager::execGetInventoryByName(FFrame&, void* const)
native function TgInventoryObject GetInventoryByName(string sName);

// Export UTgInventoryManager::execIsValid(FFrame&, void* const)
native function bool IsValid();

// Export UTgInventoryManager::execSetInventoryDirty(FFrame&, void* const)
native function SetInventoryDirty();

// Export UTgInventoryManager::execApplyAllPassiveItemEffects(FFrame&, void* const)
native function ApplyAllPassiveItemEffects(bool bRemove);

// Export UTgInventoryManager::execTestShowInventory(FFrame&, void* const)
native function TestShowInventory();

// Export UTgInventoryManager::execInventoryCleanup(FFrame&, void* const)
native function InventoryCleanup();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    Instigator = Pawn(Owner);
    // End:0x90
    if(((int(Role) != int(ROLE_Authority)) && WorldInfo != none) && !WorldInfo.IsPlayingDemo())
    {
        m_bNeedsInvUpdate = true;
        SetTimer(1.0000000, true, 'RequestInventory');
    }
    //return;    
}

event Destroyed()
{
    InventoryCleanup();
    super.Destroyed();
    //return;    
}

reliable server event ServerTestShowInventory()
{
    TestShowInventory();
    //return;    
}

reliable server event ServerSetInventoryDirty()
{
    SetInventoryDirty();
    //return;    
}

simulated function SetPendingWeapon(Weapon DesiredWeapon)
{
    local TgDevice PrevWeapon, CurrentPending;

    // End:0x3F
    if(Instigator == none)
    {
        // End:0x23
        if(Owner == none)
        {
            return;            
        }
        else
        {
            Instigator = Pawn(Owner);
        }
    }
    PrevWeapon = TgDevice(Instigator.Weapon);
    CurrentPending = TgDevice(PendingWeapon);
    // End:0x1EB
    if(((PrevWeapon == none) || PrevWeapon.AllowSwitchTo(DesiredWeapon)) && (CurrentPending == none) || CurrentPending.AllowSwitchTo(DesiredWeapon))
    {
        // End:0x19D
        if((DesiredWeapon != none) && DesiredWeapon == Instigator.Weapon)
        {
            // End:0x19A
            if(PendingWeapon != none)
            {
                PendingWeapon = none;
                TgDevice(Instigator.Weapon).CancelUnequip();
            }            
        }
        else
        {
            PendingWeapon = DesiredWeapon;
            // End:0x1E1
            if(PrevWeapon != none)
            {
                PrevWeapon.TryPutDown();                
            }
            else
            {
                ChangedWeapon();
            }
        }
    }
    //return;    
}

simulated function SetCurrentWeapon(TgDevice DesiredWeapon)
{
    SetPendingWeapon(DesiredWeapon);
    // End:0x3A
    if(int(Role) < int(ROLE_Authority))
    {
        ServerSetCurrentWeapon(DesiredWeapon);
    }
    //return;    
}

reliable server event ServerSetCurrentWeapon(TgDevice NewWeapon)
{
    SetCurrentWeapon(NewWeapon);
    //return;    
}

simulated function ChangedWeapon()
{
    m_PreviousWeapon = Instigator.Weapon;
    super.ChangedWeapon();
    //return;    
}

defaultproperties
{
    r_ItemCount=-1
    s_bThrottleNetRelevancy=true
    bAlwaysTick=true
}