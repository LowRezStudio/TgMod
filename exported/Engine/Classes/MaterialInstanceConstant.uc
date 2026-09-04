class MaterialInstanceConstant extends MaterialInstance
    native(Material)
    collapsecategories
    hidecategories(Object);

struct native FontParameterValue
{
    var() name ParameterName;
    var() Font FontValue;
    var() int FontPage;
    var Guid ExpressionGUID;

    structdefaultproperties
    {
        ParameterName="None"
        FontValue=none
        FontPage=0
        ExpressionGUID=(A=0,B=0,C=0,D=0)
    }
};

struct native ScalarParameterValue
{
    var() name ParameterName;
    var() float ParameterValue;
    var Guid ExpressionGUID;

    structdefaultproperties
    {
        ParameterName="None"
        ParameterValue=0.0000000
        ExpressionGUID=(A=0,B=0,C=0,D=0)
    }
};

struct native TextureParameterValue
{
    var() name ParameterName;
    var() Texture ParameterValue;
    var Guid ExpressionGUID;

    structdefaultproperties
    {
        ParameterName="None"
        ParameterValue=none
        ExpressionGUID=(A=0,B=0,C=0,D=0)
    }
};

struct native VectorParameterValue
{
    var() name ParameterName;
    var() LinearColor ParameterValue;
    var Guid ExpressionGUID;

    structdefaultproperties
    {
        ParameterName="None"
        ParameterValue=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        ExpressionGUID=(A=0,B=0,C=0,D=0)
    }
};

var() const array<FontParameterValue> FontParameterValues;
var() const array<ScalarParameterValue> ScalarParameterValues;
var() const array<TextureParameterValue> TextureParameterValues;
var() const array<VectorParameterValue> VectorParameterValues;

// Export UMaterialInstanceConstant::execSetParent(FFrame&, void* const)
native function SetParent(MaterialInterface NewParent);

// Export UMaterialInstanceConstant::execSetScalarParameterValue(FFrame&, void* const)
native function SetScalarParameterValue(name ParameterName, float Value);

// Export UMaterialInstanceConstant::execSetTextureParameterValue(FFrame&, void* const)
native function SetTextureParameterValue(name ParameterName, Texture Value);

// Export UMaterialInstanceConstant::execSetVectorParameterValue(FFrame&, void* const)
native function SetVectorParameterValue(name ParameterName, const out LinearColor Value);

// Export UMaterialInstanceConstant::execSetFontParameterValue(FFrame&, void* const)
native function SetFontParameterValue(name ParameterName, Font FontValue, int FontPage);

// Export UMaterialInstanceConstant::execGetMobileScalarParameterValue(FFrame&, void* const)
native function bool GetMobileScalarParameterValue(name ParameterName, out float OutValue);

// Export UMaterialInstanceConstant::execGetMobileTextureParameterValue(FFrame&, void* const)
native function bool GetMobileTextureParameterValue(name ParameterName, out Texture OutValue);

// Export UMaterialInstanceConstant::execGetMobileVectorParameterValue(FFrame&, void* const)
native function bool GetMobileVectorParameterValue(name ParameterName, out LinearColor OutValue);

// Export UMaterialInstanceConstant::execClearParameterValues(FFrame&, void* const)
native function ClearParameterValues();
