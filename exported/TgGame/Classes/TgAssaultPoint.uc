class TgAssaultPoint extends TgAIAnnotation
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force);

enum EAssaultType
{
    AssaultType_None,               // 0
    AssaultType_Short,              // 1
    AssaultType_MidShort,           // 2
    AssaultType_Mid,                // 3
    AssaultType_LongMid,            // 4
    AssaultType_Long,               // 5
    AssaultType_MAX                 // 6
};

enum ELocationType
{
    ELocationType_CapturePoint,     // 0
    ELocationType_Attack,           // 1
    ELocationType_Defend,           // 2
    ELocationType_MAX               // 3
};

var() TgAssaultPoint.EAssaultType AssaultPointType;
var() TgAssaultPoint.ELocationType LocationType;

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgAssaultPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgAIAnnotation.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    CollisionComponent=CollisionCylinder
}