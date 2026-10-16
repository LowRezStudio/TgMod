class TgAnimNotify_InterpolateMorphTargetWeight extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

enum InterruptMorphTargetBehavior {
    ResetToInitial,  // 0
    ResetToValue,  // 1
    RestToTarget,  // 2
};

var () name MorphNodePoseName;
var () float MorphTargetWeight;
var () TgAnimNotify_InterpolateMorphTargetWeight.InterruptMorphTargetBehavior OnInterruptBehavior;
var () float InterruptMorphTargetWeight;
var transient float InitialMorphTargetWeight;

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode) { }

defaultproperties
{
    MorphTargetWeight=1.0000000
    OnInterruptBehavior=ResetToValue
}
