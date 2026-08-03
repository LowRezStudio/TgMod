class TgAnimNodeChannelFire_Pounce extends TgAnimNodeChannelFire
    native(ChampBlades)
    hidecategories(Object,Object,Object,Object);

var bool m_bPounceHitSuccessful;

// Export UTgAnimNodeChannelFire_Pounce::execEndChannel(FFrame&, void* const)
native function EndChannel();

// Export UTgAnimNodeChannelFire_Pounce::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    m_EquipPoint=TG_EQUIP_POINT.EQP_ALT_FIRE
    Children=/* Array type was not detected. */
}