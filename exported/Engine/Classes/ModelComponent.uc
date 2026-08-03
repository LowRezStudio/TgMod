class ModelComponent extends PrimitiveComponent
    native
    noexport;

var native const noexport transient Object Model;
var native const noexport transient int ZoneIndex;
var native const noexport transient int ComponentIndex;
var native const noexport transient array<Pointer> Nodes;
var native const noexport transient array<Pointer> Elements;

defaultproperties
{
    ReplacementPrimitive=none
    bUseAsOccluder=true
    bAcceptsStaticDecals=true
    CastShadow=true
    bAcceptsLights=true
    bUsePrecomputedShadows=true
    LightingChannels=(bInitialized=true,BSP=true)
}