class TgExplosionLight extends PointLightComponent
    native
    editinlinenew
    hidecategories(Object);

struct native LightValues
{
    var float StartTime;
    var float Radius;
    var float Brightness;
    var Color LightColor;
    var Color EnemyLightColor;
    var Color LocalLightColor;

    structdefaultproperties
    {
        StartTime=0.0000000
        Radius=0.0000000
        Brightness=0.0000000
        LightColor=(R=0,G=0,B=0,A=0)
        EnemyLightColor=(R=0,G=0,B=0,A=0)
        LocalLightColor=(R=0,G=0,B=0,A=0)
    }
};

var bool bCheckFrameRate;
var bool bInitialized;
var() bool bIsEnemy;
var() bool bIsLocal;
var bool bIsLooping;
var float HighDetailFrameTime;
var float Lifetime;
var int TimeShiftIndex;
var() array<LightValues> TimeShift;
var() int LoopIndex;
//var delegate<OnLightFinished> __OnLightFinished__Delegate;

// Export UTgExplosionLight::execResetLight(FFrame&, void* const)
native final function ResetLight();

delegate OnLightFinished(TgExplosionLight Light)
{
    //return;    
}

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