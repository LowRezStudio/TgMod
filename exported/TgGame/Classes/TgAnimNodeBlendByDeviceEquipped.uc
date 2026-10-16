class TgAnimNodeBlendByDeviceEquipped extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() int m_DeviceId;
var TgPawn m_TgPawn;

// Export UTgAnimNodeBlendByDeviceEquipped::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
    NodeName="DeviceEquippedBlendNode"
}