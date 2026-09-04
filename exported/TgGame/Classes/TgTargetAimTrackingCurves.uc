class TgTargetAimTrackingCurves extends Object
    native
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(TgTargetAimTrackingCurves);

var() name SettingsName;
var() RawDistributionFloat StrengthByAccuracyX;
var() RawDistributionFloat StrengthByDesiredAngleX;
var() RawDistributionFloat StrengthByAccuracyY;
var() RawDistributionFloat StrengthByDesiredAngleY;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgTargetAimTrackingCurves.DistributionStrengthByAccuracyX'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrengthByAccuracyX'
    begin object name="DistributionStrengthByAccuracyX" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgTargetAimTrackingCurves.DistributionStrengthByDesiredAngleX'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrengthByDesiredAngleX'
    begin object name="DistributionStrengthByDesiredAngleX" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgTargetAimTrackingCurves.DistributionStrengthByAccuracyY'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrengthByAccuracyY'
    begin object name="DistributionStrengthByAccuracyY" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgTargetAimTrackingCurves.DistributionStrengthByDesiredAngleY'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrengthByDesiredAngleY'
    begin object name="DistributionStrengthByDesiredAngleY" class=Engine.DistributionFloatConstantCurve
    end object
    SettingsName="UnnamedSetting"
    StrengthByAccuracyX=(Distribution=Distribution=DistributionStrengthByAccuracyX,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StrengthByDesiredAngleX=(Distribution=Distribution=DistributionStrengthByDesiredAngleX,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StrengthByAccuracyY=(Distribution=Distribution=DistributionStrengthByAccuracyY,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StrengthByDesiredAngleY=(Distribution=Distribution=DistributionStrengthByDesiredAngleY,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}