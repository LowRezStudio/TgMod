class TgControlModule_Dead extends TgControlModule
    config(Engine);

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot) { }

function PlayerMove(float DeltaTime) { }

function UpdateRotation(float DeltaTime) { }

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock) { }
