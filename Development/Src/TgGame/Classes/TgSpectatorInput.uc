class TgSpectatorInput extends TgPlayerInput within TgPlayerController
    transient
    native(Pawns)
    config(Input)
    hidecategories(Object,UIRoot);

var config float SpectatorSensitivity;

native function CheckIdleBreak();  // Export UTgSpectatorInput::execCheckIdleBreak(FFrame&, void* const)

function AdjustMouseSensitivity(float FOVScale) { }

event PlayerInput(float DeltaTime) { }

defaultproperties
{
    SpectatorSensitivity=5.0000000
    c_bUseServerBindings=false
    m_nKeybindConfigSet=2
    Bindings=/* Array type was not detected. */
}
