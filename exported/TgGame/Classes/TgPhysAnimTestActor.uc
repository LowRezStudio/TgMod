class TgPhysAnimTestActor extends Actor
    placeable
    hidecategories(Navigation);

enum EPATAState
{
    PATA_FixedAll,                  // 0
    PATA_FixedLower,                // 1
    PATA_MotorRagdoll,              // 2
    PATA_Floppy,                    // 3
    PATA_Recover,                   // 4
    PATA_MAX                        // 5
};

var() array<name> LowerBoneNames;
var() array<name> LinearBoneSpringNames;
var() array<name> AngularBoneSpringNames;
var() export editinline SkeletalMeshComponent SkeletalMeshComponent;
var TgPhysAnimTestActor.EPATAState CurrentState;
var bool bBlendToGetUp;
var bool bBlendingBack;
var bool bRampingDownMotors;
var bool bNextPokeKnocksDown;
var float GetUpBlendStartTime;
var() float GetUpBlendTime;
var() float GetUpToIdleTime;
var() float ActorOriginHeight;
var() float PokePauseTime;
var() float PokeBlendTime;
var float BlendBackStartTime;
var float MotorDownStartTime;
var() float MotorDownTime;
var() float MotorDownAnimTime;
var() float BlendStaggerAnimTime;
var() float StaggerSpeedAdj;
var() float StaggerVel;
var Vector MoveDir;
var() float AngularHipDriveScale;
var() float StaggerMuscleScale;
var AnimNodeBlend BlendNode;
var AnimNodeSequence GetUpNode;
var AnimNodeSequence RunNode;
var RB_BodyInstance HipBody;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    BlendNode = AnimNodeBlend(SkeletalMeshComponent.FindAnimNode('Blend'));
    GetUpNode = AnimNodeSequence(SkeletalMeshComponent.FindAnimNode('GetUp'));
    RunNode = AnimNodeSequence(SkeletalMeshComponent.FindAnimNode('Run'));
    HipBody = SkeletalMeshComponent.FindBodyInstanceNamed('Hips');
    SetPATAState(0);
    //return;    
}

simulated function BoneImpulse(Vector Impulse, name BoneName)
{
    local Vector Loc;

    Loc = SkeletalMeshComponent.GetBoneLocation(BoneName);
    SkeletalMeshComponent.AddImpulse(Impulse, Loc, BoneName, true);
    //return;    
}

simulated function bool PrePokeActor(Vector PokeDir)
{
    SetPATAState(1);
    bBlendingBack = true;
    BlendBackStartTime = WorldInfo.TimeSeconds + PokePauseTime;
    return true;
    //return ReturnValue;    
}

simulated function bool PreGrab()
{
    // End:0x16
    if(int(CurrentState) == int(1))
    {
        return false;
    }
    // End:0x42
    if(int(CurrentState) == int(0))
    {
        bNextPokeKnocksDown = true;
        SetPATAState(1);
    }
    return true;
    //return ReturnValue;    
}

simulated function EndGrab()
{
    // End:0x48
    if(int(CurrentState) == int(1))
    {
        bBlendingBack = true;
        BlendBackStartTime = WorldInfo.TimeSeconds;
    }
    //return;    
}

simulated function SetPATAState(TgPhysAnimTestActor.EPATAState NewState)
{
    // End:0x16
    if(int(CurrentState) == int(4))
    {
        return;
    }
    // End:0x42
    if((int(NewState) == int(4)) && int(CurrentState) != int(3))
    {
        return;
    }
    // End:0x8A
    if(int(NewState) == int(0))
    {
        RunNode.bPlaying = true;
        SetPhysics(7);
        SetBodiesFixed(true);        
    }
    else
    {
        // End:0xE7
        if(int(NewState) == int(1))
        {
            RunNode.bPlaying = true;
            SetPhysics(7);
            SetLowerFixed();
            EnableMotors(true);
            SetBoneSprings(true);            
        }
        else
        {
            // End:0x151
            if(int(NewState) == int(2))
            {
                RunNode.bPlaying = true;
                SetPhysics(10);
                SetBodiesFixed(false);
                EnableMotors(true);
                bBlendingBack = false;
                SetBoneSprings(false);                
            }
            else
            {
                // End:0x1C5
                if(int(NewState) == int(3))
                {
                    RunNode.bPlaying = false;
                    SetPhysics(10);
                    SetBodiesFixed(false);
                    EnableMotors(false);
                    bBlendingBack = false;
                    SetBoneSprings(false);
                    DetachAttachments();                    
                }
                else
                {
                    // End:0x1E3
                    if(int(NewState) == int(4))
                    {
                        RecoverFromRagdoll();
                    }
                }
            }
        }
    }
    CurrentState = NewState;
    //return;    
}

simulated function EnableMotors(bool InEnabled)
{
    SkeletalMeshComponent.PhysicsAssetInstance.SetAllMotorsAngularPositionDrive(InEnabled, InEnabled);
    //return;    
}

simulated function SetBodiesFixed(bool InFixed)
{
    SkeletalMeshComponent.PhysicsAssetInstance.SetAllBodiesFixed(InFixed);
    //return;    
}

simulated function bool IsLowerBodyName(name InName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < LowerBoneNames.Length)
    {
        // End:0x46
        if(LowerBoneNames[I] == InName)
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

simulated function DetachAttachments()
{
    local int I;
    local Actor A;
    local array<Actor> TempAttachments;

    I = 0;
    J0x0B:

    // End:0x58 [Loop If]
    if(I < Attached.Length)
    {
        TempAttachments[I] = Attached[I];
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x63:

    // End:0x120 [Loop If]
    if(I < TempAttachments.Length)
    {
        A = TempAttachments[I];
        // End:0x112
        if(A != none)
        {
            A.SetBase(none);
            A.SetPhysics(10);
            A.CollisionComponent.SetBlockRigidBody(true);
        }
        I++;
        // [Loop Continue]
        goto J0x63;
    }
    //return;    
}

simulated function SetLowerFixed()
{
    local RB_BodyInstance BodyInst;
    local RB_BodySetup BodySetup;
    local int I;

    I = 0;
    J0x0B:

    // End:0x157 [Loop If]
    if(I < SkeletalMeshComponent.PhysicsAsset.BodySetup.Length)
    {
        BodyInst = SkeletalMeshComponent.PhysicsAssetInstance.Bodies[I];
        BodySetup = SkeletalMeshComponent.PhysicsAsset.BodySetup[I];
        // End:0x129
        if(IsLowerBodyName(BodySetup.BoneName))
        {
            BodyInst.SetFixed(true);            
        }
        else
        {
            BodyInst.SetFixed(false);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function bool IsLinearBoneSpringName(name InName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < LinearBoneSpringNames.Length)
    {
        // End:0x46
        if(LinearBoneSpringNames[I] == InName)
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool IsAngularBoneSpringName(name InName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < AngularBoneSpringNames.Length)
    {
        // End:0x46
        if(AngularBoneSpringNames[I] == InName)
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

simulated function SetBoneSprings(bool bEnabled)
{
    local RB_BodyInstance BodyInst;
    local RB_BodySetup BodySetup;
    local int I, BoneIndex;
    local bool bEnableLinear, bEnableAngular;
    local Matrix BoneMatrix;

    I = 0;
    J0x0B:

    // End:0x23E [Loop If]
    if(I < SkeletalMeshComponent.PhysicsAsset.BodySetup.Length)
    {
        BodyInst = SkeletalMeshComponent.PhysicsAssetInstance.Bodies[I];
        BodySetup = SkeletalMeshComponent.PhysicsAsset.BodySetup[I];
        bEnableLinear = IsLinearBoneSpringName(BodySetup.BoneName);
        bEnableAngular = IsAngularBoneSpringName(BodySetup.BoneName);
        // End:0x230
        if(bEnableLinear || bEnableAngular)
        {
            BoneIndex = SkeletalMeshComponent.MatchRefBone(BodySetup.BoneName);
            BoneMatrix = SkeletalMeshComponent.GetBoneMatrix(BoneIndex);
            BodyInst.EnableBoneSpring(bEnabled && bEnableLinear, bEnabled && bEnableAngular, BoneMatrix);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function RecoverFromRagdoll()
{
    local Vector HitLocation, HitNormal, TraceStart, TraceEnd, HeightVec;

    local Rotator NewRotation;
    local bool GetUpFromBack;

    SkeletalMeshComponent.bUpdateKinematicBonesFromAnimation = false;
    HeightVec = vect(0.0000000, 0.0000000, 1.0000000) * ActorOriginHeight;
    TraceStart = Location + HeightVec;
    TraceEnd = Location - HeightVec;
    // End:0xD3
    if(Trace(HitLocation, HitNormal, TraceEnd, TraceStart, true, vect(20.0000000, 20.0000000, 0.0000000) + HeightVec) != none)
    {
        SetLocation(HitLocation);
    }
    SetPhysics(7);
    GetUpFromBack = SkeletalMeshComponent.GetBoneAxis('head', 2).Z > 0.0000000;
    NewRotation = Rotation;
    NewRotation.Yaw = Rotator(SkeletalMeshComponent.GetBoneAxis('Hips', 4)).Yaw;
    // End:0x1C6
    if(GetUpFromBack)
    {
        NewRotation.Yaw += 32768;
    }
    SetRotation(NewRotation);
    // End:0x20A
    if(GetUpFromBack)
    {
        GetUpNode.SetAnim('feigndeath_getup_back');        
    }
    else
    {
        GetUpNode.SetAnim('feigndeath_getup_front');
    }
    GetUpNode.SetPosition(0.0000000, false);
    BlendNode.SetBlendTarget(1.0000000, 0.0000000);
    bBlendToGetUp = true;
    GetUpBlendStartTime = WorldInfo.TimeSeconds;
    //return;    
}

simulated function SetAllMotorsAngularDriveStrength(float InAngularSpringStrength, float InAngularDampingStrength, float InAngularForceLimitStrength, SkeletalMeshComponent SkelMeshComp)
{
    local float DefSpringScale, DefDampScale, DefForceScale;

    // End:0x11
    if(SkelMeshComp == none)
    {
        return;
    }
    DefSpringScale = SkelMeshComp.PhysicsAsset.DefaultInstance.AngularSpringScale;
    DefDampScale = SkelMeshComp.PhysicsAsset.DefaultInstance.AngularDampingScale;
    DefForceScale = SkelMeshComp.PhysicsAsset.DefaultInstance.AngularForceLimitScale;
    SkelMeshComp.PhysicsAssetInstance.SetAngularDriveScale(DefSpringScale * InAngularSpringStrength, DefDampScale * InAngularDampingStrength, DefForceScale * InAngularForceLimitStrength);
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local float MotorScale;
    local int HipIndex;
    local Matrix HipMatrix;

    super.Tick(DeltaSeconds);
    // End:0x3DF
    if(bRampingDownMotors)
    {
        // End:0x87
        if((MotorDownStartTime + MotorDownAnimTime) > WorldInfo.TimeSeconds)
        {
            SetLocation(Location + ((DeltaSeconds * StaggerVel) * MoveDir));            
        }
        else
        {
            // End:0x30F
            if((MotorDownStartTime + MotorDownTime) > WorldInfo.TimeSeconds)
            {
                // End:0x1FF
                if(int(CurrentState) != int(2))
                {
                    HipIndex = SkeletalMeshComponent.MatchRefBone('Hips');
                    HipMatrix = SkeletalMeshComponent.GetBoneMatrix(HipIndex);
                    SetPATAState(2);
                    SkeletalMeshComponent.bUpdateKinematicBonesFromAnimation = false;
                    HipBody.SetBoneSpringParams(50.0000000, 1.0000000, AngularHipDriveScale * 50.0000000, 0.1000000);
                    HipBody.EnableBoneSpring(true, true, HipMatrix);
                    SkeletalMeshComponent.SetRBLinearVelocity(MoveDir * StaggerVel, true);
                }
                MotorScale = 1.0000000 - (WorldInfo.TimeSeconds - ((MotorDownStartTime + MotorDownAnimTime) / (MotorDownTime - MotorDownAnimTime)));
                MotorScale = (MotorScale * MotorScale) * MotorScale;
                SetAllMotorsAngularDriveStrength(MotorScale * StaggerMuscleScale, MotorScale * StaggerMuscleScale, 1.0000000, SkeletalMeshComponent);
                HipBody.SetBoneSpringParams(50.0000000, 1.0000000, (MotorScale * AngularHipDriveScale) * 50.0000000, 0.1000000);                
            }
            else
            {
                bRampingDownMotors = false;
                SkeletalMeshComponent.bUpdateKinematicBonesFromAnimation = true;
                SetPATAState(3);
                HipBody.EnableBoneSpring(false, false, HipMatrix);
                GetUpNode.StopAnim();
                BlendNode.SetBlendTarget(0.0000000, 0.0000000);
                SetAllMotorsAngularDriveStrength(1.0000000, 1.0000000, 1.0000000, SkeletalMeshComponent);
            }
        }        
    }
    else
    {
        // End:0x4EE
        if(bBlendingBack)
        {
            // End:0x41B
            if(BlendBackStartTime > WorldInfo.TimeSeconds)
            {                
            }
            else
            {
                // End:0x4AF
                if((BlendBackStartTime + PokeBlendTime) > WorldInfo.TimeSeconds)
                {
                    SkeletalMeshComponent.PhysicsWeight = 1.0000000 - ((WorldInfo.TimeSeconds - BlendBackStartTime) / PokeBlendTime);                    
                }
                else
                {
                    bBlendingBack = false;
                    SetPATAState(0);
                    SkeletalMeshComponent.PhysicsWeight = 1.0000000;
                }
            }            
        }
        else
        {
            // End:0x60A
            if(bBlendToGetUp)
            {
                // End:0x58F
                if((GetUpBlendStartTime + GetUpBlendTime) > WorldInfo.TimeSeconds)
                {
                    SkeletalMeshComponent.PhysicsWeight = 1.0000000 - ((WorldInfo.TimeSeconds - GetUpBlendStartTime) / GetUpBlendTime);                    
                }
                else
                {
                    bBlendToGetUp = false;
                    SkeletalMeshComponent.bUpdateKinematicBonesFromAnimation = true;
                    SkeletalMeshComponent.PhysicsWeight = 1.0000000;
                    GetUpNode.PlayAnim(false, 1.0000000, 0.0000000);
                }
            }
        }
    }
    //return;    
}

event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
    // End:0xD6
    if(SeqNode.AnimSeqName != 'Stumble_Bwd')
    {
        SkeletalMeshComponent.bUpdateKinematicBonesFromAnimation = true;
        SkeletalMeshComponent.PhysicsWeight = 1.0000000;
        RunNode.bPlaying = true;
        BlendNode.SetBlendTarget(0.0000000, GetUpToIdleTime);
        SetBodiesFixed(true);
        CurrentState = 0;
    }
    //return;    
}

defaultproperties
{
    LowerBoneNames[0]="LeftUpperLeg"
    LowerBoneNames[1]="LeftLeg"
    LowerBoneNames[2]="LeftAnkle"
    LowerBoneNames[3]="RightUpperLeg"
    LowerBoneNames[4]="RightLeg"
    LowerBoneNames[5]="RightAnkle"
    LowerBoneNames[6]="Hips"
    LinearBoneSpringNames[0]="LeftHand"
    LinearBoneSpringNames[1]="RightHand"
    AngularBoneSpringNames[0]="Neck"
    // Reference: SkeletalMeshComponent'TgGame.Default__TgPhysAnimTestActor.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0" class=Engine.SkeletalMeshComponent
        PhysicsWeight=1.0000000
        bHasPhysicsAssetInstance=true
        bUpdateJointsFromAnimation=true
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=true
        BlockRigidBody=true
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    GetUpBlendTime=0.2000000
    GetUpToIdleTime=0.4000000
    ActorOriginHeight=50.0000000
    PokePauseTime=0.7000000
    PokeBlendTime=0.5000000
    MotorDownTime=1.4000000
    MotorDownAnimTime=0.4000000
    BlendStaggerAnimTime=0.1500000
    StaggerSpeedAdj=0.1000000
    StaggerVel=100.0000000
    AngularHipDriveScale=5.0000000
    StaggerMuscleScale=200.0000000
    Components[0]=SkeletalMeshComponent0
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bCollideActors=true
    bProjTarget=true
    CollisionComponent=SkeletalMeshComponent0
}