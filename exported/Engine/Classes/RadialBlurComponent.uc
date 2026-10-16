class RadialBlurComponent extends ActorComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() const MaterialInterface Material;
var() const Scene.ESceneDepthPriorityGroup DepthPriorityGroup;
var() interp const float BlurScale;
var() interp const float BlurFalloffExponent;
var() interp const float BlurOpacity;
var() const float MaxCullDistance;
var() const float DistanceFalloffExponent;
var() const bool bRenderAsVelocity;
var() const bool bEnabled;
var native const transient Matrix LocalToWorld;

// Export URadialBlurComponent::execSetMaterial(FFrame&, void* const)
native function SetMaterial(MaterialInterface InMaterial);

// Export URadialBlurComponent::execSetBlurScale(FFrame&, void* const)
native function SetBlurScale(float InBlurScale);

// Export URadialBlurComponent::execSetBlurFalloffExponent(FFrame&, void* const)
native function SetBlurFalloffExponent(float InBlurFalloffExponent);

// Export URadialBlurComponent::execSetBlurOpacity(FFrame&, void* const)
native function SetBlurOpacity(float InBlurOpacity);

// Export URadialBlurComponent::execSetEnabled(FFrame&, void* const)
native function SetEnabled(bool bInEnabled);

function OnUpdatePropertyBlurScale()
{
    SetBlurScale(BlurScale);
    //return;    
}

function OnUpdatePropertyBlurFalloffExponent()
{
    SetBlurFalloffExponent(BlurFalloffExponent);
    //return;    
}

function OnUpdatePropertyBlurOpacity()
{
    SetBlurOpacity(BlurOpacity);
    //return;    
}

defaultproperties
{
    DepthPriorityGroup=ESceneDepthPriorityGroup.SDPG_Foreground
    BlurScale=1.0000000
    BlurFalloffExponent=1.5000000
    BlurOpacity=1.0000000
    MaxCullDistance=2000.0000000
    DistanceFalloffExponent=1.5000000
    bRenderAsVelocity=true
    bEnabled=true
}