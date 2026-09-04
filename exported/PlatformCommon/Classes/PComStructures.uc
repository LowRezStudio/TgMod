class PComStructures extends Object
    native;

enum CMTargetType
{
    CMTT_Pawn,                      // 0
    CMTT_Deployable,                // 1
    CMTT_Destructible,              // 2
    CMTT_Projectile,                // 3
    CMTT_MAX                        // 4
};

struct native CombatMessageInfo
{
    var int nMsgId;
    var int nSourceId;
    var PComStructures.CMTargetType eSourceType;
    var int nSourceOwnerId;
    var int nTargetId;
    var PComStructures.CMTargetType eTargetType;
    var int nAmount1;
    var int nAmount2;
    var int nSourceItemId;
    var int nDamageTypeId;
    var int nLocationId;
    var int nEventIndex;
    var int nLocationX;
    var int nLocationY;

    structdefaultproperties
    {
        nMsgId=0
        nSourceId=0
        eSourceType=CMTargetType.CMTT_Pawn
        nSourceOwnerId=0
        nTargetId=0
        eTargetType=CMTargetType.CMTT_Pawn
        nAmount1=0
        nAmount2=0
        nSourceItemId=0
        nDamageTypeId=0
        nLocationId=0
        nEventIndex=0
        nLocationX=0
        nLocationY=0
    }
};
