class TgAnimNodeChannelFire_Spite extends TgAnimNodeChannelFire
    native(ChampDarklord)
    hidecategories(Object,Object,Object,Object);

var TgDevice_Spite.SpiteAnimState m_eAnimState;

// Export UTgAnimNodeChannelFire_Spite::execEndChannel(FFrame&, void* const)
native function EndChannel();

// Export UTgAnimNodeChannelFire_Spite::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

// Export UTgAnimNodeChannelFire_Spite::execSetAnimState(FFrame&, void* const)
native function SetAnimState(TgDevice_Spite.SpiteAnimState animState);

defaultproperties
{
    m_EquipPoint=TG_EQUIP_POINT.EQP_OFFHAND_1
    Children=/* Array type was not detected. */
}