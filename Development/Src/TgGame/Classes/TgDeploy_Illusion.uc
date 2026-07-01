class TgDeploy_Illusion extends TgDeployable
    native(ChampYing)
    notplaceable
    hidecategories(Navigation)
    implements(TgInterface_YingIllusion);

// Export UTgDeploy_Illusion::execAcquireTarget(FFrame&, void* const)
native function bool AcquireTarget();