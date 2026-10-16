interface Interface_ActorPathConstraints extends Interface
    abstract
    native(AI);

// Export UInterface_ActorPathConstraints::execSolveConstraints(FFrame&, void* const)
native function SolveConstraints(const Vector InitialPosition, const float MaxDistance, out Vector OutDesiredPosition);
