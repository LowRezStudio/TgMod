class TgDeviceForm_RestoreSoul extends TgDeviceForm
    config(Engine)
    dependson(TgPawn);

var TgPawn_Oracle m_CachedOracle;

simulated function bool HasCachedOracle() { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }
