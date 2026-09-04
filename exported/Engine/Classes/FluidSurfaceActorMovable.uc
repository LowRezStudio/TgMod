class FluidSurfaceActorMovable extends FluidSurfaceActor
    native(Fluid)
    placeable
    hidecategories(Navigation)
    autoexpandcategories(FluidSurfaceActor,FluidSurfaceComponent);

defaultproperties
{
    // Reference: FluidSurfaceComponent'Engine.Default__FluidSurfaceActorMovable.NewFluidComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'NewFluidComponent'
    // Archetype: FluidSurfaceComponent'Engine.Default__FluidSurfaceActor.NewFluidComponent'
    begin object name="NewFluidComponent"
        ReplacementPrimitive=none
    end object
    FluidComponent=NewFluidComponent
    Components[0]=NewFluidComponent
    Physics=EPhysics.PHYS_Interpolating
    bMovable=true
}