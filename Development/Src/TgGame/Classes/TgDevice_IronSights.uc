class TgDevice_IronSights extends TgDevice_ToggleWithLockout
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

var TgDevice_ViktorInhand m_CachedViktorInhand;
var bool m_bDelayMoveSpeedPenalty;
var bool m_bIsZoomed;
var TgDevice_Hustle m_CachedHustleDevice;

native function bool ShouldAltFireOnTick();  // Export UTgDevice_IronSights::execShouldAltFireOnTick(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_IronSights::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_IronSights::execCanDeviceFireNow(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated function bool IsPlayerToggleZoomSet() { }

simulated function CompleteInterrupt() { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

state DeviceFiring {}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
    m_nLinkedDeviceTypes[2]=11041
    m_nLinkedDeviceTypes[3]=11070
    m_nLinkedDeviceTypes[4]=15052
    m_nLinkedDeviceTypes[5]=11077
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=3
}
