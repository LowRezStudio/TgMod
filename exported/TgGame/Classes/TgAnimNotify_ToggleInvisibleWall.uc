class TgAnimNotify_ToggleInvisibleWall extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() bool TurnWallOn;
var() bool TurnOffOnCeaseRelevant;
var() int WallIndex;
var() Vector WallPosition;
var() Vector WallNormal;
var const name WallEnableBaseName;
var const name WallPositionBaseName;
var const name WallNormalBaseName;

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode)
{
    local int I;
    local MaterialInstanceConstant MIC;
    local name WallEnableName;

    // End:0x1E8
    if((TurnWallOn && TurnOffOnCeaseRelevant) && OwningNode != none)
    {
        // End:0x1E8
        if(OwningNode.SkelComponent != none)
        {
            WallEnableName = name(string(WallEnableBaseName) $ string(WallIndex));
            I = 0;
            J0x80:

            // End:0x1E8 [Loop If]
            if(I < OwningNode.SkelComponent.GetNumElements())
            {
                MIC = MaterialInstanceConstant(OwningNode.SkelComponent.GetMaterial(I));
                // End:0x14E
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue(WallEnableName, 0.0000000);
                }
                MIC = MaterialInstanceConstant(OwningNode.SkelComponent.GetDefaultMaterial(I));
                // End:0x1DA
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue(WallEnableName, 0.0000000);
                }
                I++;
                // [Loop Continue]
                goto J0x80;
            }
        }
    }
    //return;    
}

defaultproperties
{
    TurnWallOn=true
    TurnOffOnCeaseRelevant=true
    WallNormal=(X=0.0000000,Y=0.0000000,Z=1.0000000)
    WallEnableBaseName="WallEnable"
    WallPositionBaseName="WallPosition"
    WallNormalBaseName="WallNormal"
}