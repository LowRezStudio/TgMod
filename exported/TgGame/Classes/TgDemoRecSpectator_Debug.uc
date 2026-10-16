class TgDemoRecSpectator_Debug extends TgDemoRecSpectator
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var Player m_OriginalPlayer;
var PlayerController m_OriginalPlayerController;

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgDemoRecSpectator_Debug.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgDemoRecSpectator.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}