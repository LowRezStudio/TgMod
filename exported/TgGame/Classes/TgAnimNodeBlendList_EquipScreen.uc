class TgAnimNodeBlendList_EquipScreen extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EEquipScreenAnimTypes
{
    ESAT_Default,                   // 0
    ESAT_Weapon,                    // 1
    ESAT_Helmet,                    // 2
    ESAT_Backpack,                  // 3
    ESAT_Suit,                      // 4
    ESAT_MAX                        // 5
};

// Export UTgAnimNodeBlendList_EquipScreen::execPlayWeaponReaction(FFrame&, void* const)
native function PlayWeaponReaction();

// Export UTgAnimNodeBlendList_EquipScreen::execPlayHelmetReaction(FFrame&, void* const)
native function PlayHelmetReaction();

// Export UTgAnimNodeBlendList_EquipScreen::execPlaySuitReaction(FFrame&, void* const)
native function PlaySuitReaction();

// Export UTgAnimNodeBlendList_EquipScreen::execPlayBackpackReaction(FFrame&, void* const)
native function PlayBackpackReaction();

// Export UTgAnimNodeBlendList_EquipScreen::execPlayIdleAnim(FFrame&, void* const)
native function PlayIdleAnim();

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}