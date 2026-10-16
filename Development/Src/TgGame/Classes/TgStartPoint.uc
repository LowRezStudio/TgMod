class TgStartPoint extends PlayerStart
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force,Collision)
    config(Engine);

var (Object) editconst int m_nMapObjectId;
var () int m_nStartGroup;
var () int m_nReturnMapType;
var () float m_fStartRating;
var () float m_fCurrentRating;
var () float m_fResetRating;
var () float m_fDecreaseRate;
var () array< Class<TgTeleporter> > m_ArrayOfFloats;
var () TgTeleporter m_TgTeleporter;

native function LoadObjectConfig();  // Export UTgStartPoint::execLoadObjectConfig(FFrame&, void* const)

simulated function PreBeginPlay() { }

simulated function float GetRating(Controller Player) { }

simulated function AdjustRating() { }

simulated function int GetStartGroupNumber() { }

defaultproperties
{}
