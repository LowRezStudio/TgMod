class TgAnimNodeChannelFire_Pounce extends TgAnimNodeChannelFire
    native(ChampBlades)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var bool m_bPounceHitSuccessful;

native function EndChannel();  // Export UTgAnimNodeChannelFire_Pounce::execEndChannel(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeChannelFire_Pounce::execReplayAnim(FFrame&, void* const)

defaultproperties
{
    m_EquipPoint=EQP_ALT_FIRE
    Children=/* Array type was not detected. */
}
