class TgEmitterCrashlanding extends TgEmitterSpawnable
    hidecategories(Navigation)
    config(Engine);

var export editinline StaticMeshComponent m_PrimaryMesh;
var export editinline StaticMeshComponent m_SecondaryMesh;
var float ParticleDurationAfterImpact;
var export editinline LensFlareComponent m_LensFlare;
var export editinline AudioComponent m_AudioComponent;

simulated function SetPrimaryMesh(StaticMesh StaticMeshToSet) { }

simulated function SetSecondaryMesh(StaticMesh StaticMeshToSet) { }

simulated function SetAudio(SoundCue SoundCueToSet) { }

simulated function OnImpact() { }

simulated function PostImpactComplete() { }

defaultproperties
{}
