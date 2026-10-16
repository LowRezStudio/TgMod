class TgAnimBlendByFire extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native DeviceParameters
{
    var string SlotName;
    var() bool bShouldInterruptIfStopped;
    var() bool bShouldInterruptIfInterrupted;
    var() bool bShouldInterruptIfJumping;

    structdefaultproperties
    {
        SlotName=""
        bShouldInterruptIfStopped=false
        bShouldInterruptIfInterrupted=true
        bShouldInterruptIfJumping=true
    }
};

var(Device) bool m_bSetToIdleOnCeaseRelevant;
var(Device) bool m_bShouldReplayIfAlreadyActive;
var(Device) DeviceParameters m_InHandDeviceParameters;
var(Device) DeviceParameters m_OffHand1DeviceParameters;
var(Device) DeviceParameters m_OffHand2DeviceParameters;
var(Device) DeviceParameters m_OffHand3DeviceParameters;
var(Device) DeviceParameters m_OffHand4DeviceParameters;
var(Device) DeviceParameters m_RecallDeviceParameters;
var TgPawn m_OwningPawn;

// Export UTgAnimBlendByFire::execOnDeviceFormBuildup(FFrame&, void* const)
native function OnDeviceFormBuildup(TgDeviceForm DeviceForm, float BuildupTime);

// Export UTgAnimBlendByFire::execOnDeviceFormStartFire(FFrame&, void* const)
native function OnDeviceFormStartFire(TgDeviceForm DeviceForm, float FireDuration);

// Export UTgAnimBlendByFire::execOnDeviceFormStopFire(FFrame&, void* const)
native function OnDeviceFormStopFire(TgDeviceForm DeviceForm);

// Export UTgAnimBlendByFire::execOnDeviceFormInterruptFire(FFrame&, void* const)
native function OnDeviceFormInterruptFire(TgDeviceForm DeviceForm);

defaultproperties
{
    m_bShouldReplayIfAlreadyActive=true
    m_InHandDeviceParameters=(SlotName="In-hand",bShouldInterruptIfStopped=false,bShouldInterruptIfInterrupted=true,bShouldInterruptIfJumping=true)
    m_OffHand1DeviceParameters=(SlotName="Offhand 1",bShouldInterruptIfStopped=false,bShouldInterruptIfInterrupted=true,bShouldInterruptIfJumping=true)
    m_OffHand2DeviceParameters=(SlotName="Offhand 2",bShouldInterruptIfStopped=false,bShouldInterruptIfInterrupted=true,bShouldInterruptIfJumping=true)
    m_OffHand3DeviceParameters=(SlotName="Offhand 3",bShouldInterruptIfStopped=false,bShouldInterruptIfInterrupted=true,bShouldInterruptIfJumping=true)
    m_OffHand4DeviceParameters=(SlotName="Offhand 4",bShouldInterruptIfStopped=false,bShouldInterruptIfInterrupted=true,bShouldInterruptIfJumping=true)
    m_RecallDeviceParameters=(SlotName="Recall",bShouldInterruptIfStopped=false,bShouldInterruptIfInterrupted=true,bShouldInterruptIfJumping=true)
    DefaultBlendTime=0.2000000
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}