class TgAimAccelerationCurves extends Object
    native
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(TgAimAccelerationCurves);

var() name SettingsName;
var() float MaxAccelMultiplierX;
var() float MaxAccelMultiplierY;
var() RawDistributionFloat AimSpeedX;
var() RawDistributionFloat AimAccelX;
var() RawDistributionFloat AimSpeedY;
var() RawDistributionFloat AimAccelY;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgAimAccelerationCurves.DistributionAimSpeedX'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAimSpeedX'
    begin object name="DistributionAimSpeedX" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgAimAccelerationCurves.DistributionAimAccelX'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAimAccelX'
    begin object name="DistributionAimAccelX" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgAimAccelerationCurves.DistributionAimSpeedY'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAimSpeedY'
    begin object name="DistributionAimSpeedY" class=Engine.DistributionFloatConstantCurve
    end object
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgAimAccelerationCurves.DistributionAimAccelY'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAimAccelY'
    begin object name="DistributionAimAccelY" class=Engine.DistributionFloatConstantCurve
    end object
    SettingsName="UnnamedSetting"
    AimSpeedX=(Distribution=Distribution=DistributionAimSpeedX,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AimAccelX=(Distribution=Distribution=DistributionAimAccelX,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AimSpeedY=(Distribution=Distribution=DistributionAimSpeedY,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AimAccelY=(Distribution=Distribution=DistributionAimAccelY,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}