class TgExplosionLight extends PointLightComponent
    native
    editinlinenew
    hidecategories(Object)
    config(Engine);

struct LightValues {
    var float StartTime;
    var float Radius;
    var float Brightness;
    var Color LightColor;
    var Color EnemyLightColor;
    var Color LocalLightColor;
    structdefaultproperties {}
};

var bool bCheckFrameRate;
var bool bInitialized;
var () bool bIsEnemy;
var () bool bIsLocal;
var bool bIsLooping;
var float HighDetailFrameTime;
var float Lifetime;
var int TimeShiftIndex;
var () array<LightValues> TimeShift;
var () int LoopIndex;

native function ResetLight();  // Export UTgExplosionLight::execResetLight(FFrame&, void* const)

delegate OnLightFinished(TgExplosionLight Light);

defaultproperties
{
    bCheckFrameRate=true
    HighDetailFrameTime=0.0150000
    LoopIndex=-1
    Radius=256.0000000
    Brightness=8.0000000
    LightColor=(R=255,G=255,B=255,A=255)
    CastShadows=false
}
