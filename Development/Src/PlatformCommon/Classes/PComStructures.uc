class PComStructures extends Object
    native;

enum CMTargetType
{
    CMTT_Pawn,
    CMTT_Deployable,
    CMTT_Destructible,
    CMTT_Projectile
};

struct native CombatMessageInfo
{
    var int nMsgId;
    var int nSourceId;
    var PComStructures.CMTargetType eSourceType;
    var int nSourceOwnerId;
    var int nTargetId;
    var int nTargetOwnerId;
    var PComStructures.CMTargetType eTargetType;
    var int nAmount1;
    var int nAmount2;
    var int nSourceItemId;
    var int nDamageTypeId;
    var byte nFireModeIndex;
    var int nLocationId;
    var int nEventIndex;
    var int nLocationX;
    var int nLocationY;

    structdefaultproperties
    {
        nMsgId=0
        nSourceId=0
        eSourceType=CMTT_Pawn
        nSourceOwnerId=0
        nTargetId=0
        nTargetOwnerId=0
        eTargetType=CMTT_Pawn
        nAmount1=0
        nAmount2=0
        nSourceItemId=0
        nDamageTypeId=0
        nFireModeIndex=0
        nLocationId=0
        nEventIndex=0
        nLocationX=0
        nLocationY=0
    }
};
