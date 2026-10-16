class SVehicle extends Vehicle
    abstract
    native(Physics)
    nativereplication
    config(Game)
    placeable
    hidecategories(Navigation);

struct native VehicleState
{
    var RigidBodyState RBState;
    var byte ServerBrake;
    var byte ServerGas;
    var byte ServerSteering;
    var byte ServerRise;
    var bool bServerHandbrake;
    var int ServerView;

    structdefaultproperties
    {
        RBState=(Position=(X=0.0000000,Y=0.0000000,Z=0.0000000),Quaternion=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=0.0000000),LinVel=(X=0.0000000,Y=0.0000000,Z=0.0000000),AngVel=(X=0.0000000,Y=0.0000000,Z=0.0000000),bNewData=0)
        ServerBrake=0
        ServerGas=0
        ServerSteering=0
        ServerRise=0
        bServerHandbrake=false
        ServerView=0
    }
};

var() noclear const export editinline SVehicleSimBase SimObj;
var() export editinline array<export editinline SVehicleWheel> Wheels;
var() Vector COMOffset;
var() Vector InertiaTensorMultiplier;
var(UprightConstraint) bool bStayUpright;
var bool bUseSuspensionAxis;
var bool bUpdateWheelShapes;
var const bool bVehicleOnGround;
var const bool bVehicleOnWater;
var const bool bIsInverted;
var const bool bChassisTouchingGround;
var const bool bWasChassisTouchingGroundLastTick;
var bool bCanFlip;
var bool bFlipRight;
var bool bIsUprighting;
var bool bOutputHandbrake;
var bool bHoldingDownHandbrake;
var(UprightConstraint) float StayUprightRollResistAngle;
var(UprightConstraint) float StayUprightPitchResistAngle;
var(UprightConstraint) float StayUprightStiffness;
var(UprightConstraint) float StayUprightDamping;
var export editinline RB_StayUprightSetup StayUprightConstraintSetup;
var export editinline RB_ConstraintInstance StayUprightConstraintInstance;
var float HeavySuspensionShiftPercent;
var() float MaxSpeed;
var() float MaxAngularVelocity;
var const float TimeOffGround;
var(Uprighting) float UprightLiftStrength;
var(Uprighting) float UprightTorqueStrength;
var(Uprighting) float UprightTime;
var float UprightStartTime;
var(Sounds) const editconst export editinline AudioComponent EngineSound;
var(Sounds) const editconst export editinline AudioComponent SquealSound;
var(Sounds) SoundCue CollisionSound;
var(Sounds) SoundCue EnterVehicleSound;
var(Sounds) SoundCue ExitVehicleSound;
var(Sounds) float CollisionIntervalSecs;
var(Sounds) const float SquealThreshold;
var(Sounds) const float SquealLatThreshold;
var(Sounds) const float LatAngleVolumeMult;
var(Sounds) const float EngineStartOffsetSecs;
var(Sounds) const float EngineStopOffsetSecs;
var float LastCollisionSoundTime;
var float OutputBrake;
var float OutputGas;
var float OutputSteering;
var float OutputRise;
var float ForwardVel;
var int NumPoweredWheels;
var() Vector BaseOffset;
var() float CamDist;
var int DriverViewPitch;
var int DriverViewYaw;
var native const VehicleState VState;
var native const float AngErrorAccumulator;
var float RadialImpulseScaling;

replication
{
    // Pos:0x000
    if(int(Physics) == int(10))
        MaxSpeed, VState;
}

// Export USVehicle::execAddForce(FFrame&, void* const)
native function AddForce(Vector Force);

// Export USVehicle::execAddImpulse(FFrame&, void* const)
native function AddImpulse(Vector Impulse);

// Export USVehicle::execAddTorque(FFrame&, void* const)
native function AddTorque(Vector Torque);

// Export USVehicle::execIsSleeping(FFrame&, void* const)
native function bool IsSleeping();

// Export USVehicle::execSetWheelCollision(FFrame&, void* const)
native final function SetWheelCollision(int WheelNum, bool bCollision);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x3A
    if(EngineSound != none)
    {
        EngineSound.bShouldRemainActiveIfDropped = true;
    }
    // End:0xA7
    if((CollisionSound != none) && CollisionIntervalSecs <= 0.0000000)
    {
        CollisionIntervalSecs = CollisionSound.GetCueDuration() / WorldInfo.TimeDilation;
    }
    //return;    
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    local int WheelIndex;
    local editinline SVehicleWheel Wheel;

    super(Pawn).PostInitAnimTree(SkelComp);
    // End:0xDD
    if(SkelComp == Mesh)
    {
        WheelIndex = 0;
        J0x35:

        // End:0xDD [Loop If]
        if(WheelIndex < Wheels.Length)
        {
            Wheel = Wheels[WheelIndex];
            Wheel.WheelControl = SkelControlWheel(Mesh.FindSkelControl(Wheel.SkelControlName));
            WheelIndex++;
            // [Loop Continue]
            goto J0x35;
        }
    }
    //return;    
}

simulated event Destroyed()
{
    super.Destroyed();
    StopVehicleSounds();
    //return;    
}

simulated function TurnOff()
{
    super(Pawn).TurnOff();
    StopVehicleSounds();
    //return;    
}

simulated function StopVehicleSounds()
{
    // End:0x2F
    if(EngineSound != none)
    {
        EngineSound.Stop();
    }
    // End:0x5E
    if(SquealSound != none)
    {
        SquealSound.Stop();
    }
    //return;    
}

simulated function TakeRadiusDamage(Controller InstigatedBy, float BaseDamage, float DamageRadius, Class<DamageType> DamageType, float Momentum, Vector HurtOrigin, bool bFullDamage, Actor DamageCauser, optional float DamageFalloffExponent = 1.0000000)
{
    local Vector HitLocation, Dir, NewDir;
    local float Dist, DamageScale;
    local TraceHitInfo HitInfo;

    // End:0x1F
    if(int(Role) < int(ROLE_Authority))
    {
        return;
    }
    HitLocation = Location;
    Dir = Location - HurtOrigin;
    CheckHitInfo(HitInfo, Mesh, Dir, HitLocation);
    NewDir = HitLocation - HurtOrigin;
    Dist = VSize(NewDir);
    // End:0xD0
    if(bFullDamage)
    {
        DamageScale = 1.0000000;        
    }
    else
    {
        // End:0xEC
        if(Dist > DamageRadius)
        {
            return;            
        }
        else
        {
            DamageScale = FMax(0.0000000, 1.0000000 - (Dist / DamageRadius));
            DamageScale = DamageScale ** DamageFalloffExponent;
        }
    }
    RadialImpulseScaling = DamageScale;
    TakeDamage(int(BaseDamage * DamageScale), InstigatedBy, HitLocation, (DamageScale * Momentum) * Normal(Dir), DamageType, HitInfo, DamageCauser);
    RadialImpulseScaling = 1.0000000;
    // End:0x21F
    if(Health > 0)
    {
        DriverRadiusDamage(BaseDamage, DamageRadius, InstigatedBy, DamageType, Momentum, HurtOrigin, DamageCauser);
    }
    //return;    
}

// Export USVehicle::execInitVehicleRagdoll(FFrame&, void* const)
native function InitVehicleRagdoll(SkeletalMesh RagdollMesh, PhysicsAsset RagdollPhysAsset, Vector ActorMove, bool bClearAnimTree);

event AddVelocity(Vector NewVelocity, Vector HitLocation, Class<DamageType> DamageType, optional TraceHitInfo HitInfo)
{
    // End:0x16E
    if(!IsZero(NewVelocity))
    {
        NewVelocity = (((RadialImpulseScaling * MomentumMult) * DamageType.default.VehicleMomentumScaling) * DamageType.default.KDamageImpulse) * Normal(NewVelocity);
        // End:0x16E
        if(!bIgnoreForces && !IsZero(NewVelocity))
        {
            // End:0x11E
            if(Location.Z > WorldInfo.StallZ)
            {
                NewVelocity.Z = FMin(NewVelocity.Z, 0.0000000);
            }
            // End:0x13B
            if(InGodMode())
            {
                NewVelocity *= 0.2500000;
            }
            Mesh.AddImpulse(NewVelocity, HitLocation);
        }
    }
    RadialImpulseScaling = 1.0000000;
    //return;    
}

function bool Died(Controller Killer, Class<DamageType> DamageType, Vector HitLocation)
{
    // End:0x5C
    if(super.Died(Killer, DamageType, HitLocation))
    {
        bDriving = false;
        AddVelocity(TearOffMomentum, HitLocation, DamageType);
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool CalcCamera(float fDeltaTime, out Vector out_CamLoc, out Rotator out_CamRot, out float out_FOV)
{
    local Vector pos, HitLocation, HitNormal;

    GetActorEyesViewPoint(out_CamLoc, out_CamRot);
    out_CamLoc += BaseOffset;
    pos = out_CamLoc - (Vector(out_CamRot) * CamDist);
    // End:0xBF
    if(Trace(HitLocation, HitNormal, pos, out_CamLoc, false, vect(0.0000000, 0.0000000, 0.0000000)) != none)
    {
        out_CamLoc = HitLocation + (HitNormal * float(2));        
    }
    else
    {
        out_CamLoc = pos;
    }
    return true;
    //return ReturnValue;    
}

simulated function name GetDefaultCameraMode(PlayerController RequestedBy)
{
    return 'Default';
    //return ReturnValue;    
}

function bool TryToDrive(Pawn P)
{
    // End:0x78
    if((bIsInverted && !bVehicleOnGround) && VSize(Velocity) <= 0.1000000)
    {
        // End:0x76
        if(bCanFlip)
        {
            bIsUprighting = true;
            UprightStartTime = WorldInfo.TimeSeconds;
        }
        return false;
    }
    return super.TryToDrive(P);
    //return ReturnValue;    
}

// Export USVehicle::execHasWheelsOnGround(FFrame&, void* const)
native simulated function bool HasWheelsOnGround();

simulated function StartEngineSound()
{
    // End:0x2E
    if(EngineSound != none)
    {
        EngineSound.Play();
    }
    ClearTimer('StartEngineSound');
    ClearTimer('StopEngineSound');
    //return;    
}

simulated function StartEngineSoundTimed()
{
    // End:0x41
    if(EngineStartOffsetSecs > 0.0000000)
    {
        ClearTimer('StopEngineSound');
        SetTimer(EngineStartOffsetSecs, false, 'StartEngineSound');        
    }
    else
    {
        StartEngineSound();
    }
    //return;    
}

simulated function StopEngineSound()
{
    // End:0x2F
    if(EngineSound != none)
    {
        EngineSound.Stop();
    }
    ClearTimer('StartEngineSound');
    ClearTimer('StopEngineSound');
    //return;    
}

simulated function StopEngineSoundTimed()
{
    // End:0x41
    if(EngineStopOffsetSecs > 0.0000000)
    {
        ClearTimer('StartEngineSound');
        SetTimer(EngineStopOffsetSecs, false, 'StopEngineSound');        
    }
    else
    {
        StopEngineSound();
    }
    //return;    
}

simulated function VehiclePlayEnterSound()
{
    // End:0x27
    if(EnterVehicleSound != none)
    {
        PlaySound(EnterVehicleSound);
    }
    StartEngineSoundTimed();
    //return;    
}

simulated function VehiclePlayExitSound()
{
    // End:0x27
    if(ExitVehicleSound != none)
    {
        PlaySound(ExitVehicleSound);
    }
    StopEngineSoundTimed();
    //return;    
}

simulated function DrivingStatusChanged()
{
    bUpdateWheelShapes = true;
    // End:0x26
    if(bDriving)
    {
        VehiclePlayEnterSound();        
    }
    else
    {
        // End:0x3F
        if(Health > 0)
        {
            VehiclePlayExitSound();
        }
    }
    //return;    
}

simulated event RigidBodyCollision(PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent, const out CollisionImpactData RigidCollisionData, int ContactIndex)
{
    // End:0x88
    if((CollisionSound != none) && (WorldInfo.TimeSeconds - LastCollisionSoundTime) > CollisionIntervalSecs)
    {
        PlaySound(CollisionSound, true);
        LastCollisionSoundTime = WorldInfo.TimeSeconds;
    }
    //return;    
}

simulated event SuspensionHeavyShift(float Delta)
{
    //return;    
}

function PostTeleport(Teleporter OutTeleporter)
{
    Mesh.SetRBPosition(Location);
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local array<string> DebugInfo;
    local int I;

    super.DisplayDebug(HUD, out_YL, out_YPos);
    GetSVehicleDebug(DebugInfo);
    HUD.Canvas.SetDrawColor(0, 255, 0);
    I = 0;
    J0x7E:

    // End:0x14D [Loop If]
    if(I < DebugInfo.Length)
    {
        HUD.Canvas.DrawText("  " @ DebugInfo[I]);
        out_YPos += out_YL;
        HUD.Canvas.SetPos(4.0000000, out_YPos);
        I++;
        // [Loop Continue]
        goto J0x7E;
    }
    DisplayWheelsDebug(HUD, out_YL);
    //return;    
}

simulated function DisplayWheelsDebug(HUD HUD, float YL)
{
    local int I, J;
    local Vector WorldLoc, ScreenLoc, X, Y, Z, EndPoint,
	    ScreenEndPoint;

    local Color SaveColor;
    local float LastForceValue, GraphScale, ForceValue;
    local Vector ForceValueLoc;

    // End:0x11
    if(SimObj == none)
    {
        return;
    }
    GraphScale = 100.0000000;
    SaveColor = HUD.Canvas.DrawColor;
    I = 0;
    J0x68:

    // End:0x15E6 [Loop If]
    if(I < Wheels.Length)
    {
        GetAxes(Rotation, X, Y, Z);
        WorldLoc = Location + (Wheels[I].WheelPosition >> Rotation);
        ScreenLoc = HUD.Canvas.Project(WorldLoc);
        // End:0x15D8
        if((((ScreenLoc.X >= float(0)) && ScreenLoc.X < HUD.Canvas.ClipX) && ScreenLoc.Y >= float(0)) && ScreenLoc.Y < HUD.Canvas.ClipY)
        {
            HUD.Canvas.DrawColor = MakeColor(255, 255, 0, 255);
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y);
            HUD.Canvas.DrawText("Force " $ string(Wheels[I].ContactForce));
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y - (float(1) * YL));
            HUD.Canvas.DrawText("SR " $ string(Wheels[I].LongSlipRatio));
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y - (float(2) * YL));
            HUD.Canvas.DrawText(((("SA " $ string(Wheels[I].LatSlipAngle * 57.2957800)) $ " (") $ string(Wheels[I].LatSlipAngle)) $ ")");
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y - (float(3) * YL));
            HUD.Canvas.DrawText("Torque " $ string(Wheels[I].MotorTorque));
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y - (float(4) * YL));
            HUD.Canvas.DrawText("SpinVel " $ string(Wheels[I].SpinVel));
            HUD.Canvas.DrawColor = HUD.RedColor;
            EndPoint = (WorldLoc + ((Wheels[I].LongImpulse * float(100)) * Wheels[I].LongDirection)) - (Wheels[I].WheelRadius * Z);
            ScreenEndPoint = HUD.Canvas.Project(EndPoint);
            DrawDebugLine(WorldLoc - (Wheels[I].WheelRadius * Z), EndPoint, 255, 0, 0);
            HUD.Canvas.SetPos(ScreenEndPoint.X, ScreenEndPoint.Y);
            HUD.Canvas.DrawText(string(Wheels[I].LongImpulse));
            HUD.Canvas.DrawColor = HUD.GreenColor;
            EndPoint = (WorldLoc + ((Wheels[I].LatImpulse * float(100)) * Wheels[I].LatDirection)) - (Wheels[I].WheelRadius * Z);
            ScreenEndPoint = HUD.Canvas.Project(EndPoint);
            DrawDebugLine(WorldLoc - (Wheels[I].WheelRadius * Z), EndPoint, 0, 255, 0);
            HUD.Canvas.SetPos(ScreenEndPoint.X, ScreenEndPoint.Y);
            HUD.Canvas.DrawText(string(Wheels[I].LatImpulse));
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y + YL);
            HUD.Canvas.DrawText(string(Wheels[I].LatImpulse));
            HUD.Canvas.DrawColor = MakeColor(255, 255, 255, 255);
            HUD.Draw2DLine(int(ScreenLoc.X), int(ScreenLoc.Y), int(ScreenLoc.X + GraphScale), int(ScreenLoc.Y), MakeColor(0, 0, 255, 255));
            HUD.Canvas.SetPos(ScreenLoc.X + GraphScale, ScreenLoc.Y);
            HUD.Canvas.DrawText(string(3.1415930 * 0.5000000));
            HUD.Draw2DLine(int(ScreenLoc.X), int(ScreenLoc.Y), int(ScreenLoc.X), int(ScreenLoc.Y - GraphScale), MakeColor(0, 0, 255, 255));
            HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y - GraphScale);
            HUD.Canvas.DrawText(string(SimObj.WheelLatExtremumValue));
            LastForceValue = 0.0000000;
            J = 0;
            J0x102B:

            // End:0x11B7 [Loop If]
            if(float(J) <= GraphScale)
            {
                ForceValue = HermiteEval(float(J) * ((3.1415930 * 0.5000000) / GraphScale));
                ForceValue = (ForceValue / SimObj.WheelLatExtremumValue) * GraphScale;
                HUD.Draw2DLine(int(ScreenLoc.X + float(J - 1)), int(ScreenLoc.Y - LastForceValue), int(ScreenLoc.X + float(J)), int(ScreenLoc.Y - ForceValue), MakeColor(0, 255, 0, 255));
                LastForceValue = ForceValue;
                J++;
                // [Loop Continue]
                goto J0x102B;
            }
            ForceValue = HermiteEval(Abs(Wheels[I].LatSlipAngle));
            ForceValueLoc.X = ScreenLoc.X + ((Abs(Wheels[I].LatSlipAngle) / (3.1415930 * 0.5000000)) * GraphScale);
            ForceValueLoc.Y = ScreenLoc.Y - ((ForceValue / SimObj.WheelLatExtremumValue) * GraphScale);
            HUD.Draw2DLine(int(ForceValueLoc.X - float(5)), int(ForceValueLoc.Y), int(ForceValueLoc.X + float(5)), int(ForceValueLoc.Y), MakeColor(255, 0, 0, 255));
            HUD.Draw2DLine(int(ForceValueLoc.X), int(ForceValueLoc.Y - float(5)), int(ForceValueLoc.X), int(ForceValueLoc.Y + float(5)), MakeColor(255, 0, 0, 255));
            HUD.Canvas.SetPos(ScreenLoc.X, ForceValueLoc.Y);
            HUD.Canvas.DrawText(string(ForceValue));
            HUD.Canvas.SetPos(ForceValueLoc.X, ScreenLoc.Y + YL);
            HUD.Canvas.DrawText(string(Wheels[I].LatSlipAngle));
        }
        I++;
        // [Loop Continue]
        goto J0x68;
    }
    HUD.Canvas.DrawColor = SaveColor;
    //return;    
}

simulated function float HermiteEval(float Slip)
{
    local float LatExtremumSlip, LatExtremumValue, LatAsymptoteSlip, LatAsymptoteValue, SlipSquared, SlipCubed,
	    C0, C1, C3;

    LatExtremumSlip = SimObj.WheelLatExtremumSlip;
    LatExtremumValue = SimObj.WheelLatExtremumValue;
    LatAsymptoteSlip = SimObj.WheelLatAsymptoteSlip;
    LatAsymptoteValue = SimObj.WheelLatAsymptoteValue;
    // End:0x186
    if(Slip < LatExtremumSlip)
    {
        Slip /= LatExtremumSlip;
        SlipSquared = Slip * Slip;
        SlipCubed = SlipSquared * Slip;
        C3 = (-2.0000000 * SlipCubed) + (3.0000000 * SlipSquared);
        C1 = (SlipCubed - (2.0000000 * SlipSquared)) + Slip;
        return (C1 + C3) * LatExtremumValue;        
    }
    else
    {
        // End:0x1AA
        if(Slip > LatAsymptoteSlip)
        {
            return LatAsymptoteValue;            
        }
        else
        {
            Slip /= (LatAsymptoteSlip - LatExtremumSlip);
            Slip -= LatExtremumSlip;
            SlipSquared = Slip * Slip;
            SlipCubed = SlipSquared * Slip;
            C3 = (-2.0000000 * SlipCubed) + (3.0000000 * SlipSquared);
            C0 = ((2.0000000 * SlipCubed) - (3.0000000 * SlipSquared)) + 1.0000000;
            return (C0 * LatExtremumValue) + (C3 * LatAsymptoteValue);
        }
    }
    //return ReturnValue;    
}

simulated function GetSVehicleDebug(out array<string> DebugInfo)
{
    DebugInfo[DebugInfo.Length] = "----Vehicle----: ";
    DebugInfo[DebugInfo.Length] = ((("Speed: " $ string(VSize(Velocity))) $ " Unreal -- ") $ string(VSize(Velocity) * 0.0426125)) $ " MPH";
    // End:0xDA
    if(Wheels.Length > 0)
    {
        DebugInfo[DebugInfo.Length] = "MotorTorque: " $ string(Wheels[0].MotorTorque);
    }
    DebugInfo[DebugInfo.Length] = "Throttle: " $ string(OutputGas);
    DebugInfo[DebugInfo.Length] = "Brake: " $ string(OutputBrake);
    //return;    
}

defaultproperties
{
    InertiaTensorMultiplier=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    bCanFlip=true
    // Reference: RB_StayUprightSetup'Engine.Default__SVehicle.MyStayUprightSetup'
    begin object name="MyStayUprightSetup" class=Engine.RB_StayUprightSetup
    end object
    StayUprightConstraintSetup=MyStayUprightSetup
    // Reference: RB_ConstraintInstance'Engine.Default__SVehicle.MyStayUprightConstraintInstance'
    begin object name="MyStayUprightConstraintInstance" class=Engine.RB_ConstraintInstance
    end object
    StayUprightConstraintInstance=MyStayUprightConstraintInstance
    HeavySuspensionShiftPercent=0.5000000
    MaxSpeed=2500.0000000
    MaxAngularVelocity=75000.0000000
    UprightLiftStrength=225.0000000
    UprightTorqueStrength=50.0000000
    UprightTime=1.5000000
    SquealThreshold=250.0000000
    SquealLatThreshold=250.0000000
    LatAngleVolumeMult=1.0000000
    EngineStartOffsetSecs=2.0000000
    EngineStopOffsetSecs=1.0000000
    BaseOffset=(X=0.0000000,Y=0.0000000,Z=128.0000000)
    CamDist=512.0000000
    RadialImpulseScaling=1.0000000
    // Reference: SkeletalMeshComponent'Engine.Default__SVehicle.SVehicleMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SVehicleMesh'
    begin object name="SVehicleMesh" class=Engine.SkeletalMeshComponent
        bUseSingleBodyPhysics=1
        bForceDiscardRootMotion=true
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_Vehicle
        CollideActors=true
        BlockActors=true
        BlockZeroExtent=true
        BlockNonZeroExtent=true
        BlockRigidBody=true
        bNotifyRigidBodyCollision=true
        RBCollideWithChannels=(Default=true,Vehicle=true,GameplayPhysics=true,EffectPhysics=true,BlockingVolume=true)
        ScriptRigidBodyCollisionThreshold=250.0000000
    end object
    Mesh=SVehicleMesh
    // Reference: CylinderComponent'Engine.Default__SVehicle.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Vehicle.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=SVehicleMesh
    Physics=EPhysics.PHYS_RigidBody
    TickGroup=ETickingGroup.TG_PostAsyncWork
    bNetInitialRotation=true
    bBlocksTeleport=true
    bEdShouldSnap=true
    CollisionComponent=SVehicleMesh
}