class TgSilhouetteManager extends Actor
    native(FX)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

struct TgSilhouetteInfo {
};

var Actor m_Owner;
var bool m_bSilhouettesEnabled;
var () const bool m_bForceSilhouetteVisible;
var transient array<TgSilhouetteInfo> m_SilhouetteInfos;
var () Class<TgSilhouetteComponent> m_SilhouetteClass;

native function int InitializeSilhouetteComponent(MeshComponent InMesh, optional float fLifeAfterDeath=-1.0000000);  // Export UTgSilhouetteManager::execInitializeSilhouetteComponent(FFrame&, void* const)

native function int FindSilhouetteInfo(MeshComponent ParentMesh);  // Export UTgSilhouetteManager::execFindSilhouetteInfo(FFrame&, void* const)

native function bool RemoveSilhouetteInfo(MeshComponent ParentMesh);  // Export UTgSilhouetteManager::execRemoveSilhouetteInfo(FFrame&, void* const)

native function ClearAllSilhouetteInfos();  // Export UTgSilhouetteManager::execClearAllSilhouetteInfos(FFrame&, void* const)

native function UpdateSilhouetteVisibility();  // Export UTgSilhouetteManager::execUpdateSilhouetteVisibility(FFrame&, void* const)

native function bool ShouldAnySilhouettesBeVisible();  // Export UTgSilhouetteManager::execShouldAnySilhouettesBeVisible(FFrame&, void* const)

native function TickSilhouettes(float DeltaSeconds);  // Export UTgSilhouetteManager::execTickSilhouettes(FFrame&, void* const)

defaultproperties
{
    m_SilhouetteClass=Class'TgSilhouetteComponentPaladinsDeployable'
}
