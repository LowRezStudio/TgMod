class TgSkeletalMeshActor_LobbyBase extends TgSkeletalMeshActor_Loader
    abstract
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader)
    config(Engine);

var transient bool m_bPlayTransitionOutro;
var string m_TransitionActorClassName;
var transient int m_nCharacterMastery;
var transient TgMenuTransitionActor m_TransitionActor;

simulated event PreBeginPlay() { }

simulated event PostBeginPlay() { }

simulated event BeginTransition(optional bool bPlayFx=false) { }

simulated event EndTransition() { }

simulated event Destroyed() { }

defaultproperties
{}
