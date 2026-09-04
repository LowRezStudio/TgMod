class TgKismetTestActor extends DynamicSMActor
    hidecategories(Navigation)
    config(Engine);

var () int m_nTestCount;
var () repnotify int r_nCurrentTest;
var repnotify int r_nPassCount;
var repnotify int r_nFailCount;
var () array<Texture2D> c_aTextures;
var () SoundCue c_PassSound;
var () SoundCue c_FailSound;
var () array<InterpActor> c_aResultActors;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nCurrentTest, r_nFailCount, r_nPassCount;
}

simulated function OnTestResult(TgSeqAct_TestResult Action) { }

simulated function PlayerController GetLocalPlayer() { }

unreliable client simulated function SetTestColor(int Num, LinearColor Col) { }

simulated event PostBeginPlay() { }

unreliable client simulated function PassTest(int Num) { }

unreliable client simulated function FailTest(int Num) { }

unreliable client simulated function StartTest(int Num) { }

simulated event ReplicatedEvent(name VarName) { }

defaultproperties
{}
