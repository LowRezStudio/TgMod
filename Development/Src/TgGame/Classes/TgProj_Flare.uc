class TgProj_Flare extends TgProj_FreeGrenade
    native(ChampOwl)
    hidecategories(Navigation)
    config(Engine);

var bool m_bStartedPulse;
var float m_fLifetimeForPhysicsSubstep;

simulated function StartPulse() { }

event PostProjectileInitialize() { }

simulated function PulseVisibility() { }

event bool UseAOE() { }

native function float GetGravityZ();  // Export UTgProj_Flare::execGetGravityZ(FFrame&, void* const)

defaultproperties
{}
