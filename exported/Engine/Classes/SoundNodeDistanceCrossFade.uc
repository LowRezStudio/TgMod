class SoundNodeDistanceCrossFade extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

struct native DistanceDatum
{
    var() float FadeInDistanceStart;
    var() float FadeInDistanceEnd;
    var() float FadeOutDistanceStart;
    var() float FadeOutDistanceEnd;
    var() float Volume;
    var deprecated RawDistributionFloat FadeInDistance;
    var deprecated RawDistributionFloat FadeOutDistance;

    structdefaultproperties
    {
        FadeInDistanceStart=0.0000000
        FadeInDistanceEnd=0.0000000
        FadeOutDistanceStart=0.0000000
        FadeOutDistanceEnd=0.0000000
        Volume=1.0000000
    }
};

var() editfixedsize export array<export DistanceDatum> CrossFadeInput;
