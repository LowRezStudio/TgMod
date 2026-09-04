class TgProj_FragGrenade extends TgProj_FreeGrenade
    native(ChampViktor)
    hidecategories(Navigation)
    config(Engine);

simulated function PostBeginPlay() { }

simulated function SetCookedInfo() { }

simulated function ApplyBounce(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp) { }

simulated function PlayBounceSound() { }

defaultproperties
{}
