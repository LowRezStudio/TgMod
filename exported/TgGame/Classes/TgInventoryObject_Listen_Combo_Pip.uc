class TgInventoryObject_Listen_Combo_Pip extends TgInventoryObject_Listen_Combo
    native(Inventory);

var array<TgProjectile> m_Projectiles;
var array<Vector> m_SpawnLocations;
var array<Actor> m_MarkedTargetsFlask;
var array<float> m_fMarkedTimesFlask;
