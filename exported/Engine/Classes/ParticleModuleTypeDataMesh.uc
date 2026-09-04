class ParticleModuleTypeDataMesh extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EMeshScreenAlignment
{
    PSMA_MeshFaceCameraWithRoll,    // 0
    PSMA_MeshFaceCameraWithSpin,    // 1
    PSMA_MeshFaceCameraWithLockedAxis,// 2
    PSMA_MAX                        // 3
};

enum EMeshCameraFacingUpAxis
{
    CameraFacing_NoneUP,            // 0
    CameraFacing_ZUp,               // 1
    CameraFacing_NegativeZUp,       // 2
    CameraFacing_YUp,               // 3
    CameraFacing_NegativeYUp,       // 4
    CameraFacing_MAX                // 5
};

enum EMeshCameraFacingOptions
{
    XAxisFacing_NoUp,               // 0
    XAxisFacing_ZUp,                // 1
    XAxisFacing_NegativeZUp,        // 2
    XAxisFacing_YUp,                // 3
    XAxisFacing_NegativeYUp,        // 4
    LockedAxis_ZAxisFacing,         // 5
    LockedAxis_NegativeZAxisFacing, // 6
    LockedAxis_YAxisFacing,         // 7
    LockedAxis_NegativeYAxisFacing, // 8
    VelocityAligned_ZAxisFacing,    // 9
    VelocityAligned_NegativeZAxisFacing,// 10
    VelocityAligned_YAxisFacing,    // 11
    VelocityAligned_NegativeYAxisFacing,// 12
    EMeshCameraFacingOptions_MAX    // 13
};

var(Mesh) StaticMesh Mesh;
var bool CastShadows;
var bool DoCollisions;
var(Mesh) bool bAllowMotionBlur;
var(Mesh) bool bOverrideMaterial;
var(CameraFacing) bool bCameraFacing;
var(CameraFacing) bool bApplyParticleRotationAsSpin;
var(Mesh) ParticleModuleTypeDataMesh.EMeshScreenAlignment MeshAlignment;
var(Orientation) ParticleModuleOrientationAxisLock.EParticleAxisLock AxisLockOption;
var deprecated ParticleModuleTypeDataMesh.EMeshCameraFacingUpAxis CameraFacingUpAxisOption;
var(CameraFacing) ParticleModuleTypeDataMesh.EMeshCameraFacingOptions CameraFacingOption;
var(Orientation) float Pitch;
var(Orientation) float Roll;
var(Orientation) float Yaw;
