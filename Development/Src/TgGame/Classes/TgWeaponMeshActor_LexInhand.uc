class TgWeaponMeshActor_LexInhand extends TgWeaponMeshActor
    native(ChampLex)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const MAX_THE_LAW_TARGETS = 5;

const THE_LAW_TARGETTING_BEAM_FX_ID = 7680;

const THE_LAW_TARGETTING_BEAM_EXECUTE_FX_ID = 7834;

const THE_LAW_HIT_BEAM_FX_ID = 7703;

enum EBeamState {
    EBS_Hidden,  // 0
    EBS_Targeting,  // 1
    EBS_Hitting,  // 2
};

var TgPawn_Lex m_CachedLex;
var TgBeamHelper c_Beams[5];
var TgBeamHelper c_ExecutableBeams[5];
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes1P;
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes3P;
var name c_LeftInHandSocket;
var name c_RightInHandSocket;
var bool c_bJustRenderedBeamsForUlt;
var TgWeaponMeshActor_LexInhand.EBeamState c_eBeamState;

simulated function bool HasCachedLex() { }

simulated function ShowTargetingBeams() { }

simulated function ShowHitBeams() { }

simulated function HideBeams() { }

simulated function ClearBeams() { }

simulated function ClearBeam(int Index) { }

simulated function ClearNonExecutableBeam(int Index) { }

simulated function ClearExecutableBeam(int Index) { }

simulated function ManageBeamNonExecutable(int Index) { }

simulated function ManageBeamExecutable(int Index) { }

simulated event ManageBeams() { }

simulated function OverrideTracerFireLoc(out Vector fireLoc) { }

defaultproperties
{}
