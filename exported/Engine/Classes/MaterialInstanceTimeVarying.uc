class MaterialInstanceTimeVarying extends MaterialInstance
    native(Material);

struct native ParameterValueOverTime
{
    var Guid ExpressionGUID;
    var float StartTime;
    var() name ParameterName;
    var() bool bLoop;
    var() bool bAutoActivate;
    var() float CycleTime;
    var() bool bNormalizeTime;
    var() float OffsetTime;
    var() bool bOffsetFromEnd;

    structdefaultproperties
    {
        ExpressionGUID=(A=0,B=0,C=0,D=0)
        StartTime=-1.0000000
        ParameterName="None"
        bLoop=false
        bAutoActivate=false
        CycleTime=1.0000000
        bNormalizeTime=false
        OffsetTime=0.0000000
        bOffsetFromEnd=false
    }
};

struct native FontParameterValueOverTime extends ParameterValueOverTime
{
    var() Font FontValue;
    var() int FontPage;

    structdefaultproperties
    {
        StartTime=0.0000000
        CycleTime=0.0000000
    }
};

struct native ScalarParameterValueOverTime extends ParameterValueOverTime
{
    var() float ParameterValue;
    var() InterpCurveFloat ParameterValueCurve;

    structdefaultproperties
    {
        StartTime=0.0000000
        CycleTime=0.0000000
    }
};

struct native TextureParameterValueOverTime extends ParameterValueOverTime
{
    var() Texture ParameterValue;

    structdefaultproperties
    {
        StartTime=0.0000000
        CycleTime=0.0000000
    }
};

struct native VectorParameterValueOverTime extends ParameterValueOverTime
{
    var() LinearColor ParameterValue;
    var() InterpCurveVector ParameterValueCurve;

    structdefaultproperties
    {
        ParameterValue=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        StartTime=0.0000000
        CycleTime=0.0000000
    }
};

struct native LinearColorParameterValueOverTime extends ParameterValueOverTime
{
    var() LinearColor ParameterValue;
    var() InterpCurveLinearColor ParameterValueCurve;

    structdefaultproperties
    {
        ParameterValue=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        StartTime=0.0000000
        CycleTime=0.0000000
    }
};

var() bool bAutoActivateAll;
var transient float Duration;
var() array<FontParameterValueOverTime> FontParameterValues;
var() array<ScalarParameterValueOverTime> ScalarParameterValues;
var() array<TextureParameterValueOverTime> TextureParameterValues;
var() array<VectorParameterValueOverTime> VectorParameterValues;
var() array<LinearColorParameterValueOverTime> LinearColorParameterValues;

// Export UMaterialInstanceTimeVarying::execSetParent(FFrame&, void* const)
native function SetParent(MaterialInterface NewParent);

// Export UMaterialInstanceTimeVarying::execSetScalarParameterValue(FFrame&, void* const)
native function SetScalarParameterValue(name ParameterName, float Value);

// Export UMaterialInstanceTimeVarying::execSetScalarCurveParameterValue(FFrame&, void* const)
native function SetScalarCurveParameterValue(name ParameterName, const out InterpCurveFloat Value);

// Export UMaterialInstanceTimeVarying::execSetScalarStartTime(FFrame&, void* const)
native function SetScalarStartTime(name ParameterName, float Value);

// Export UMaterialInstanceTimeVarying::execSetDuration(FFrame&, void* const)
native function SetDuration(float Value);

// Export UMaterialInstanceTimeVarying::execSetTextureParameterValue(FFrame&, void* const)
native function SetTextureParameterValue(name ParameterName, Texture Value);

// Export UMaterialInstanceTimeVarying::execSetVectorParameterValue(FFrame&, void* const)
native function SetVectorParameterValue(name ParameterName, const out LinearColor Value);

// Export UMaterialInstanceTimeVarying::execSetVectorCurveParameterValue(FFrame&, void* const)
native function SetVectorCurveParameterValue(name ParameterName, const out InterpCurveVector Value);

// Export UMaterialInstanceTimeVarying::execSetLinearColorParameterValue(FFrame&, void* const)
native function SetLinearColorParameterValue(name ParameterName, const out LinearColor Value);

// Export UMaterialInstanceTimeVarying::execSetLinearColorCurveParameterValue(FFrame&, void* const)
native function SetLinearColorCurveParameterValue(name ParameterName, const out InterpCurveLinearColor Value);

// Export UMaterialInstanceTimeVarying::execSetVectorStartTime(FFrame&, void* const)
native function SetVectorStartTime(name ParameterName, float Value);

// Export UMaterialInstanceTimeVarying::execSetFontParameterValue(FFrame&, void* const)
native function SetFontParameterValue(name ParameterName, Font FontValue, int FontPage);

// Export UMaterialInstanceTimeVarying::execClearParameterValues(FFrame&, void* const)
native function ClearParameterValues();

// Export UMaterialInstanceTimeVarying::execGetMaxDurationFromAllParameters(FFrame&, void* const)
native function float GetMaxDurationFromAllParameters();

// Export UMaterialInstanceTimeVarying::execCheckForVectorParameterConflicts(FFrame&, void* const)
native function bool CheckForVectorParameterConflicts(name ParameterName);
