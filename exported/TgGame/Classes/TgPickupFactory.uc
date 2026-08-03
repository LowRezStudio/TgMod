class TgPickupFactory extends PickupFactory
    abstract
    native(Inventory)
    hidecategories(Navigation,Lighting,LightColor,Force,Display,Collision);

var bool bRotatingPickup;
var float YawRotationRate;
var Controller TeamOwner[4];
var export editinline PrimitiveComponent BaseMesh;

function bool ShouldCamp(TgAIController B, float MaxWait)
{
    return ((ReadyToPickup(MaxWait)) && B.RatePickup(self, InventoryType) > float(0)) && !ReadyToPickup(0.0000000);
    //return ReturnValue;    
}

static simulated function UpdateHUD(TgHUD H)
{
    //return;    
}

function RespawnEffect()
{
    //return;    
}

simulated function bool StopsProjectile(Projectile P)
{
    local editinline CylinderComponent CylComp;
    local Actor HitActor;
    local Vector HitNormal, HitLocation;

    CylComp = CylinderComponent(P.CollisionComponent);
    // End:0x134
    if((CylComp != none) && (CylComp.CollisionRadius > float(0)) || CylComp.CollisionHeight > float(0))
    {
        HitActor = Trace(HitLocation, HitNormal, P.Location, P.Location - (float(100) * Normal(P.Velocity)), true, vect(0.0000000, 0.0000000, 0.0000000));
        // End:0x134
        if(HitActor != self)
        {
            return false;
        }
    }
    return bProjTarget || bBlockActors;
    //return ReturnValue;    
}

defaultproperties
{
    YawRotationRate=32768.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPickupFactory.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__PickupFactory.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=44.0000000
        CollisionRadius=34.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=CollisionCylinder
    Components[3]=none
    CollisionComponent=CollisionCylinder
}