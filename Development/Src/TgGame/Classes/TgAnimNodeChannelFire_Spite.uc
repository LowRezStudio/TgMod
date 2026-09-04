class TgAnimNodeChannelFire_Spite extends TgAnimNodeChannelFire
    native(ChampDarklord)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgDevice_Spite);

var TgDevice_Spite.SpiteAnimState m_eAnimState;

native function EndChannel();  // Export UTgAnimNodeChannelFire_Spite::execEndChannel(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeChannelFire_Spite::execReplayAnim(FFrame&, void* const)

native function SetAnimState(TgDevice_Spite.SpiteAnimState animState);  // Export UTgAnimNodeChannelFire_Spite::execSetAnimState(FFrame&, void* const)

defaultproperties
{
    m_EquipPoint=EQP_OFFHAND_1
    Children=/* Array type was not detected. */
}
