class TgTimeDilationVolume extends PhysicsVolume
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var float m_fTimeMultiplier;
var bool m_bAffectInstigator;
var array<Actor> m_AffectedActors;
var array<Pawn> m_AffectedPawns;

simulated event PostBeginPlay() { }

event ActorEnteredVolume(Actor Other) { }

event ActorLeavingVolume(Actor Other) { }

event PawnEnteredVolume(Pawn Other) { }

event PawnLeavingVolume(Pawn Other) { }

event Destroyed() { }

defaultproperties
{}
