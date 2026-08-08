class TgAIController_BehaviorPetRanged extends TgAIController_BehaviorPet
    native(AI)
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    m_fLeadAccuracy=0.8700000
    m_fDegreeMissedMagnitude=2.5000000
    LocalRepulsorSolverClass=Class'TgAILocalPositionSolver_God'
}
