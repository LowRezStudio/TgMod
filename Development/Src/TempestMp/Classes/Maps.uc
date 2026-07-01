class Maps extends Object;

struct MapData
{
    var string MapName;
    var array<string> MapGamemodes;
    var string MapReadableName;
};

var array<MapData> MapDatabase;

public function loadMaps()
{
    local MapData TempMap;
    TempMap.MapGamemodes.AddItem("Siege");
    TempMap.MapGamemodes.AddItem("TDM");


    TempMap.MapName = "IMM_Mines_P_v04"; TempMap.MapReadableName = "Ice Mines"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "BMM_P_v01"; TempMap.MapReadableName = "Brightmarsh"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "TMM_Beach_P_v04"; TempMap.MapReadableName = "Serpent Beach"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "TMM_Falls_P_v04"; TempMap.MapReadableName = "Jaguar Falls"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "TMM_P_Isle_v02"; TempMap.MapReadableName = "Frog Isle"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "QMM_P_v01"; TempMap.MapReadableName = "Splitstone Quarry"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "KMM_P_v01"; TempMap.MapReadableName = "Stone Keep"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "FMM_Mill_P_v04"; TempMap.MapReadableName = "Timber Mill"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "IMM_P_Igloo_v02"; TempMap.MapReadableName = "Frozen Guard"; MapDatabase.AddItem(TempMap);

    TempMap.MapGamemodes.RemoveItem("Siege");
    TempMap.MapGamemodes.AddItem("Onslaught");

    TempMap.MapName = "BMO_P_v01"; TempMap.MapReadableName = "Brightmarsh"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "IOM_P_v01"; TempMap.MapReadableName = "Snowfall Junction"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "TOM_P_v01"; TempMap.MapReadableName = "Primal Court"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "TMO_Falls_P_v04"; TempMap.MapReadableName = "Jaguar Falls"; MapDatabase.AddItem(TempMap);

    TempMap.MapGamemodes.RemoveItem("Onslaught");
    TempMap.MapGamemodes.AddItem("Payload");

    TempMap.MapName = "FPM_P_v01"; TempMap.MapReadableName = "Greenwood Outpost"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "IPM_P_v01"; TempMap.MapReadableName = "Frostbite Cavern"; MapDatabase.AddItem(TempMap);
    TempMap.MapName = "TPM_P_v01"; TempMap.MapReadableName = "Hidden Temple"; MapDatabase.AddItem(TempMap);

    TempMap.MapGamemodes.RemoveItem("Payload");
    TempMap.MapGamemodes.AddItem("ShootingRange");

    TempMap.MapName = "ShootingRange_P"; TempMap.MapReadableName = "Shooting Range"; MapDatabase.AddItem(TempMap);

    // BMO_P_v01 brightmarsh onslaught
    // IOM_P_v01 snowfall junction onslaught
    // TOM_P_v01 primal court onslaught
    // TMO_Falls_P_v04 jagual falls onslaught

    // FPM_P_v01 greenwood outpost payload
    // IPM_P_v01 frostbite cavern payload
    // TPM_P_v01 hidden temple payload

    // ShootingRange_P shooting range
    // FT_P_v01 tutorial
}