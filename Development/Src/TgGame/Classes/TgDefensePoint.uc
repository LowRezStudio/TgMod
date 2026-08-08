class TgDefensePoint extends TgNavigationPoint
    abstract
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

var Controller CurrentUser;
var TgDefensePoint NextDefensePoint;
var bool bFirstScript;
var () bool bSniping;
var () bool bDontChangePosition;
var bool bAvoid;
var bool bDisabled;
var () bool bNotInVehicle;
var () byte Priority;
var () Class<Weapon> WeaponPreference;
var float NumChecked;

function Reset() { }

function FreePoint() { }

function PreBeginPlay() { }

function bool HigherPriorityThan(TgDefensePoint S, TgAIController B) { }

function Actor GetMoveTarget() { }

defaultproperties
{}
