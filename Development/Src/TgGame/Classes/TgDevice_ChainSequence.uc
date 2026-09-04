class TgDevice_ChainSequence extends TgDevice
    abstract
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var int m_nChainCount;
var float m_fChainResetTimer;
var const float m_fChainResetDuration;

simulated event int GetChainMax() { }

simulated function FireAmmunition() { }

simulated function UpdateDesiredFireMode() { }

simulated event OnChainReset() { }

defaultproperties
{
    m_fChainResetDuration=5.0000000
}
