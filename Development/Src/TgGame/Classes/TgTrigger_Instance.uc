class TgTrigger_Instance extends Trigger
    native(Kismet)
    hidecategories(Navigation)
    config(Engine);

var (MapInstance) editinline int m_nMapId;
var (MapInstance) editinline bool m_nPreload;
var (MapInstance) editinline bool m_nTaskForce;
var (MapInstance) editinline string m_SpawnPointName;

native function HandleTouch(Actor Other, Vector HitLocation, Vector HitNormal);  // Export UTgTrigger_Instance::execHandleTouch(FFrame&, void* const)

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
