class TgInventoryObject_Listen_Combo extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory)
    config(Engine);

simulated event AddUIMarks(Actor Target, int nNumMarks) { }

simulated event RemoveUIMarks(Actor Target, int nNumMarks) { }
