class TgInventoryObject extends Object
    native(Inventory);

enum EReplicatedState
{
    IORS_Ok,                        // 0
    IORS_Edited,                    // 1
    IORS_Deleted,                   // 2
    IORS_MAX                        // 3
};

struct native sInventoryReq
{
    var bool m_bLevelFail;
    var bool m_bSkillFail;
    var int m_nSkillLevelReq;
    var int m_nSkillIdReq;
    var bool m_bFlairFail;
    var bool m_bLocationFail;

    structdefaultproperties
    {
        m_bLevelFail=false
        m_bSkillFail=false
        m_nSkillLevelReq=0
        m_nSkillIdReq=0
        m_bFlairFail=false
        m_bLocationFail=false
    }
};

var protected InventoryData m_InventoryData;
var int m_nRefData;
var TgInventoryManager m_InvManager;
var bool m_bTemporary;
var TgInventoryObject.EReplicatedState s_ReplicatedState;
var native const Pointer m_pAmItem;
var int c_nNbrAcquired;
var float c_fTimeAcquired;

// Export UTgInventoryObject::execIsUsableType(FFrame&, void* const)
native function bool IsUsableType();

// Export UTgInventoryObject::execIsEquippableType(FFrame&, void* const)
native function bool IsEquippableType();

// Export UTgInventoryObject::execGetInventoryData(FFrame&, void* const)
native function InventoryData GetInventoryData();

// Export UTgInventoryObject::execSetInstanceCount(FFrame&, void* const)
native function SetInstanceCount(int nInstanceCount);

// Export UTgInventoryObject::execGetInstanceCount(FFrame&, void* const)
native function int GetInstanceCount();

defaultproperties
{
    m_InventoryData=(nInvId=0,nItemId=0,nPower=0,nInstanceCount=1,bBoundFlag=false,fAcquiredDatetime=0.0000000,nEquipSlotValueId=0)
}