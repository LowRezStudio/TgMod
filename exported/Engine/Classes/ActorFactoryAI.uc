class ActorFactoryAI extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() Class<AIController> ControllerClass;
var() Class<Pawn> PawnClass;
var() string PawnName;
var() bool bGiveDefaultInventory;
var() array< Class<Inventory> > InventoryList;
var() int TeamIndex;

defaultproperties
{
    ControllerClass=Class'Engine.AIController'
    TeamIndex=255
    bPlaceable=false
}