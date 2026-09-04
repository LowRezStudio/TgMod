class TgAnimNotify_PlayParticleEffect_Skinned extends AnimNotify_PlayParticleEffect
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct PPE_Skin {
    var () int nSkinId;
    var () ParticleSystem PSTemplate;
    structdefaultproperties {}
};

var () array<PPE_Skin> m_SkinOverrideList;
var () bool m_bApplyTeamColor;

native function ParticleSystem GetParticleSystemToPlay(SkeletalMeshComponent skel);  // Export UTgAnimNotify_PlayParticleEffect_Skinned::execGetParticleSystemToPlay(FFrame&, void* const)

native function ParticleChannelContainer GetParticleChannels(SkeletalMeshComponent skel);  // Export UTgAnimNotify_PlayParticleEffect_Skinned::execGetParticleChannels(FFrame&, void* const)

defaultproperties
{
    m_bApplyTeamColor=true
}
