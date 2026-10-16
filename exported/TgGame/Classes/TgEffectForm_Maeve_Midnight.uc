class TgEffectForm_Maeve_Midnight extends TgEffectForm
    native(ChampBlades);

var int m_nEndFXId;
var TgSpecialFx m_pEndFX;
var TgEmitter_CameraEffect m_pCameraEffect;
var float m_fEndFXKillTime;

// Export UTgEffectForm_Maeve_Midnight::execHideEffectForm(FFrame&, void* const)
native function HideEffectForm();

// Export UTgEffectForm_Maeve_Midnight::execKillEndFX(FFrame&, void* const)
native function KillEndFX();

defaultproperties
{
    m_nEndFXId=7588
    m_fEndFXKillTime=2.0000000
}