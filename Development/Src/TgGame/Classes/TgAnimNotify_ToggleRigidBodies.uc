class TgAnimNotify_ToggleRigidBodies extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

enum ERigidBodyFixationChange {
    RBF_Fix,  // 0
    RBF_Unfix,  // 1
    RBF_Toggle,  // 2
};

var () array<name> BoneNames;
var () TgAnimNotify_ToggleRigidBodies.ERigidBodyFixationChange Effect;

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode) { }

simulated event OnAnimNodeSequenceBecomeRelevant(AnimNodeSequence OwningNode) { }
