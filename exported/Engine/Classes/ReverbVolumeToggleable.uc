class ReverbVolumeToggleable extends ReverbVolume
    placeable
    dontsortcategories(ReverbVolume)
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Volume);

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bEnabled = !bEnabled;
            }
        }
    }
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.ReverbVolume.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__ReverbVolumeToggleable.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__ReverbVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    CollisionComponent=BrushComponent0
}