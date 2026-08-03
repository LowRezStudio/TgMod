class MaterialExpressionMaterialFunctionCall extends MaterialExpression
    native(Material)
    hidecategories(Object,Object);

struct native FunctionExpressionInput
{
    var transient MaterialExpressionFunctionInput ExpressionInput;
    var Guid ExpressionInputId;
    var ExpressionInput Input;

    structdefaultproperties
    {
        ExpressionInput=none
        ExpressionInputId=(A=0,B=0,C=0,D=0)
        Input=(Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    }
};

struct native FunctionExpressionOutput
{
    var transient MaterialExpressionFunctionOutput ExpressionOutput;
    var Guid ExpressionOutputId;
    var ExpressionOutput Output;

    structdefaultproperties
    {
        ExpressionOutput=none
        ExpressionOutputId=(A=0,B=0,C=0,D=0)
        Output=(OutputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0)
    }
};

var() MaterialFunction MaterialFunction;
var array<FunctionExpressionInput> FunctionInputs;
var array<FunctionExpressionOutput> FunctionOutputs;

defaultproperties
{
    bShowOutputNameOnPin=true
    bHidePreviewWindow=true
    BorderColor=(R=0,G=116,B=255,A=0)
    MenuCategories[0]="Functions"
}