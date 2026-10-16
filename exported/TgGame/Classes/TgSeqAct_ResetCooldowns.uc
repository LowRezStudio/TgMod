class TgSeqAct_ResetCooldowns extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

function Activated()
{
    local int X;
    local TgDevice Device;
    local TgPawn Pawn;
    local TgPlayerController TgPC;

    // End:0xFF
    foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        Pawn = TgPawn(TgPC.Pawn);
        // End:0xFE
        if(Pawn != none)
        {
            X = 0;
            J0x80:

            // End:0xFE [Loop If]
            if(X < 33)
            {
                Device = Pawn.GetDeviceByEqPoint(X);
                // End:0xF0
                if(Device != none)
                {
                    Device.EndCooldown();
                }
                X++;
                // [Loop Continue]
                goto J0x80;
            }
        }        
    }    
    //return;    
}

defaultproperties
{
    ObjName="Reset Cooldowns"
}