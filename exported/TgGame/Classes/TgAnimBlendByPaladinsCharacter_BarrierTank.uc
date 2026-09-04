class TgAnimBlendByPaladinsCharacter_BarrierTank extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var(BarrierTank) array<name> m_AmmoSkelControlNames;
var array<SkelControlBase> m_AmmoSkelControls;
var TgPawn_BarrierTank m_CachedBarrierTankPawn;

// Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execUpdateAmmoSkelControls(FFrame&, void* const)
native function UpdateAmmoSkelControls();

// Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execSetActiveChild(FFrame&, void* const)
native function SetActiveChild(int ChildIndex, float BlendTime);

// Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execHasCachedBarrierTankPawn(FFrame&, void* const)
native function bool HasCachedBarrierTankPawn();

// Export UTgAnimBlendByPaladinsCharacter_BarrierTank::execOnRetrieve(FFrame&, void* const)
native function OnRetrieve();
