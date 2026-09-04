class TgAssaultPoint extends TgAIAnnotation
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

enum EAssaultType {
    AssaultType_None,  // 0
    AssaultType_Short,  // 1
    AssaultType_MidShort,  // 2
    AssaultType_Mid,  // 3
    AssaultType_LongMid,  // 4
    AssaultType_Long,  // 5
};

enum ELocationType {
    ELocationType_CapturePoint,  // 0
    ELocationType_Attack,  // 1
    ELocationType_Defend,  // 2
};

var () TgAssaultPoint.EAssaultType AssaultPointType;
var () TgAssaultPoint.ELocationType LocationType;

defaultproperties
{}
