class TgIdol extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

var transient int r_nDefenderTaskForce;
var transient TgPawn_Character m_Holder;
var repnotify transient TgRepInfo_Player r_HolderPRI;
var transient TgPawn_Character m_OldHolder;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_HolderPRI, r_nDefenderTaskForce;
}

defaultproperties
{}
