class TgAIController_BehaviorPet_LongTerm extends TgAIController_BehaviorPet
    native(AI)
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    LocalRepulsorSolverClass=Class'TgAILocalPositionSolver_Pet'
}
