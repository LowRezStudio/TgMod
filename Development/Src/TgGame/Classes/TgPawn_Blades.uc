class TgPawn_Blades extends TgPawn_Character
    native(ChampBlades)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

const DJ_BLADES_HEAD_SKIN_ID = 19277;

const DJ_BLADES_HEAD_SKIN_LOBBY_ID = 8021;

const MAX_DJ_BLADES_FACES = 8;

const MAX_DJ_BLADES_FACE_PRIORITIES = 3;

enum GemEmissiveAnim {
    eGEA_None,  // 0
    eGEA_Idle,  // 1
    eGEA_Pounce,  // 2
    eGEA_Prowl,  // 3
    eGEA_AirJump,  // 4
    eGEA_NineLives,  // 5
    eGEA_Midnight,  // 6
};

enum DjBladesFace {
    eDBF_Base,  // 0
    eDBF_VGS_Positive,  // 1
    eDBF_VGS_Negative,  // 2
    eDBF_VGS_Silly,  // 3
    eDBF_Ability_1,  // 4
    eDBF_Ability_2,  // 5
    eDBF_CrowdControl,  // 6
    eDBF_Death,  // 7
};

enum DjBladesFacePriority {
    eDBFP_Ability,  // 0
    eDBFP_VGS,  // 1
    eDBFP_Status,  // 2
};

struct DjBladesFaceConfig {
    var float fShiftX;
    var float fShiftY;
    structdefaultproperties {}
};

var float m_fGravityFalloffDuration;
var float m_fGravityFalloffTimer;
var float m_fAirControlReductionDuration;
var float m_fAirControlReductionTimer;
var float m_fAirControlReductionPercent;
var repnotify bool r_bProwlActive;
var float r_fProwlAccelMultiplier;
var float r_fProwlGroundSpeedMultiplier;
var float r_fProwlJumpHeightMultiplier;
var float r_fProwlAirControlMultiplier;
var repnotify float r_fProwlFadeOutDuration;
var float m_fProwlFadeOutTimer;
var float r_fFeatherliteGravityMultiplier;
var repnotify TgPawn_Blades.GemEmissiveAnim r_eGemEmissiveAnim;
var repnotify TgPawn_Blades.GemEmissiveAnim r_eGemEmissiveEndAnim;
var TgPawn_Blades.DjBladesFace c_eCurrentDjBladesFace;
var TgPawn_Blades.DjBladesFace c_eDjBladesFace[3];
var MaterialInstanceConstant c_pGemEmissiveMIC;
var string m_sGemEmissiveParamName;
var float m_fGemEmissiveBaseValue;
var float m_fGemEmissiveBaseAnimSpeed;
var float c_fGemEmissiveCurrentValue;
var array<TgPawn_Blades.GemEmissiveAnim> c_eGemEmissiveAnimType;
var array<float> c_fGemEmissiveTargetValue;
var array<float> c_fGemEmissiveAnimSpeed;
var array<float> c_fGemEmissiveHoldTimer;
var float m_fGemEmissive1PBaseValue;
var float m_fGemEmissive1PAnimSpeedMult;
var float m_fGemEmissive1PValueMult;
var float m_fGemEmissiveGlobalScalar;
var float c_fDjBladesFaceTimeout[3];
var DjBladesFaceConfig c_DjBladesFaceConfig[8];
var string c_sDjBladesFaceXParamName;
var string c_sDjBladesFaceYParamName;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_bProwlActive, r_fFeatherliteGravityMultiplier, r_fProwlAccelMultiplier, r_fProwlAirControlMultiplier, r_fProwlFadeOutDuration, r_fProwlGroundSpeedMultiplier, r_fProwlJumpHeightMultiplier;
}

native function float GetGravityZ();  // Export UTgPawn_Blades::execGetGravityZ(FFrame&, void* const)

native function GravityFallOff(float fDuration);  // Export UTgPawn_Blades::execGravityFallOff(FFrame&, void* const)

native function AirControlReduction(float fDuration, float fPercentReduction);  // Export UTgPawn_Blades::execAirControlReduction(FFrame&, void* const)

native function QueueBounceCustom(const out Vector vBounceVelocity, float fDuration, float fPctAirControlReduction);  // Export UTgPawn_Blades::execQueueBounceCustom(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_Blades::execDeviceAdjustDamage(FFrame&, void* const)

native function float GetProwlAccelMultiplier();  // Export UTgPawn_Blades::execGetProwlAccelMultiplier(FFrame&, void* const)

native function float GetProwlGroundSpeedMultiplier();  // Export UTgPawn_Blades::execGetProwlGroundSpeedMultiplier(FFrame&, void* const)

native function float GetProwlJumpHeightMultiplier();  // Export UTgPawn_Blades::execGetProwlJumpHeightMultiplier(FFrame&, void* const)

native function float GetProwlAirControlMultiplier();  // Export UTgPawn_Blades::execGetProwlAirControlMultiplier(FFrame&, void* const)

native simulated function ResetGemEmissiveParam();  // Export UTgPawn_Blades::execResetGemEmissiveParam(FFrame&, void* const)

native simulated function ClearGemEmissiveParam(TgPawn_Blades.GemEmissiveAnim eAnim);  // Export UTgPawn_Blades::execClearGemEmissiveParam(FFrame&, void* const)

native simulated function AnimateGemEmissiveParam(TgPawn_Blades.GemEmissiveAnim eAnim, float fTargetValue, float fAnimSpeed, float fHoldTime);  // Export UTgPawn_Blades::execAnimateGemEmissiveParam(FFrame&, void* const)

native function PawnOnKilled(Actor pVictim);  // Export UTgPawn_Blades::execPawnOnKilled(FFrame&, void* const)

native function PawnOnAssisted(Actor pVictim);  // Export UTgPawn_Blades::execPawnOnAssisted(FFrame&, void* const)

simulated function SetGemEmissiveAnim(TgPawn_Blades.GemEmissiveAnim eAnim) { }

function ClearGemEmissiveAnim() { }

simulated function SetGemEmissiveEndAnim(TgPawn_Blades.GemEmissiveAnim eEndAnim) { }

function ClearGemEmissiveEndAnim() { }

simulated function ApplyGemEmissveAnim(TgPawn_Blades.GemEmissiveAnim eAnim) { }

simulated event float Get1PGemEmissiveMultiplier(TgPawn_Blades.GemEmissiveAnim eAnim) { }

simulated event ReplicatedEvent(name VarName) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

function bool CannotJumpNow() { }

function bool DoJump(bool bUpdating) { }

simulated function float GetJumpHeightMultiplier() { }

simulated event int GetNumAirJumps() { }

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote) { }

simulated event float GetAbilityEmoteChance(TgPawn.EEmote Emote) { }

simulated event float GetEmoteChance(TgPawn.EEmote Emote) { }

simulated event OnVGSSoundPlayed(int nVgsId) { }

simulated event OnVGSSoundFinished() { }

simulated event OnEmoteSoundPlayed(TgPawn.EEmote Emote) { }

simulated event OnEmoteSoundFinished() { }

simulated event SetDjBladesFace(TgPawn_Blades.DjBladesFace eFace, TgPawn_Blades.DjBladesFacePriority ePriority, optional float fTimeout=0.0000000) { }

simulated function UpdateDjBladesFace() { }

native simulated function ApplyDjBladesFace(TgPawn_Blades.DjBladesFace eFace);  // Export UTgPawn_Blades::execApplyDjBladesFace(FFrame&, void* const)

defaultproperties
{}
