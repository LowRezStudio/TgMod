class TgEffectForm_Freeze extends TgEffectForm_DisablePawn
    native(Effects)
    config(Engine);

var int m_BurstingIceFXId;

native function HideEffectForm();  // Export UTgEffectForm_Freeze::execHideEffectForm(FFrame&, void* const)

defaultproperties
{
    m_BurstingIceFXId=1945
}
