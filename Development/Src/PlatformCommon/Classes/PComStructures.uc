class PComStructures extends Object
    native
    config(Engine);

enum CMTargetType {
    CMTT_Pawn,  // 0
    CMTT_Deployable,  // 1
    CMTT_Destructible,  // 2
    CMTT_Projectile,  // 3
};

struct CombatMessageInfo {
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
    structdefaultproperties {}
};
