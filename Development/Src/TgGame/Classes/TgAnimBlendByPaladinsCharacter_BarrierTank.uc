class TgAnimBlendByPaladinsCharacter_BarrierTank extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var (BarrierTank) array<name> m_AmmoSkelControlNames;
var array<SkelControlBase> m_AmmoSkelControls;
var TgPawn_BarrierTank m_CachedBarrierTankPawn;

native function UpdateAmmoSkelControls();  // Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execUpdateAmmoSkelControls(FFrame&, void* const)

native function SetActiveChild(INT ChildIndex, FLOAT BlendTime);  // Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execSetActiveChild(FFrame&, void* const)

native function bool HasCachedBarrierTankPawn();  // Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execHasCachedBarrierTankPawn(FFrame&, void* const)

native function OnRetrieve();  // Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execOnRetrieve(FFrame&, void* const)
