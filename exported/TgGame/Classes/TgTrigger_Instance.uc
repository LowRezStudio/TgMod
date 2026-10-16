class TgTrigger_Instance extends Trigger
    native(Kismet)
    hidecategories(Navigation);

var(MapInstance) editinline int m_nMapId;
var(MapInstance) editinline bool m_nPreload;
var(MapInstance) editinline bool m_nTaskForce;
var(MapInstance) editinline string m_SpawnPointName;

// Export UTgTrigger_Instance::execHandleTouch(FFrame&, void* const)
native function HandleTouch(Actor Other, Vector HitLocation, Vector HitNormal);

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
    HandleTouch(Other, HitLocation, HitNormal);
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgTrigger_Instance.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Trigger.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=96.0000000
        CollisionRadius=5000.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    // Reference: SpriteComponent'TgGame.Default__TgTrigger_Instance.Sprite'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Sprite'
    // Archetype: SpriteComponent'Engine.Default__Trigger.Sprite'
    begin object name="Sprite"
        ReplacementPrimitive=none
    end object
    Components[0]=Sprite
    Components[1]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}