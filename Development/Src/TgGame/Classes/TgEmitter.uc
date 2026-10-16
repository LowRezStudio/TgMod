class TgEmitter extends Emitter
    native(FX)
    hidecategories(Navigation)
    config(Engine);

var repnotify name BoneName;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) BoneName;
}

simulated event ReplicatedEvent(name VarName) { }

function AttachTo(Pawn P, name NewBoneName) { }

simulated function ScaleEmitter(float ScaleFactor) { }

defaultproperties
{}
