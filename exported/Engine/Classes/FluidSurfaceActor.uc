class FluidSurfaceActor extends Actor
    native(Fluid)
    placeable
    hidecategories(Navigation)
    classgroup(Fluid)
    autoexpandcategories(FluidSurfaceActor,FluidSurfaceComponent);

var() const editconst export editinline FluidSurfaceComponent FluidComponent;
var() ParticleSystem ProjectileEntryEffect;

simulated event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    FluidComponent.ApplyForce(HitLocation, FluidComponent.ForceImpact, FluidComponent.TestRippleRadius, true);
    //return;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
    Other.ApplyFluidSurfaceImpact(self, HitLocation);
    //return;    
}

defaultproperties
{
    // Reference: FluidSurfaceComponent'Engine.Default__FluidSurfaceActor.NewFluidComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'NewFluidComponent'
    begin object name="NewFluidComponent" class=Engine.FluidSurfaceComponent
        ReplacementPrimitive=none
    end object
    FluidComponent=NewFluidComponent
    Components[0]=NewFluidComponent
    bNoDelete=true
    bMovable=false
    bCollideActors=true
    bProjTarget=true
}