class TgTeleportPlayerVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

enum TgTeleportVolumeType {
    Inactive,  // 0
    Respawn,  // 1
};

var () TgTeleportPlayerVolume.TgTeleportVolumeType TeleportLocation;
var () int nMessageId;
var () bool bTeleportBots;
var () bool bTeleportPlayers;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
