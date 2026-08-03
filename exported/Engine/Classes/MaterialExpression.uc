class MaterialExpression extends Object
    abstract
    native(Material)
    hidecategories(Object);

struct ExpressionInput
{
    var MaterialExpression Expression;
    var int OutputIndex;
    var string InputName;
    var int Mask;
    var int MaskR;
    var int MaskG;
    var int MaskB;
    var int MaskA;
    var int GCC64_Padding;

    structdefaultproperties
    {
        Expression=none
        OutputIndex=0
        InputName=""
        Mask=0
        MaskR=0
        MaskG=0
        MaskB=0
        MaskA=0
        GCC64_Padding=0
    }
};

struct ExpressionOutput
{
    var string OutputName;
    var int Mask;
    var int MaskR;
    var int MaskG;
    var int MaskB;
    var int MaskA;

    structdefaultproperties
    {
        OutputName=""
        Mask=0
        MaskR=0
        MaskG=0
        MaskB=0
        MaskA=0
    }
};

var deprecated int EditorX;
var deprecated int EditorY;
var bool bRealtimePreview;
var transient bool bNeedToUpdatePreview;
var bool bIsParameterExpression;
var bool bShowOutputNameOnPin;
var bool bHidePreviewWindow;
var bool bShowInputs;
var bool bShowOutputs;
var bool bUsedByStaticParameterSet;
var const Material Material;
var const MaterialFunction Function;
var() string Desc;
var Color BorderColor;
var array<name> MenuCategories;
var array<ExpressionOutput> Outputs;

defaultproperties
{
    bShowInputs=true
    bShowOutputs=true
    Outputs[0]=(OutputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0)
}