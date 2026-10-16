class TgDeviceFire_Salvo extends TgDeviceFire
    config(Engine);

var TgDevice_DrogozInhand m_CachedDrogozInhand;

simulated event float GetPreHitDelay() { }

simulated function bool HasCachedDrogozInhand() { }
