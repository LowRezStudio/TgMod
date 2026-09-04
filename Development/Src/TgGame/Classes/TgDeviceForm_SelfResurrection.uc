class TgDeviceForm_SelfResurrection extends TgDeviceForm
    native(ChampLazarus)
    config(Engine)
    dependson(TgDevice_SelfResurrection);

var TgDevice_SelfResurrection.ResurrectionState m_CurrentDeviceState;

event Generic1(optional byte byExtraData) { }
