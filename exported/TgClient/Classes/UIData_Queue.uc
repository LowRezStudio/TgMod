class UIData_Queue extends UIData
    native(UIData);

enum EUIDQCallToAction
{
    EUIDQCTA_None,                  // 0
    EUIDQCTA_NewMode,               // 1
    EUIDQCTA_NewMap,                // 2
    EUIDQCTA_MAX                    // 3
};

var init array<init dword> dwQueues;
var int nForcedBotId;
var UIData_Queue.EUIDQCallToAction eCTA;
var int nIcon;
var bool bSelected;
var bool bCompetitive;

defaultproperties
{
    bSelected=true
}