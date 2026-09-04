class TgRecoilKeyframe extends Object
    native
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(TgRecoilKeyframe);

var() float firingTime;
var() RawDistributionFloat RecoilPerShot;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgRecoilKeyframe.DistributionRecoilPerShot'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRecoilPerShot'
    begin object name="DistributionRecoilPerShot" class=Engine.DistributionFloatConstantCurve
    end object
    RecoilPerShot=(Distribution=Distribution=DistributionRecoilPerShot,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}