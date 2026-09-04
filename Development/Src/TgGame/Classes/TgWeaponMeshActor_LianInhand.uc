class TgWeaponMeshActor_LianInhand extends TgWeaponMeshActor
    native(ChampPrincess)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const GRACE_TRACER_FX_ID = 8105;

const GRACE_TRACER_DURATION = 1.0f;

var TgPawn_Princess m_CachedLian;
var TgBeamHelper c_GraceTracers[15];
var bool c_bTracersVisible;

simulated function bool HasCachedLian() { }

simulated function ShowGraceTracers() { }

simulated function HideGraceTracers() { }

simulated function ClearGraceTracers() { }

simulated function ClearGraceTracer(int Index) { }

simulated event ManageGraceTracer(int Index) { }

simulated event ManageGraceTracers() { }

defaultproperties
{}
