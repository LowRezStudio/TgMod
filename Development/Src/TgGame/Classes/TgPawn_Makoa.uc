class TgPawn_Makoa extends TgPawn_Character
    native(ChampMakoa)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var float m_fSmashSpeedModifier;
var float m_fShellSpinZoomOverride;
var bool r_bShellShieldIsActive;
var repnotify bool r_bAncientRageActive;
var bool r_bAbility1CanEmote;
var float m_fShellShieldSpeedModifier;
var float m_fShellShieldZoomOverride;
var TgSpecialFx m_ShellShieldMovementFX;
var TgDevice m_AncientRageInHand;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bAbility1CanEmote, r_bAncientRageActive, r_bShellShieldIsActive;
}

simulated event ReplicatedEvent(name VarName) { }

simulated function PlayAncientRageEffects(bool bEnabled) { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

simulated event float GetAbilityEmoteChance(TgPawn.EEmote Emote) { }

simulated function name GetFootStepOverride() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function OnDeviceFormHit(int nEquipSlot, Actor Target, float DamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }

defaultproperties
{}
