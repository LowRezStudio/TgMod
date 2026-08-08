class TgAnimNodeBlendByAbilityHyperShot extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendHyperShot {
    BLENDHYPERSHOT_Inactive,  // 0
    BLENDHYPERSHOT_Buildup,  // 1
    BLENDHYPERSHOT_Idle,  // 2
    BLENDHYPERSHOT_Activate,  // 3
    BLENDHYPERSHOT_FireBuildup,  // 4
    BLENDHYPERSHOT_Fire,  // 5
    BLENDHYPERSHOT_TransitionToIdle,  // 6
    BLENDHYPERSHOT_Cancel,  // 7
};

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="HyperShotAbilityBlendNode"
}
