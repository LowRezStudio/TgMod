class TgLocalPlayer extends LocalPlayer within Engine
    transient
    native
    config(Engine);

var float m_fViewScale;
var Vector m_vViewPan;
var bool m_bEnableOutlineEffect;
var bool m_bEnableColorBlindEffect;
var bool m_bColorBlindSimulate;
var bool m_bBlurForeground;
var float m_fHitOnlyAlpha;
var float m_fHealthOnlyAlpha;
var float m_fHealthPPAlpha;
var float m_fDeathDesatPPAlpha;
var int m_eColorBlindEffectType;
var float m_fTargetBlurAmount;
var float m_fBlurAmount;
var float m_fBlurInterpSpeed;
var float m_fBlurKernelSize;
var DOFAndBloomEffect.EDOFType m_eCurrentDOFType;

// Export UTgLocalPlayer::execInitMaterialEffects(FFrame&, void* const)
native function InitMaterialEffects();

// Export UTgLocalPlayer::execEnableOutlineEffect(FFrame&, void* const)
native function EnableOutlineEffect(optional bool bEnable = true);

// Export UTgLocalPlayer::execEnableColorBlindEffect(FFrame&, void* const)
native function EnableColorBlindEffect(optional bool bEnable = false, optional int Type = 1, optional bool bSimulateMode = false);

// Export UTgLocalPlayer::execUpdateLowHealthEffect(FFrame&, void* const)
native function UpdateLowHealthEffect(float DeltaSeconds, optional float fHealthPCT = 1.0000000, optional float fHealthLostPCT = 0.0000000, optional bool bDeathVision = false);

// Export UTgLocalPlayer::execSetBlurAmount(FFrame&, void* const)
native function SetBlurAmount(float TargetBlurAmount, float InterpSpeed, float BlurKernelSize, optional bool bForeground = false);

event PostProcessEffect GetPostProcessEffect(name EffectName)
{
    // End:0x38
    if(PlayerPostProcess != none)
    {
        return PlayerPostProcess.FindPostProcessEffect(EffectName);
    }
    return none;
    //return ReturnValue;    
}

defaultproperties
{
    m_fViewScale=1.0000000
    m_eColorBlindEffectType=1
    m_fBlurKernelSize=16.0000000
}