class TgSavedMove extends SavedMove;

const bJumpHeldBit = 16;
const bUltHeldBit = 4;

var bool m_bJumpHeld;
var bool m_bUltHeld;
var byte m_byMoveSpeed;

function Clear()
{
    super.Clear();
    m_bJumpHeld = false;
    m_bUltHeld = false;
    //return;    
}

function bool CanCombineWith(SavedMove NewMove, Pawn inPawn, float MaxDelta)
{
    local TgSavedMove TrSM;
    local bool bRetval;

    bRetval == super.CanCombineWith(NewMove, inPawn, MaxDelta);
    TrSM = TgSavedMove(NewMove);
    // End:0x67
    if(TrSM == none)
    {
        return bRetval;
    }
    return ((bRetval && m_bJumpHeld == TrSM.m_bJumpHeld) && m_bUltHeld == TrSM.m_bUltHeld) && int(m_byMoveSpeed) == int(TrSM.m_byMoveSpeed);
    //return ReturnValue;    
}

function SetMoveFor(PlayerController P, float DeltaTime, Vector newAccel, Actor.EDoubleClickDir InDoubleClick)
{
    local TgPlayerController TgPC;

    super.SetMoveFor(P, DeltaTime, newAccel, InDoubleClick);
    TgPC = TgPlayerController(P);
    // End:0x10E
    if(TgPC != none)
    {
        m_byMoveSpeed = TgPC.m_byDesiredMoveSpeedReduction;
        m_bJumpHeld = (int(TgPC.m_JumpHeld) > int(0)) || int(TgPC.m_JumpHeldAlt) > int(0);
        m_bUltHeld = int(TgPC.m_UltHeld) > int(0);
    }
    //return;    
}

function byte CompressedFlags()
{
    local byte Result;

    Result = DoubleClickMove;
    // End:0x2F
    if(m_bJumpHeld)
    {
        Result += byte(16);
    }
    // End:0x4B
    if(m_bUltHeld)
    {
        Result += byte(4);
    }
    // End:0x65
    if(bPressedJump)
    {
        Result += 32;
    }
    Result = byte(int(Result) | ((int(m_byMoveSpeed) & int(3)) << 6));
    return Result;
    //return ReturnValue;    
}

static function Actor.EDoubleClickDir SetFlags(byte Flags, PlayerController PC)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(PC);
    // End:0xD5
    if(TgPC != none)
    {
        TgPC.m_JumpHeld = (((int(Flags) & 16) != 0) ? 1 : 0);
        TgPC.m_UltHeld = (((int(Flags) & 4) != 0) ? 1 : 0);
        TgPC.m_byDesiredMoveSpeedReduction = byte((int(Flags) >> int(6)) & 3);
    }
    PC.bPressedJump = (int(Flags) & int(32)) != 0;
    switch(int(Flags) & int(7))
    {
        // End:0x12E
        case 0:
            return 0;
            // End:0x15C
            break;
        // End:0x138
        case 1:
            return 1;
            // End:0x15C
            break;
        // End:0x143
        case 2:
            return 2;
            // End:0x15C
            break;
        // End:0x14E
        case 3:
            return 3;
            // End:0x15C
            break;
        // End:0x159
        case 4:
            return 4;
            // End:0x15C
            break;
        // End:0xFFFF
        default:
            break;
    }
    return 0;
    //return ReturnValue;    
}
