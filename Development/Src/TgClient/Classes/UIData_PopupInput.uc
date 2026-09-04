class UIData_PopupInput extends UIData
    native(UIData)
    implements(TgCallbackInterface)
    config(Engine);

const UIDATA_POPUPINPUT_TITLECOUNT = 2;

const UIDATA_POPUPINPUT_BUTTONCOUNT = 2;

var init string sTitle[2];
var init string sButtonName[2];
var native Pointer pButtonValidate[2];
var TgCallbackContainer m_CallbackContainer;
