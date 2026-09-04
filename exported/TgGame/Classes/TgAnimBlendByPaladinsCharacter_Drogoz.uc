class TgAnimBlendByPaladinsCharacter_Drogoz extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var(Drogoz) array<name> m_AmmoSkelControlNames;
var array<SkelControlBase> m_AmmoSkelControls;
var TgPawn_Drogoz m_CachedDrogozPawn;

// Export UTgAnimBlendByPaladinsCharacter_Drogoz::execUpdateAmmoSkelControls(FFrame&, void* const)
native function UpdateAmmoSkelControls();

// Export UTgAnimBlendByPaladinsCharacter_Drogoz::execSetActiveChild(FFrame&, void* const)
native function SetActiveChild(int ChildIndex, float BlendTime);

// Export UTgAnimBlendByPaladinsCharacter_Drogoz::execHasCachedDrogozPawn(FFrame&, void* const)
native function bool HasCachedDrogozPawn();

// Export UTgAnimBlendByPaladinsCharacter_Drogoz::execOnRetrieve(FFrame&, void* const)
native function OnRetrieve();
