class TgActionPoint extends TgNavigationPoint
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force);

enum eActionPointType
{
    ACTION_NONE,                    // 0
    ACTION_RELAX_OPEN,              // 1
    ACTION_MINE_DEFAULT,            // 2
    ACTION_RELAX_WALL,              // 3
    ACTION_CONSOLE_STANDARD,        // 4
    ACTION_CONSOLE_LAB_DEFAULT,     // 5
    ACTION_GUARD_WATCH_NORMAL,      // 6
    ACTION_GUARD_WATCH_ELEVATED,    // 7
    ACTION_FACTORY_LINE_DEFAULT,    // 8
    ACTION_SNIPE,                   // 9
    ACTION_PLACE_TURRET,            // 10
    ACTION_PLACE_SHIELD,            // 11
    ACTION_PLACE_CRATE,             // 12
    ACTION_PLACE_MINE,              // 13
    ACTION_PLACE_SENSOR,            // 14
    ACTION_MAX                      // 15
};

var(ActionPoint) TgActionPoint.eActionPointType ActionType;
var(ActionPoint) byte nObjectiveNum;
var(ActionPoint) byte nTaskForce;
var(ActionPoint) bool bUseRotation;

defaultproperties
{
    bUseRotation=true
    // Reference: CylinderComponent'TgGame.Default__TgActionPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgNavigationPoint.CollisionCylinder'
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