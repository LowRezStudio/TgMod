class GamePadLightbarSubsystem extends Object
    native
    config(LightBar);

enum LightBarState {
    ELBS_Standby,  // 0
    ELBS_Lerping,  // 1
    ELBS_Pulsing,  // 2
};

struct ColorDefinition {
    var init string Id;
    var byte R;
    var byte G;
    var byte B;
    structdefaultproperties {}
};

struct LerpToInstruction {
    var init string Id;
    var float Time;
    var init string LerpToId;
    structdefaultproperties {}
};

struct SetAndLerpInstruction extends LerpToInstruction {
    var init string LerpFromId;
};

struct PulseInstruction extends SetAndLerpInstruction {
};

var GamePadLightbarSubsystem.LightBarState CurrentLightBarState;
var LinearColor CurrentColor;
var LinearColor OriginalColor;
var LinearColor TargetColor;
var float LerpTimeRemaining;
var float TotalLerpTime;
var () const config Color DefaultColor;
var () const editinline config array<config ColorDefinition> ColorDefinitions;
var () const editinline config array<config LerpToInstruction> LerpToInstructions;
var () const editinline config array<config SetAndLerpInstruction> SetAndLerpInstructions;
var const editinline config array<config PulseInstruction> PulseInstructions;

native function SetPadColor(Color NewPadColor);  // Export UGamePadLightbarSubsystem::execSetPadColor(FFrame&, void* const)

native function SetPadColorFromDef(string TheColorId);  // Export UGamePadLightbarSubsystem::execSetPadColorFromDef(FFrame&, void* const)

native function BeginLerp(Color NewLerpColor, float LerpTime);  // Export UGamePadLightbarSubsystem::execBeginLerp(FFrame&, void* const)

native function BeginLerpFromDef(string InstructionId);  // Export UGamePadLightbarSubsystem::execBeginLerpFromDef(FFrame&, void* const)

native function SetPadColorAndLerp(float LerpTime, Color NewPadColor, optional Color NewTargetColor=default.DefaultColor);  // Export UGamePadLightbarSubsystem::execSetPadColorAndLerp(FFrame&, void* const)

native function SetPadColorAndLerpFromDef(string InstructionId);  // Export UGamePadLightbarSubsystem::execSetPadColorAndLerpFromDef(FFrame&, void* const)

native function SetPulsing(float LerpTime, Color Target1, optional Color Target2=default.DefaultColor);  // Export UGamePadLightbarSubsystem::execSetPulsing(FFrame&, void* const)

native function SetPulsingFromDef(string InstructionId);  // Export UGamePadLightbarSubsystem::execSetPulsingFromDef(FFrame&, void* const)

native function ResetState();  // Export UGamePadLightbarSubsystem::execResetState(FFrame&, void* const)

defaultproperties
{
    CurrentColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    OriginalColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    TargetColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
}
