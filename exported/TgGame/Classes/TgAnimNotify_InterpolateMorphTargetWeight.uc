class TgAnimNotify_InterpolateMorphTargetWeight extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

enum InterruptMorphTargetBehavior
{
    ResetToInitial,                 // 0
    ResetToValue,                   // 1
    RestToTarget,                   // 2
    InterruptMorphTargetBehavior_MAX// 3
};

var() name MorphNodePoseName;
var() float MorphTargetWeight;
var() TgAnimNotify_InterpolateMorphTargetWeight.InterruptMorphTargetBehavior OnInterruptBehavior;
var() float InterruptMorphTargetWeight;
var transient float InitialMorphTargetWeight;

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode)
{
    local MorphNodePose MorphNode;

    // End:0x13A
    if((OwningNode != none) && OwningNode.SkelComponent != none)
    {
        MorphNode = MorphNodePose(OwningNode.SkelComponent.FindMorphNode(MorphNodePoseName));
        // End:0x13A
        if(MorphNode != none)
        {
            switch(OnInterruptBehavior)
            {
                // End:0xD7
                case 0:
                    MorphNode.Weight = InitialMorphTargetWeight;
                    // End:0x13A
                    break;
                // End:0x107
                case 1:
                    MorphNode.Weight = InterruptMorphTargetWeight;
                    // End:0x13A
                    break;
                // End:0x137
                case 2:
                    MorphNode.Weight = MorphTargetWeight;
                    // End:0x13A
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        else
        {
        }/* !MISMATCHING REMOVE, tried If got Type:Else Position:0x13A! */
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:If Position:0x000! */
}

defaultproperties
{
    MorphTargetWeight=1.0000000
    OnInterruptBehavior=InterruptMorphTargetBehavior.ResetToValue
}