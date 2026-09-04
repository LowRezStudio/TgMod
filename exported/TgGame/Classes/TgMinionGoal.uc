class TgMinionGoal extends NavigationPoint
    native(AI)
    hidecategories(Navigation,Lighting,LightColor,Force);

var() int m_nLaneNum;
var() int m_nTaskForce;
var() TgActionPoint m_EndPoint;
var() bool m_bUseForFinalDestination;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn TgP;
    local TgAIController_BehaviorLaneNpc LaneNpc;

    TgP = TgPawn(Other);
    // End:0xBD
    if((TgP != none) && int(TgP.GetTaskForceNumber()) == m_nTaskForce)
    {
        LaneNpc = TgAIController_BehaviorLaneNpc(TgP.Controller);
        // End:0xBD
        if(LaneNpc != none)
        {
            LaneNpc.bDespawnOnLoseCombatTarget = true;
        }
    }
    //return;    
}

defaultproperties
{
    m_bUseForFinalDestination=true
    // Reference: CylinderComponent'TgGame.Default__TgMinionGoal.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__NavigationPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=100.0000000
        CollisionRadius=300.0000000
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    Components[5]=none
    bCollideActors=true
    CollisionComponent=CollisionCylinder
}