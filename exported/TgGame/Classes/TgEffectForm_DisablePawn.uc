class TgEffectForm_DisablePawn extends TgEffectForm
    native(Effects);

var bool m_bPauseAnims;

// Export UTgEffectForm_DisablePawn::execShowEffectForm(FFrame&, void* const)
native function ShowEffectForm(bool bLocal);

// Export UTgEffectForm_DisablePawn::execHideEffectForm(FFrame&, void* const)
native function HideEffectForm();

defaultproperties
{
    m_bPauseAnims=true
}