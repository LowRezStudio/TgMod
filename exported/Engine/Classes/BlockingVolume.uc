class BlockingVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display);

var() bool bBlockCamera;

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x5A
    if(Action.InputLinks[0].bHasImpulse)
    {
        CollisionComponent.SetBlockRigidBody(true);        
    }
    else
    {
        // End:0xB4
        if(Action.InputLinks[1].bHasImpulse)
        {
            CollisionComponent.SetBlockRigidBody(false);            
        }
        else
        {
            // End:0x12C
            if(Action.InputLinks[2].bHasImpulse)
            {
                CollisionComponent.SetBlockRigidBody(!CollisionComponent.BlockRigidBody);
            }
        }
    }
    super.OnToggle(Action);
    //return;    
}

defaultproperties
{
    bBlockCamera=true
    // Reference: BrushComponent'Engine.Default__BlockingVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        bBlockComplexCollisionTrace=true
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_BlockingVolume
        BlockActors=true
        BlockZeroExtent=true
        BlockRigidBody=true
        bSeenByAI=true
        bDisableAllRigidBody=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bWorldGeometry=true
    bBlockActors=true
    bProjTarget=true
    CollisionComponent=BrushComponent0
}