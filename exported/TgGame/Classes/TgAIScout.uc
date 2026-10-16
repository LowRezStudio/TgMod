class TgAIScout extends Scout
    transient
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    PathSizes=/* Array type was not detected. */
    TestJumpZ=600.0000000
    NavMeshGen_EntityHalfHeight=17.5000000
    NavMeshGen_MaxDropHeight=4000.0000000
    NavMeshGen_MaxStepHeight=15.0000000
    NavMeshGen_MaxPolyHeight=120.0000000
    NavMeshGen_MinRadius=25.0000000
    NavMeshGen_MaxRadius=80.0000000
    StandardJumpHeight=128.0000000
    StandardJumpDistance=160.0000000
    NavMeshGen_RecastCellSize=10.0000000
    NavMeshGen_RecastErodeRadius=20.0000000
    MaxStepHeight=15.0000000
    MaxJumpHeight=140.0000000
    // Reference: CylinderComponent'TgGame.Default__TgAIScout.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Scout.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}