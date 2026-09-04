class TgPawn_Structure extends TgPawn
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var float s_fLastDamageTime;
var float s_fDamageNotificationDelay;

native function bool CanMove();  // Export UTgPawn_Structure::execCanMove(FFrame&, void* const)

function SendAttackAlert() { }

function SendDeathAlert() { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated event PlayDeathAnimation() { }

simulated event PostDemoRewind() { }

function SetMovementPhysics() { }

state Intro {}

defaultproperties
{}
