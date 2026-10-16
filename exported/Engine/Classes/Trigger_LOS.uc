class Trigger_LOS extends Trigger
    placeable
    hidecategories(Navigation);

var array<PlayerController> PCsWithLOS;

simulated event Tick(float DeltaTime)
{
    local array<SequenceEvent> losEvents;
    local SeqEvent_LOS Evt;
    local PlayerController Player;
    local int Idx;
    local Vector CameraLoc;
    local Rotator CameraRot;
    local float cameraDist;
    local array<int> ActivateIndices;

    // End:0x379
    if(FindEventsOfClass(Class'Engine.SeqEvent_LOS', losEvents))
    {
        // End:0x378
        foreach WorldInfo.AllControllers(Class'Engine.PlayerController', Player)
        {
            // End:0x377
            if(Player.Pawn != none)
            {
                Player.GetPlayerViewPoint(CameraLoc, CameraRot);
                cameraDist = PointDistToLine(Location, Vector(CameraRot), CameraLoc);
                Idx = 0;
                J0xE6:

                // End:0x377 [Loop If]
                if(Idx < losEvents.Length)
                {
                    Evt = SeqEvent_LOS(losEvents[Idx]);
                    // End:0x2D0
                    if((((cameraDist <= Evt.ScreenCenterDistance) && VSize(Player.Pawn.Location - Location) <= Evt.TriggerDistance) && (Normal(Location - CameraLoc) Dot Vector(CameraRot)) > 0.0000000) && !Evt.bCheckForObstructions || Player.LineOfSightTo(self, CameraLoc))
                    {
                        ActivateIndices[0] = 0;
                        // End:0x2CD
                        if((PCsWithLOS.Find(Player) == -1) && losEvents[Idx].CheckActivate(self, Player.Pawn, false, ActivateIndices))
                        {
                            PCsWithLOS.AddItem(Player);
                        }                        
                    }
                    else
                    {
                        // End:0x369
                        if(PCsWithLOS.Find(Player) != -1)
                        {
                            ActivateIndices[0] = 1;
                            // End:0x369
                            if(losEvents[Idx].CheckActivate(self, Player.Pawn, false, ActivateIndices))
                            {
                                PCsWithLOS.RemoveItem(Player);
                            }
                        }
                    }
                    Idx++;
                    // [Loop Continue]
                    goto J0xE6;
                }
            }            
        }        
    }
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__Trigger_LOS.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Trigger.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    // Reference: SpriteComponent'Engine.Default__Trigger_LOS.Sprite'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Sprite'
    // Archetype: SpriteComponent'Engine.Default__Trigger.Sprite'
    begin object name="Sprite"
        ReplacementPrimitive=none
    end object
    Components[0]=Sprite
    Components[1]=CollisionCylinder
    CollisionComponent=CollisionCylinder
    SupportedEvents[0]=Class'Engine.SeqEvent_LOS'
}