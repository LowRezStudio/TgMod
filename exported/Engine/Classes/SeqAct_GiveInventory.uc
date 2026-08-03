class SeqAct_GiveInventory extends SequenceAction
    hidecategories(Object);

var() array< Class<Inventory> > InventoryList;
var() bool bClearExisting;
var() bool bForceReplace;

defaultproperties
{
    ObjName="Give Inventory"
}