class TgPortal extends Portal
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var (Teleport) bool bUpdateRotation;
var (Teleport) bool bCheckOverlap;
var (Teleport) bool bResetVelocity;
var (Teleport) bool bCheckTaskForce;
var (Teleport) int nTaskForce;
var (TeleportSound) SoundCue TeleportSoundCue;
var (TeleportSound) float FadeInTime;
var (TeleportSound) float VolumeMultiplier;
var (TeleportSound) float PitchMultiplier;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
