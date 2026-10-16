interface Interface_AIAnnotation extends Interface
    abstract
    native(Navigation);

// Export UInterface_AIAnnotation::execGetAdjustedPosition(FFrame&, void* const)
native function GetAdjustedPosition(out Vector out_Position, Pawn AnnotationOwner, Actor Target);
