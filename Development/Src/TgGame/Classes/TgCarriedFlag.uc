class TgCarriedFlag extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

var transient int r_nDefenderTaskForce;
var transient TgCTFFlagBase s_FlagBase;
var repnotify transient bool r_bIsHome;
var transient TgPawn_Character m_Holder;
var repnotify transient TgRepInfo_Player r_HolderPRI;
var transient TgPawn_Character m_OldHolder;
var Controller m_FirstTouch;
var array<Controller> m_Assists;
var float m_fMaxDropTime;
var transient float m_fDefaultRadius;
var transient float m_fDefaultHeight;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_HolderPRI, r_bIsHome, r_nDefenderTaskForce;
}

function PostBeginPlay() { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

function CheckTouching() { }

function bool ValidHolder(Actor Other) { }

function SetHolder(Controller C) { }

function ClearHolder() { }

function SendHome() { }

function Score() { }

function AutoSendHome() { }

function CheckFit() { }

event Drop(optional Controller Killer, optional bool bNoThrow) { }

function ClearOldHolder() { }

auto state Home {}

state Held {}

state Dropped {}

defaultproperties
{}
