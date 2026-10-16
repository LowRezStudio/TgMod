class AnimNotify_PawnMaterialParam extends AnimNotify_Scripted
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() array<ScalarParameterInterpStruct> ScalarParameterInterpArray;

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator)
{
    local Pawn P;
    local int I;
    local ScalarParameterInterpStruct ScalarParam;

    P = Pawn(Owner);
    // End:0xA1
    if(P != none)
    {
        I = 0;
        J0x36:

        // End:0xA1 [Loop If]
        if(I < ScalarParameterInterpArray.Length)
        {
            ScalarParam = ScalarParameterInterpArray[I];
            P.SetScalarParameterInterp(ScalarParam);
            I++;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}
