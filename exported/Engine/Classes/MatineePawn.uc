class MatineePawn extends Pawn
    native(Pawn)
    config(Game)
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: SkeletalMeshComponent'Engine.Default__MatineePawn.PawnMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PawnMesh'
    begin object name="PawnMesh" class=Engine.SkeletalMeshComponent
        ReplacementPrimitive=none
        Translation=(X=0.0000000,Y=0.0000000,Z=-72.0000000)
    end object
    Mesh=PawnMesh
    // Reference: CylinderComponent'Engine.Default__MatineePawn.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Pawn.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=72.0000000
        CollisionRadius=30.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=CollisionCylinder
    Components[2]=none
    Components[3]=PawnMesh
    Physics=EPhysics.PHYS_Falling
    CollisionComponent=CollisionCylinder
}