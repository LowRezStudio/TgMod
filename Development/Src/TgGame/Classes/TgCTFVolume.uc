class TgCTFVolume extends PhysicsVolume
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int m_nDefenderTeamIndex;

function TimerPop(VolumeTimer T) { }

function bool IsValidToucher(TgPawn_Character TgP) { }

function int SortByTimestamp(TgPawn A, TgPawn B) { }

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
