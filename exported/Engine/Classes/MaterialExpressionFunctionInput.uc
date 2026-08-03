class MaterialExpressionFunctionInput extends MaterialExpression
    native(Material)
    hidecategories(Object,Object);

enum EFunctionInputType
{
    FunctionInput_Scalar,           // 0
    FunctionInput_Vector2,          // 1
    FunctionInput_Vector3,          // 2
    FunctionInput_Vector4,          // 3
    FunctionInput_Texture2D,        // 4
    FunctionInput_TextureCube,      // 5
    FunctionInput_StaticBool,       // 6
    FunctionInput_MAX               // 7
};

var ExpressionInput Preview;
var() string InputName;
var() string Description;
var const Guid Id;
var() MaterialExpressionFunctionInput.EFunctionInputType InputType;
var() Vector4 PreviewValue;
var() bool bUsePreviewValueAsDefault;
var transient bool bCompilingFunctionPreview;
var() int SortPriority;

defaultproperties
{
    InputName="In"
    InputType=EFunctionInputType.FunctionInput_Vector3
    PreviewValue=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=1.0000000)
    bCompilingFunctionPreview=true
    BorderColor=(R=185,G=255,B=172,A=0)
    MenuCategories[0]="Functions"
}