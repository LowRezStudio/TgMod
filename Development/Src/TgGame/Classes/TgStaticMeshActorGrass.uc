class TgStaticMeshActorGrass extends StaticMeshActor
    hidecategories(Navigation)
    config(Engine);

var float m_fTargetScale;
var Vector m_TargetScale3D;
var float m_fScaleTransitionTime;

function OnChangeScale(TgSeqAct_ChangeScale SeqAct_ChangeScale) { }

event Tick(float DeltaTime) { }

defaultproperties
{}
