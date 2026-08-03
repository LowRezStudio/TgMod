class CameraModifier extends Object
    native(Camera);

var protected bool bDisabled;
var bool bPendingDisable;
var protected bool bExclusive;
var(Debug) bool bDebug;
var Camera CameraOwner;
var protected byte Priority;
var protected float AlphaInTime;
var protected float AlphaOutTime;
var protected transient float Alpha;
var protected transient float TargetAlpha;

function Init()
{
    //return;    
}

// Export UCameraModifier::execModifyCamera(FFrame&, void* const)
native function bool ModifyCamera(Camera Camera, float DeltaTime, out TPOV OutPOV);

// Export UCameraModifier::execIsDisabled(FFrame&, void* const)
native function bool IsDisabled();

function bool AddCameraModifier(Camera Camera)
{
    local int BestIdx, ModifierIdx;
    local CameraModifier Modifier;

    ModifierIdx = 0;
    J0x0B:

    // End:0x76 [Loop If]
    if(ModifierIdx < Camera.ModifierList.Length)
    {
        // End:0x68
        if(Camera.ModifierList[ModifierIdx] == self)
        {
            return false;
        }
        ModifierIdx++;
        // [Loop Continue]
        goto J0x0B;
    }
    ModifierIdx = 0;
    J0x81:

    // End:0x146 [Loop If]
    if(ModifierIdx < Camera.ModifierList.Length)
    {
        // End:0x138
        if(Camera.ModifierList[ModifierIdx].Class == Class)
        {
            Camera.ModifierList[ModifierIdx] = self;
            CameraOwner = Camera;
            return true;
        }
        ModifierIdx++;
        // [Loop Continue]
        goto J0x81;
    }
    BestIdx = 0;
    ModifierIdx = 0;
    J0x15C:

    // End:0x25A [Loop If]
    if(ModifierIdx < Camera.ModifierList.Length)
    {
        Modifier = Camera.ModifierList[ModifierIdx];
        // End:0x1CD
        if(Modifier == none)
        {            
        }
        else
        {
            // End:0x241
            if(int(Priority) <= int(Modifier.Priority))
            {
                // End:0x23E
                if(bExclusive && int(Priority) == int(Modifier.Priority))
                {
                    return false;
                }
                // [Explicit Break]
                goto J0x25A;
            }
            BestIdx++;
        }
        ModifierIdx++;
        // [Loop Continue]
        goto J0x15C;
    }
    J0x25A:

    Camera.ModifierList.Insert(BestIdx, 1);
    Camera.ModifierList[BestIdx] = self;
    CameraOwner = Camera;
    return true;
    //return ReturnValue;    
}

function bool RemoveCameraModifier(Camera Camera)
{
    local int ModifierIdx;

    ModifierIdx = 0;
    J0x0B:

    // End:0xA0 [Loop If]
    if(ModifierIdx < Camera.ModifierList.Length)
    {
        // End:0x92
        if(Camera.ModifierList[ModifierIdx] == self)
        {
            Camera.ModifierList.Remove(ModifierIdx, 1);
            return true;
        }
        ModifierIdx++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

event DisableModifier(optional bool bImmediate)
{
    // End:0x29
    if(bImmediate)
    {
        bDisabled = true;
        bPendingDisable = false;        
    }
    else
    {
        // End:0x44
        if(!bDisabled)
        {
            bPendingDisable = true;
        }
    }
    //return;    
}

function EnableModifier()
{
    bDisabled = false;
    bPendingDisable = false;
    //return;    
}

function ToggleModifier()
{
    // End:0x1A
    if(bDisabled)
    {
        EnableModifier();        
    }
    else
    {
        DisableModifier();
    }
    //return;    
}

simulated function bool ProcessViewRotation(Actor ViewTarget, float DeltaTime, out Rotator out_ViewRotation, out Rotator out_DeltaRot)
{
    //return ReturnValue;    
}

// Export UCameraModifier::execUpdateAlpha(FFrame&, void* const)
native function UpdateAlpha(Camera Camera, float DeltaTime);

defaultproperties
{
    Priority=127
}