class SeqAct_CameraShake extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() protectedwrite export editinline CameraShake Shake;
var() protectedwrite float ShakeScale;
var() protectedwrite bool bDoControllerVibration;
var() protectedwrite bool bRadialShake;
var() protectedwrite bool bOrientTowardRadialEpicenter;
var() protectedwrite float RadialShake_InnerRadius;
var() protectedwrite float RadialShake_OuterRadius;
var() protectedwrite float RadialShake_Falloff;
var() protectedwrite Camera.ECameraAnimPlaySpace PlaySpace;
var Actor LocationActor;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: CameraShake'Engine.Default__SeqAct_CameraShake.Shake0'
    begin object name="Shake0" class=Engine.CameraShake
        OscillationDuration=1.0000000
        RotOscillation=(Pitch=(Amplitude=150.0000000,Frequency=40.0000000),Yaw=(Amplitude=75.0000000,Frequency=30.0000000),Roll=(Amplitude=150.0000000,Frequency=60.0000000))
    end object
    Shake=Shake0
    ShakeScale=1.0000000
    bDoControllerVibration=true
    RadialShake_InnerRadius=128.0000000
    RadialShake_OuterRadius=512.0000000
    RadialShake_Falloff=2.0000000
    InputLinks[0]=(LinkDesc="Start",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Location",LinkVar="None",PropertyName="LocationActor",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Camera Shake"
}