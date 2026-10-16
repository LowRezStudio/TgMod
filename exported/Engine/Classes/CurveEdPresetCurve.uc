class CurveEdPresetCurve extends Object
    native
    editinlinenew
    hidecategories(Object);

struct native PresetGeneratedPoint
{
    var float KeyIn;
    var float KeyOut;
    var bool TangentsValid;
    var float TangentIn;
    var float TangentOut;
    var Object.EInterpCurveMode IntepMode;

    structdefaultproperties
    {
        KeyIn=0.0000000
        KeyOut=0.0000000
        TangentsValid=false
        TangentIn=0.0000000
        TangentOut=0.0000000
        IntepMode=EInterpCurveMode.CIM_Linear
    }
};

var() const localized string CurveName;
var array<PresetGeneratedPoint> Points;
