class GameSkelCtrl_Recoil extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

enum ERecoilStart
{
    ERS_Zero,                       // 0
    ERS_Random,                     // 1
    ERS_MAX                         // 2
};

struct native RecoilParams
{
    var() GameSkelCtrl_Recoil.ERecoilStart X;
    var() GameSkelCtrl_Recoil.ERecoilStart Y;
    var() GameSkelCtrl_Recoil.ERecoilStart Z;
    var const transient byte Padding;

    structdefaultproperties
    {
        X=ERecoilStart.ERS_Zero
        Y=ERecoilStart.ERS_Zero
        Z=ERecoilStart.ERS_Zero
        Padding=0
    }
};

struct native RecoilDef
{
    var transient float TimeToGo;
    var() float TimeDuration;
    var() Vector RotAmplitude;
    var() Vector RotFrequency;
    var Vector RotSinOffset;
    var() RecoilParams RotParams;
    var transient Rotator RotOffset;
    var() Vector LocAmplitude;
    var() Vector LocFrequency;
    var Vector LocSinOffset;
    var() RecoilParams LocParams;
    var transient Vector LocOffset;

    structdefaultproperties
    {
        TimeToGo=0.0000000
        TimeDuration=0.3300000
        RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0)
        RotOffset=(Pitch=0,Yaw=0,Roll=0)
        LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0)
        LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var() bool bBoneSpaceRecoil;
var() transient bool bPlayRecoil;
var transient bool bOldPlayRecoil;
var transient bool bApplyControl;
var() bool m_bBlendIn;
var() RecoilDef Recoil;
var() Vector2D Aim;
var() float m_bBlendInRemainingTime;
var transient Vector m_BlendLoc;
var transient Rotator m_BlendRot;

simulated event SetRecoilParam()
{
    //return;    
}

defaultproperties
{
    Recoil=(TimeToGo=0.0000000,TimeDuration=0.3300000,RotAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),RotParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),RotOffset=(Pitch=0,Yaw=0,Roll=0),LocAmplitude=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocFrequency=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000),LocParams=(X=ERecoilStart.ERS_Zero,Y=ERecoilStart.ERS_Zero,Z=ERecoilStart.ERS_Zero,Padding=0),LocOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000))
}