class DistributionFloatParameterBase extends DistributionFloatConstant
    abstract
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

enum DistributionParamMode
{
    DPM_Normal,                     // 0
    DPM_Abs,                        // 1
    DPM_Direct,                     // 2
    DPM_MAX                         // 3
};

var() name ParameterName;
var() float MinInput;
var() float MaxInput;
var() float MinOutput;
var() float MaxOutput;
var() DistributionFloatParameterBase.DistributionParamMode ParamMode;

defaultproperties
{
    MaxInput=1.0000000
    MaxOutput=1.0000000
}