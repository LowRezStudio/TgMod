class InterpGroupInstAI extends InterpGroupInst
    native(Interpolation);

var transient InterpGroupAI AIGroup;
var Actor.EPhysics SavedPhysics;
var bool bSavedNoEncroachCheck;
var bool bSavedCollideActors;
var bool bSavedBlockActors;
var transient Actor StageMarkActor;
