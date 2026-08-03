class TgSkelCon_HitReaction extends GameSkelCtrl_Recoil
    native(Anim)
    hidecategories(Object,Object);

struct native RecoilInfo
{
    var() RecoilDef Min;
    var() RecoilDef Max;

    structdefaultproperties
    {
        Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000))
        Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000))
    }
};

var() private TgObject.RecoilHitDir m_CurrentRecoilDir;
var() TgObject.HitReactionMoveType m_MoveType;
var() RecoilInfo m_RecoilFromFront;
var() RecoilInfo m_RecoilFromBack;
var() RecoilInfo m_RecoilFromLeft;
var() RecoilInfo m_RecoilFromRight;
var() array<name> m_SlaveSkelControlNames;
var transient array<SkelControlBase> m_SlaveSkelControls;
var transient bool m_bInitialized;

simulated event SetRecoilDir(TgObject.RecoilHitDir NewDir)
{
    m_CurrentRecoilDir = NewDir;
    //return;    
}

simulated event SetRecoilParam()
{
    switch(m_CurrentRecoilDir)
    {
        // End:0x38
        case 0:
            Recoil = GenRecoil(m_RecoilFromFront);
            // End:0xAA
            break;
        // End:0x5D
        case 1:
            Recoil = GenRecoil(m_RecoilFromBack);
            // End:0xAA
            break;
        // End:0x82
        case 2:
            Recoil = GenRecoil(m_RecoilFromLeft);
            // End:0xAA
            break;
        // End:0xA7
        case 3:
            Recoil = GenRecoil(m_RecoilFromRight);
            // End:0xAA
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated function Vector VRandRange(Vector v1, Vector v2)
{
    local Vector Result;

    Result.X = RandRange(v1.X, v2.X);
    Result.Y = RandRange(v1.Y, v2.Y);
    Result.Z = RandRange(v1.Z, v2.Z);
    return Result;
    //return ReturnValue;    
}

simulated function RecoilDef GenRecoil(RecoilInfo RecoilParam)
{
    local RecoilDef newRecoil;

    newRecoil.LocAmplitude = VRandRange(RecoilParam.Min.LocAmplitude, RecoilParam.Max.LocAmplitude);
    newRecoil.LocFrequency = VRandRange(RecoilParam.Min.LocFrequency, RecoilParam.Max.LocFrequency);
    newRecoil.LocOffset = VRandRange(RecoilParam.Min.LocOffset, RecoilParam.Max.LocOffset);
    newRecoil.LocParams = RecoilParam.Min.LocParams;
    newRecoil.LocSinOffset = VRandRange(RecoilParam.Min.LocSinOffset, RecoilParam.Max.LocSinOffset);
    newRecoil.RotAmplitude = VRandRange(RecoilParam.Min.RotAmplitude, RecoilParam.Max.RotAmplitude);
    newRecoil.RotFrequency = VRandRange(RecoilParam.Min.RotFrequency, RecoilParam.Max.RotFrequency);
    newRecoil.RotOffset = Rotator(VRandRange(Vector(RecoilParam.Min.RotOffset), Vector(RecoilParam.Max.RotOffset)));
    newRecoil.RotParams = RecoilParam.Min.RotParams;
    newRecoil.RotSinOffset = VRandRange(RecoilParam.Min.RotSinOffset, RecoilParam.Max.RotSinOffset);
    newRecoil.TimeDuration = RandRange(RecoilParam.Min.TimeDuration, RecoilParam.Max.TimeDuration);
    newRecoil.TimeToGo = Recoil.TimeToGo;
    return newRecoil;
    //return ReturnValue;    
}

defaultproperties
{
    m_RecoilFromFront=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    m_RecoilFromBack=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    m_RecoilFromLeft=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    m_RecoilFromRight=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    bIgnoreWhenNotRendered=true
}