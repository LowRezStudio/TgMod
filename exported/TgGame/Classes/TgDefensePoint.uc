class TgDefensePoint extends TgNavigationPoint
    abstract
    hidecategories(Navigation,Lighting,LightColor,Force);

var Controller CurrentUser;
var TgDefensePoint NextDefensePoint;
var bool bFirstScript;
var() bool bSniping;
var() bool bDontChangePosition;
var bool bAvoid;
var bool bDisabled;
var() bool bNotInVehicle;
var() byte Priority;
var() Class<Weapon> WeaponPreference;
var float NumChecked;

function Reset()
{
    bDisabled = false;
    FreePoint();
    //return;    
}

function FreePoint()
{
    CurrentUser = none;
    //return;    
}

function PreBeginPlay()
{
    //return;    
}

function bool HigherPriorityThan(TgDefensePoint S, TgAIController B)
{
    return FRand() < (float(1) / S.NumChecked);
    //return ReturnValue;    
}

function Actor GetMoveTarget()
{
    return self;
    //return ReturnValue;    
}

defaultproperties
{
    bFirstScript=true
    // Reference: CylinderComponent'TgGame.Default__TgDefensePoint.CollisionCylinder'
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