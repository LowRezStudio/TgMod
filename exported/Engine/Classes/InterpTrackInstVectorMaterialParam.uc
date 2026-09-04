class InterpTrackInstVectorMaterialParam extends InterpTrackInst
    native(Interpolation);

struct native VectorMaterialParamMICData
{
    var const array<MaterialInstanceConstant> MICs;
    var const array<Vector> MICResetVectors;

    structdefaultproperties
    {
        MICs=none
        MICResetVectors=none
    }
};

var array<VectorMaterialParamMICData> MICInfos;
var InterpTrackVectorMaterialParam InstancedTrack;
