class TgControlModule_Free extends TgControlModule
    config(Engine);

var int CameraYawOffset;

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock) { }

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

function UpdateRotation(float DeltaTime) { }
