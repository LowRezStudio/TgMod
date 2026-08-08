class TgPawn_Pip extends TgPawn_Character
    native(ChampPip)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var bool r_bWeightless;
var bool m_bWeightlessDurationEnded;
var bool r_bAcrobaticsActive;
var bool r_bHasMegaPotion;
var float m_fWeightlessMaxSpeedModifier;
var float m_fWeightlessJumpZModifier;
var float r_fRadiusForHealingPotionFX;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && !bNetOwner || bDemoRecording) r_bWeightless;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bAcrobaticsActive, r_bHasMegaPotion, r_fRadiusForHealingPotionFX;
}

simulated event PlayJumpSound() { }

function StartWeightless(float fMaxSpeedMultiplier, float fJumpZMultiplier) { }

singular function EndWeightless() { }

simulated function float GetJumpSpeedMultiplier() { }

function bool DoJump(bool bUpdating) { }

event Landed(vector HitNormal, actor FloorActor) { }

simulated function SetPipGlowEnabled(bool bEnabled) { }

simulated function TickScale(float DeltaSeconds) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
