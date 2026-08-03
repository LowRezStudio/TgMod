class BattlePlayerController extends TgPlayerController
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

// Export UBattlePlayerController::execBattlePlayerControllerFunction(FFrame&, void* const)
native function BattlePlayerControllerFunction();

defaultproperties
{
    // Reference: CylinderComponent'BattleGame.Default__BattlePlayerController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}