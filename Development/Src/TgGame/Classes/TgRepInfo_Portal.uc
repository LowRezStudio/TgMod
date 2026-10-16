class TgRepInfo_Portal extends TgRepInfo_Deployable
    native(Game)
    hidecategories(Navigation,Movement,Collision)
    config(Engine);

var TgRepInfo_Portal r_TwinDRI;
var bool c_bMasterEntity;

replication {
    if(bNetDirty && int(Role) == int(ENetRole.ROLE_Authority)) r_TwinDRI;
}
