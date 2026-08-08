class TgCTFFlagBase extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

var () const int m_nDefenderTaskForce;
var transient TgCarriedFlag m_SpawnedFlag;
var transient TgGame_CTF m_CTFGame;

simulated event PostBeginPlay() { }

function CheckTouching() { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

function SpawnFlag() { }

function DestroyFlag() { }

defaultproperties
{}
