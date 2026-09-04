class TgSkelCon_HitReaction extends GameSkelCtrl_Recoil
    native(Anim)
    hidecategories(Object,Object)
    config(Engine)
    dependson(TgObject);

struct RecoilInfo {
    var () RecoilDef Min;
    var () RecoilDef Max;
    structdefaultproperties {}
};

var () private TgObject.RecoilHitDir m_CurrentRecoilDir;
var () TgObject.HitReactionMoveType m_MoveType;
var () RecoilInfo m_RecoilFromFront;
var () RecoilInfo m_RecoilFromBack;
var () RecoilInfo m_RecoilFromLeft;
var () RecoilInfo m_RecoilFromRight;
var () array<name> m_SlaveSkelControlNames;
var transient array<SkelControlBase> m_SlaveSkelControls;
var transient bool m_bInitialized;

simulated event SetRecoilDir(TgObject.RecoilHitDir NewDir) { }

simulated event SetRecoilParam() { }

simulated function Vector VRandRange(Vector v1, Vector v2) { }

simulated function RecoilDef GenRecoil(RecoilInfo RecoilParam) { }

defaultproperties
{
    m_RecoilFromFront=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    m_RecoilFromBack=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    m_RecoilFromLeft=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    m_RecoilFromRight=(Min=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)),Max=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERS_Zero,Y=ERS_Zero,Z=ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)))
    bIgnoreWhenNotRendered=true
}
