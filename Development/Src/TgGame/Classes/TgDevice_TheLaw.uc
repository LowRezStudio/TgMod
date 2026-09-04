class TgDevice_TheLaw extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

var float m_ExecutePercentage;
var Rotator AimRotation;

defaultproperties
{
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceTheLaw'
}
