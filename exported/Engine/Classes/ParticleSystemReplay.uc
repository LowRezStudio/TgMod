class ParticleSystemReplay extends Object
    native(Particle)
    hidecategories(Object)
    autoexpandcategories(ParticleSystemReplay);

struct native ParticleEmitterReplayFrame
{
    var native const int EmitterType;
    var native const int OriginalEmitterIndex;
    var native const Pointer FrameState;
};

struct native ParticleSystemReplayFrame
{
    var native const array<ParticleEmitterReplayFrame> Emitters;
};

var() native int ClipIDNumber;
var native const array<ParticleSystemReplayFrame> Frames;
