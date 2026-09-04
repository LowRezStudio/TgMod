class TgEffectForm extends Object
    native(Effects)
    config(Engine)
    dependson(TgPawn);

var int c_nEffectGroupId;
var int c_nType;
var Actor c_Owner;
var native Pointer c_pwzEffectName;
var native Pointer c_pwzDescription;
var int c_nEffectIconId;
var array<TgSpecialFx> c_AppliedFxArray;
var bool c_bHiddenDueToStealth;
var bool c_bHiddenDueToFirstPerson;
var bool c_bMICApplied;
var bool m_bSpawnAtHitLocation;
var bool c_bIsDebuff;
var bool c_bIsCrit;
var bool c_bLocal;
var TgPawn.TG_POSTURE c_Posture;
var int c_PostureID;
var MaterialInstanceConstant m_MaterialInstanceConstant;
var TgPawn m_OwnerPawn;
var Vector m_HitLocation;
var Vector m_HitNormal;
var int c_nSkinId;
var TgEmitter_CameraEffect c_CameraEffect;
var int c_nStackCount;

native function RecalculateFx();  // Export UTgEffectForm::execRecalculateFx(FFrame&, void* const)

native function ShowEffectForm(bool bLocal);  // Export UTgEffectForm::execShowEffectForm(FFrame&, void* const)

native function HideEffectForm();  // Export UTgEffectForm::execHideEffectForm(FFrame&, void* const)

native function Attach(Actor pOwner);  // Export UTgEffectForm::execAttach(FFrame&, void* const)

native function Reattach();  // Export UTgEffectForm::execReattach(FFrame&, void* const)

native function Detach();  // Export UTgEffectForm::execDetach(FFrame&, void* const)

native function AdjustHidden();  // Export UTgEffectForm::execAdjustHidden(FFrame&, void* const)

native function bool ShouldShowEffectForm();  // Export UTgEffectForm::execShouldShowEffectForm(FFrame&, void* const)

defaultproperties
{
    c_bLocal=true
}
