class TgEffectForm_Freeze extends TgEffectForm_DisablePawn
    native(Effects);

var int m_BurstingIceFXId;

// Export UTgEffectForm_Freeze::execHideEffectForm(FFrame&, void* const)
native function HideEffectForm();

defaultproperties
{
    m_BurstingIceFXId=1945
}