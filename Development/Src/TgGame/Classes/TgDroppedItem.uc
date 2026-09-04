class TgDroppedItem extends Actor
    native(Inventory)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var float m_fLifeSpan;
var bool m_bFadeOut;
var name m_nmPickUpState;
var repnotify int r_nItemId;
var export editinline MeshComponent c_Mesh;
var array<TgEffectGroup> s_EffectGroupList;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_nItemId;
}

native function TgEffectGroup GetEffectGroup(int nType, out int nIndex);  // Export UTgDroppedItem::execGetEffectGroup(FFrame&, void* const)

native function bool ApplyItemSetup();  // Export UTgDroppedItem::execApplyItemSetup(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

function GiveTo(TgPawn P) { }

state Pickup {}

state FadeOut {}

defaultproperties
{}
