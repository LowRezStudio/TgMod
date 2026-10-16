class GamePadLightbarSubsystem extends Object
    native
    config(LightBar);

enum LightBarState
{
    ELBS_Standby,                   // 0
    ELBS_Lerping,                   // 1
    ELBS_Pulsing,                   // 2
    ELBS_MAX                        // 3
};

struct native ColorDefinition
{
    var init string Id;
    var byte R;
    var byte G;
    var byte B;

    structdefaultproperties
    {
        Id=""
        R=0
        G=0
        B=0
    }
};

struct native LerpToInstruction
{
    var init string Id;
    var float Time;
    var init string LerpToId;

    structdefaultproperties
    {
        Id=""
        Time=0.0000000
        LerpToId=""
    }
};

struct native SetAndLerpInstruction extends LerpToInstruction
{
    var init string LerpFromId;
};

struct native PulseInstruction extends SetAndLerpInstruction
{
};

var GamePadLightbarSubsystem.LightBarState CurrentLightBarState;
var LinearColor CurrentColor;
var LinearColor OriginalColor;
var LinearColor TargetColor;
var float LerpTimeRemaining;
var float TotalLerpTime;
var() const config Color DefaultColor;
var() const editinline config array<editinline config ColorDefinition> ColorDefinitions;
var() const editinline config array<editinline config LerpToInstruction> LerpToInstructions;
var() const editinline config array<editinline config SetAndLerpInstruction> SetAndLerpInstructions;
var const editinline config array<editinline config PulseInstruction> PulseInstructions;

// Export UGamePadLightbarSubsystem::execSetPadColor(FFrame&, void* const)
native static function SetPadColor(Color NewPadColor);

// Export UGamePadLightbarSubsystem::execSetPadColorFromDef(FFrame&, void* const)
native static function SetPadColorFromDef(string TheColorId);

// Export UGamePadLightbarSubsystem::execBeginLerp(FFrame&, void* const)
native static function BeginLerp(Color NewLerpColor, float LerpTime);

// Export UGamePadLightbarSubsystem::execBeginLerpFromDef(FFrame&, void* const)
native static function BeginLerpFromDef(string InstructionId);

// Export UGamePadLightbarSubsystem::execSetPadColorAndLerp(FFrame&, void* const)
native static function SetPadColorAndLerp(float LerpTime, Color NewPadColor, optional Color NewTargetColor = default.DefaultColor);

// Export UGamePadLightbarSubsystem::execSetPadColorAndLerpFromDef(FFrame&, void* const)
native static function SetPadColorAndLerpFromDef(string InstructionId);

// Export UGamePadLightbarSubsystem::execSetPulsing(FFrame&, void* const)
native static function SetPulsing(float LerpTime, Color Target1, optional Color Target2 = default.DefaultColor);

// Export UGamePadLightbarSubsystem::execSetPulsingFromDef(FFrame&, void* const)
native static function SetPulsingFromDef(string InstructionId);

// Export UGamePadLightbarSubsystem::execResetState(FFrame&, void* const)
native static function ResetState();

defaultproperties
{
    CurrentColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    OriginalColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    TargetColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
}