class TgEffectForm_DisablePawn extends TgEffectForm
    native(Effects)
    config(Engine);

var bool m_bPauseAnims;

native function ShowEffectForm(bool bLocal);  // Export UTgEffectForm_DisablePawn::execShowEffectForm(FFrame&, void* const)

native function HideEffectForm();  // Export UTgEffectForm_DisablePawn::execHideEffectForm(FFrame&, void* const)

defaultproperties
{
    m_bPauseAnims=true
}
