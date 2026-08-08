class TgSilhouetteComponentPaladins extends TgSilhouetteComponent
    native(FX)
    hidecategories(Object)
    config(Engine);

struct SilhouetteColorSettings {
    var bool bUsesMultipleColors;
    var bool bUsesEnemyRangeColorVariance;
    var const Color BlueColor;
    var const Color EnemyColor;
    var const Color PurpleColor;
    var const Color OrangeColor;
    var const Color EnemyTargetedEffectiveRangeColor;
    var const Color EnemyTargetedMaxRangeColor;
    var const Color RedColor;
    structdefaultproperties {}
};

struct SilhouetteFadeSettings {
    var bool bUsesDistanceFade;
    var const float fAlphaFadeNearDist;
    var const float fAlphaFadeNear;
    var const float fAlphaFadeFarDist;
    var const float fAlphaFadeFar;
    structdefaultproperties {}
};

struct SilhouettePulseSettings {
    var bool bUsesPulse;
    var bool bUsePulseAlpha;
    var bool bPulseMaintainsDistanceDimming;
    var Vector2D vPulseAlpha;
    var bool bPulseUseCustomColor;
    var Color PulseCustomColor;
    var bool bUsePulseThicknessMultiplier;
    var Vector2D vPulseThicknessMultiplier;
    var float fPulseElapsedTime;
    var float fPulseDuration;
    var float fPulseWaveTime;
    structdefaultproperties {}
};

var (ColorSettings) SilhouetteColorSettings m_ColorSettings;
var (FadeSettings) SilhouetteFadeSettings m_FadeSettings;
var (PulseSettings) SilhouettePulseSettings m_PulseSettings;

defaultproperties
{
    m_ColorSettings=(bUsesMultipleColors=false,bUsesEnemyRangeColorVariance=false,BlueColor=(R=80,G=219,B=239,A=0),EnemyColor=(R=247,G=149,B=51,A=0),PurpleColor=(R=192,G=22,B=207,A=0),OrangeColor=(R=252,G=122,B=40,A=0),EnemyTargetedEffectiveRangeColor=(R=247,G=51,B=51,A=0),EnemyTargetedMaxRangeColor=(R=255,G=188,B=51,A=0),RedColor=(R=247,G=51,B=51,A=0))
    m_FadeSettings=(bUsesDistanceFade=false,fAlphaFadeNearDist=500.0000000,fAlphaFadeNear=0.2500000,fAlphaFadeFarDist=2000.0000000,fAlphaFadeFar=0.0400000)
    SilhouetteColor=(R=0.0780566,G=0.7154654,B=0.8671355,A=0.2500000)
    NearThickness=0.5500000
    FarThickness=4.0000000
    ReplacementPrimitive=none
    TickGroup=TG_PostAsyncWork
}
