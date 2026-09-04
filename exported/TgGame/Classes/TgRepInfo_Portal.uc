class TgRepInfo_Portal extends TgRepInfo_Deployable
    native(Game)
    hidecategories(Navigation,Movement,Collision);

var TgRepInfo_Portal r_TwinDRI;
var bool c_bMasterEntity;

replication
{
    // Pos:0x000
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        r_TwinDRI;
}
