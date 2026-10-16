class TgParticleSystemComponent extends ParticleSystemComponent
    native
    editinlinenew
    hidecategories(Object,Physics,Collision);

var() export editinline SkeletalMeshComponent m_AttachedToSkelMesh;
var bool m_bReenableAfterTeleport;

defaultproperties
{
    ReplacementPrimitive=none
}