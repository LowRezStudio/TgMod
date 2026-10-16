class TgAnimNotify_ToggleRigidBodies extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

enum ERigidBodyFixationChange
{
    RBF_Fix,                        // 0
    RBF_Unfix,                      // 1
    RBF_Toggle,                     // 2
    RBF_MAX                         // 3
};

var() array<name> BoneNames;
var() TgAnimNotify_ToggleRigidBodies.ERigidBodyFixationChange Effect;

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode)
{
    local bool ShouldFix;

    ShouldFix = !int(Effect) == int(0);
    OwningNode.SkelComponent.PhysicsAssetInstance.SetNamedBodiesFixed(ShouldFix, BoneNames, OwningNode.SkelComponent);
    super.OnAnimNodeSequenceCeaseRelevant(OwningNode);
    //return;    
}

simulated event OnAnimNodeSequenceBecomeRelevant(AnimNodeSequence OwningNode)
{
    local bool ShouldFix;

    ShouldFix = int(Effect) == int(0);
    OwningNode.SkelComponent.PhysicsAssetInstance.SetNamedBodiesFixed(ShouldFix, BoneNames, OwningNode.SkelComponent);
    super.OnAnimNodeSequenceBecomeRelevant(OwningNode);
    //return;    
}
