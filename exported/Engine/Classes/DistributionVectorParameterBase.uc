class DistributionVectorParameterBase extends DistributionVectorConstant
    abstract
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var() name ParameterName;
var() Vector MinInput;
var() Vector MaxInput;
var() Vector MinOutput;
var() Vector MaxOutput;
var() export DistributionFloatParameterBase.DistributionParamMode ParamModes[3];

defaultproperties
{
    MaxInput=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    MaxOutput=(X=1.0000000,Y=1.0000000,Z=1.0000000)
}