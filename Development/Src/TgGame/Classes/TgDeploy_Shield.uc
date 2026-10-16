class TgDeploy_Shield extends TgDeployable
    native(Deployable)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool bBasedOnPawn;

event BaseChange() { }

simulated function Destroyed() { }

defaultproperties
{}
