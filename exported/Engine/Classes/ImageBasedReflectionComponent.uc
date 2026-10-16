class ImageBasedReflectionComponent extends StaticMeshComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object,StaticMeshComponent);

var() bool bEnabled;
var() bool bTwoSided;
var() Texture2D ReflectionTexture;
var() interp LinearColor ReflectionColor;

// Export UImageBasedReflectionComponent::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bSetEnabled);

// Export UImageBasedReflectionComponent::execUpdateImageReflectionParameters(FFrame&, void* const)
native final function UpdateImageReflectionParameters();

function OnUpdatePropertyReflectionColor()
{
    UpdateImageReflectionParameters();
    //return;    
}

defaultproperties
{
    bEnabled=true
    ReflectionTexture=none
    ReflectionColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    WireframeColor=(R=100,G=100,B=200,A=255)
    Materials[0]=none
    ReplacementPrimitive=none
    HiddenGame=true
    bUseAsOccluder=false
    bAcceptsStaticDecals=false
    bAcceptsDynamicDecals=false
    CastShadow=false
    bCastDynamicShadow=false
    bAcceptsLights=false
    bAcceptsDynamicLights=false
    CollideActors=false
    BlockRigidBody=false
}