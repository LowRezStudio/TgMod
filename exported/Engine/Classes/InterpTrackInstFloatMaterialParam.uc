class InterpTrackInstFloatMaterialParam extends InterpTrackInst
    native(Interpolation);

struct native FloatMaterialParamMICData
{
    var const array<MaterialInstanceConstant> MICs;
    var const array<float> MICResetFloats;

    structdefaultproperties
    {
        MICs=none
        MICResetFloats=none
    }
};

var array<FloatMaterialParamMICData> MICInfos;
var InterpTrackFloatMaterialParam InstancedTrack;
