class TgSavedMove extends SavedMove
    config(Engine);

const bJumpHeldBit = 16;

const bUltHeldBit = 4;

var bool m_bJumpHeld;
var bool m_bUltHeld;
var byte m_byMoveSpeed;

function Clear() { }

function bool CanCombineWith(SavedMove NewMove, Pawn inPawn, float MaxDelta) { }

function SetMoveFor(PlayerController P, float DeltaTime, vector NewAccel, EDoubleClickDir InDoubleClick) { }

function byte CompressedFlags() { }

static function EDoubleClickDir SetFlags(byte Flags, PlayerController PC) { }
