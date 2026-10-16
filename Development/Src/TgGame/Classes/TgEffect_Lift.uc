class TgEffect_Lift extends TgEffect
    native(Effects)
    config(Engine);

var bool m_bApplyKnockup;
var bool m_bRemoveCripple;
var bool m_bRemoveRoot;
var float m_fZHeight;

native function bool ApplyEffect(Actor Target, optional ImpactInfo Impact, optional bool bLatent);  // Export UTgEffect_Lift::execApplyEffect(FFrame&, void* const)

native function TgEffect CloneEffect();  // Export UTgEffect_Lift::execCloneEffect(FFrame&, void* const)

native function Remove(Actor Target, optional bool bResetToFollow);  // Export UTgEffect_Lift::execRemove(FFrame&, void* const)

defaultproperties
{
    m_bRemoveCripple=true
    m_fZHeight=-99999.0000000
}
