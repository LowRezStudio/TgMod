class InterpCurveEdSetup extends Object
    native;

struct native CurveEdEntry
{
    var Object CurveObject;
    var Color CurveColor;
    var string CurveName;
    var int bHideCurve;
    var int bColorCurve;
    var int bFloatingPointColorCurve;
    var int bClamp;
    var float ClampLow;
    var float ClampHigh;

    structdefaultproperties
    {
        CurveObject=none
        CurveColor=(R=0,G=0,B=0,A=0)
        CurveName=""
        bHideCurve=0
        bColorCurve=0
        bFloatingPointColorCurve=0
        bClamp=0
        ClampLow=0.0000000
        ClampHigh=0.0000000
    }
};

struct native CurveEdTab
{
    var string TabName;
    var array<CurveEdEntry> Curves;
    var float ViewStartInput;
    var float ViewEndInput;
    var float ViewStartOutput;
    var float ViewEndOutput;

    structdefaultproperties
    {
        TabName=""
        Curves=none
        ViewStartInput=0.0000000
        ViewEndInput=0.0000000
        ViewStartOutput=0.0000000
        ViewEndOutput=0.0000000
    }
};

var array<CurveEdTab> Tabs;
var int ActiveTab;

defaultproperties
{
    Tabs[0]=(TabName="Default",Curves=none,ViewStartInput=0.0000000,ViewEndInput=1.0000000,ViewStartOutput=-1.0000000,ViewEndOutput=1.0000000)
}