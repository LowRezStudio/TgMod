class TgSpecialFxLightManager extends Object
    native(FX)
    config(Game);

const INVALID_LIGHT_SCORE = 2;
const INVALID_LIGHTARRAY_INDEX = -1;
const TGFXLIGHT_MAX_SETTINGS_VALUE = 5;

enum SpecialFxLightState
{
    FxLight_Normal,                 // 0
    FxLight_Dying,                  // 1
    FxLight_Kill,                   // 2
    FxLight_MAX                     // 3
};

struct native TgFxLight
{
    var Pointer m_FxEmitter;
    var TgSpecialFx m_OwnerSpecialFx;
    var float m_Score;

    structdefaultproperties
    {
        m_FxEmitter=()
        m_OwnerSpecialFx=none
        m_Score=0.0000000
    }
};

var config bool c_FxLightsEnabled;
var config bool c_FxLightsUnconstrained;
var config int c_FxLightsMaxActive;
var config int c_FxLightsMaxDying;
var init array<init Pointer> m_ActiveEmitters;
var init array<init Pointer> m_DyingEmitters;
var TgPawn c_LocalPawn;

// Export UTgSpecialFxLightManager::execInitializeFxLightManager(FFrame&, void* const)
native function InitializeFxLightManager();

// Export UTgSpecialFxLightManager::execAddLight(FFrame&, void* const)
native function AddLight(Pointer NewFxEmitter);

// Export UTgSpecialFxLightManager::execSetLightState(FFrame&, void* const)
native function SetLightState(Pointer ExtantFxEmitter, TgSpecialFxLightManager.SpecialFxLightState NewFxLightState);

// Export UTgSpecialFxLightManager::execLightKilledElsewhere(FFrame&, void* const)
native function LightKilledElsewhere(Pointer FxEmitterKilled);

// Export UTgSpecialFxLightManager::execSetLevelInternal(FFrame&, void* const)
native function SetLevelInternal(int LightLevel);

exec function UserSetLevel(int LightLevel)
{
    SetLevelInternal(LightLevel);
    SaveConfig();
    //return;    
}

defaultproperties
{
    c_FxLightsEnabled=true
    c_FxLightsMaxActive=1
    c_FxLightsMaxDying=1
}