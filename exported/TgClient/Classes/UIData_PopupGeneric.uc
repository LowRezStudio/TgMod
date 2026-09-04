class UIData_PopupGeneric extends UIData
    native(UIData)
    implements(TgCallbackInterface);

const UIDATA_POPUPGENERIC_TITLECOUNT = 2;
const UIDATA_POPUPGENERIC_BUTTONCOUNT = 8;

var private native const noexport Pointer VfTable_ITgCallbackInterface;
var init string sTitle[2];
var int nInitialIndex;
var bool bUserMustClose;
var init string sButtonName[8];
var TgCallbackContainer m_CallbackContainer;
