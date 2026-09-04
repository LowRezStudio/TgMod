class TgSeqAct_SetInputEnabled extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

var() bool bEnableMoveForward;
var() bool bEnableMoveBackward;
var() bool bEnableMoveLeft;
var() bool bEnableMoveRight;
var() bool bEnableLookUp;
var() bool bEnableLookDown;
var() bool bEnableLookLeft;
var() bool bEnableLookRight;
var() bool bEnableJumping;
var() bool bEnableMounting;
var() bool bEnableAuto;
var() bool bEnableAlt;
var() bool bEnableBattleAbility;
var() bool bEnableMovementAbility;
var() bool bEnableUltimate;
var() bool bEnableEmote;

function Activated()
{
    local TgPlayerController TgPC;

    // End:0x2E6
    foreach GetWorldInfo().AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.SetInputAllowed(0, bEnableMoveForward);
        TgPC.SetInputAllowed(1, bEnableMoveBackward);
        TgPC.SetInputAllowed(3, bEnableMoveLeft);
        TgPC.SetInputAllowed(2, bEnableMoveRight);
        TgPC.SetInputAllowed(4, bEnableLookLeft);
        TgPC.SetInputAllowed(5, bEnableLookRight);
        TgPC.SetInputAllowed(6, bEnableLookUp);
        TgPC.SetInputAllowed(7, bEnableLookDown);
        TgPC.SetInputAllowed(14, bEnableJumping);
        TgPC.SetInputAllowed(8, bEnableAuto);
        TgPC.SetInputAllowed(9, bEnableAlt);
        TgPC.SetInputAllowed(10, bEnableBattleAbility);
        TgPC.SetInputAllowed(11, bEnableMovementAbility);
        TgPC.SetInputAllowed(12, bEnableUltimate);
        TgPC.SetInputAllowed(15, bEnableMounting);
        TgPC.SetInputAllowed(18, bEnableEmote);        
    }    
    //return;    
}

defaultproperties
{
    bEnableMoveForward=true
    bEnableMoveBackward=true
    bEnableMoveLeft=true
    bEnableMoveRight=true
    bEnableLookUp=true
    bEnableLookDown=true
    bEnableLookLeft=true
    bEnableLookRight=true
    bEnableJumping=true
    bEnableMounting=true
    bEnableAuto=true
    bEnableAlt=true
    bEnableBattleAbility=true
    bEnableMovementAbility=true
    bEnableUltimate=true
    bEnableEmote=true
    ObjName="Set Input Enabled/Disabled"
}