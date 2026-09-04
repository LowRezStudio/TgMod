class TgDeviceForm_LexInhand extends TgDeviceForm
    native(ChampLex)
    config(Engine);

var name c_nmSocketLeft;
var name c_nmSocketRight;
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes1P;
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes3P;
var array<TgAnimNodeStanceDualFire> m_DualFireStanceNodes1P;
var array<TgAnimNodeStanceDualFire> m_DualFireStanceNodes3P;
var TgPawn_Lex m_CachedLex;
var int m_nPursuitFireIndex;

native function SetFireMode(int nMode);  // Export UTgDeviceForm_LexInhand::execSetFireMode(FFrame&, void* const)

simulated function bool HasCachedLex() { }

simulated event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

simulated event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

simulated function OnAmmoChange() { }

simulated function SetDualFireParity(bool bLeftFire) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Vector GetTracerSocketLocation() { }

defaultproperties
{
    c_nmSocketLeft="WSO_Emit_02"
    c_nmSocketRight="WSO_Emit_01"
}
