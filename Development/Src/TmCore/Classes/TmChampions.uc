// Champion catalog: the single owner of champion identity — the data table,
// the alias map, every "resolve a champion from X" lookup, loadout data and
// application, and the per-champion forced-third-person ability masks.
class TmChampions extends Object
    abstract;

struct ChampionInfo {
    var string Name;
    var array<string> Aliases;
    var int BotId;
    var int PawnClassId;
    var int SkinId;
    var int HeadId;
    var int WeaponSkinId;
    var int VoicePackId;
};

struct LoadoutInfo {
    var int BotId;
    var string Talent;
    var string Card[5];
};

const DEFAULT_CHAMPION = "Cassie";

static final function AddChampion(out array<ChampionInfo> List, string Name, int BotId, int PawnClassId,
    int SkinId, int HeadId, int WeaponSkinId, int VoicePackId, optional string Alias1, optional string Alias2)
{
    local ChampionInfo C;

    C.Name = Name;
    C.BotId = BotId;
    C.PawnClassId = PawnClassId;
    C.SkinId = SkinId;
    C.HeadId = HeadId;
    C.WeaponSkinId = WeaponSkinId;
    C.VoicePackId = VoicePackId;
    if (Alias1 != "") C.Aliases.AddItem(Alias1);
    if (Alias2 != "") C.Aliases.AddItem(Alias2);
    List.AddItem(C);
}

static function array<ChampionInfo> GetAllChampions() {
    local array<ChampionInfo> List;

    AddChampion(List, "Pip", 2056, 21653, 12198, 14954, 13177, 12381);
    AddChampion(List, "Skye", 2057, 21654, 12207, 15407, 13179, 12195);
    AddChampion(List, "Fernando", 2071, 21651, 12203, 15257, 13173, 11483, "nando");
    AddChampion(List, "Barik", 2073, 21649, 12200, 15217, 13169, 12196);
    AddChampion(List, "Cassie", 2092, 21650, 12201, 15926, 13171, 11482);
    AddChampion(List, "Grohk", 2093, 21656, 12204, 15243, 13174, 12197);
    AddChampion(List, "Evie", 2094, 21652, 12202, 15204, 13172, 12382);
    AddChampion(List, "Buck", 2147, 21655, 12205, 15572, 13170, 12383);
    AddChampion(List, "Ruckus", 2149, 21645, 12206, 15795, 13178, 11535);
    AddChampion(List, "Androxus", 2205, 22226, 12199, 15129, 13168, 13296, "andro");
    AddChampion(List, "Kinessa", 2249, 22727, 12941, 15235, 13176, 13242, "nessa");
    AddChampion(List, "Grover", 2254, 22828, 12940, 15588, 13175, 12999);
    AddChampion(List, "Ying", 2267, 23349, 13212, 15418, 13221, 13450, "bestwaifu");
    AddChampion(List, "Drogoz", 2277, 23898, 13404, 15274, 13379, 14080);
    AddChampion(List, "Bomb King", 2281, 23985, 13336, 14960, 13380, 14391, "bombking", "bk");
    AddChampion(List, "Viktor", 2285, 24317, 14173, 15154, 14174, 14460, "vik");
    AddChampion(List, "Makoa", 2288, 24381, 14465, 15124, 14466, 14631, "koa");
    AddChampion(List, "Mal'Damba", 2303, 25066, 14587, 15194, 14593, 15165, "maldamba", "damba");
    AddChampion(List, "ShaLin", 2307, 25366, 14890, 15642, 14892, 15599);
    AddChampion(List, "Tyra", 2314, 25806, 15822, 16068, 15821, 15959);
    AddChampion(List, "Torvald", 2322, 26707, 15810, 16236, 15809, 16324);
    AddChampion(List, "Maeve", 2338, 27193, 16216, 16217, 16221, 16490);
    AddChampion(List, "Inara", 2348, 27261, 16245, 16287, 16290, 16291);
    AddChampion(List, "Lex", 2362, 27672, 16531, 16958, 16532, 16893);
    AddChampion(List, "Seris", 2372, 27775, 16584, 16586, 16585, 16943);
    AddChampion(List, "Willo", 2393, 28209, 16810, 18307, 16811, 18317);
    AddChampion(List, "Ash", 2404, 28373, 16977, 18859, 16981, 18670);
    AddChampion(List, "Lian", 2417, 29455, 19032, 19321, 19033, 19289);
    AddChampion(List, "Zhin", 2420, 28815, 18231, 18232, 18300, 19060);
    AddChampion(List, "Jenos", 2431, 29924, 19034, 19224, 19035, 19364);
    AddChampion(List, "Strix", 2438, 30083, 19112, 19642, 19136, 19643);
    AddChampion(List, "Talus", 2472, 30568, 19324, 19557, 19328, 19557);

    return List;
}

static function ChampionInfo EmptyChampion() {
    local ChampionInfo C;
    return C;
}

static function ChampionInfo GetChampionByName(string Name) {
    local array<ChampionInfo> List;
    local int i, j;

    Name = Caps(Name);
    List = GetAllChampions();
    for (i = 0; i < List.Length; i++) {
        if (Caps(List[i].Name) == Name) {
            return List[i];
        }
        for (j = 0; j < List[i].Aliases.Length; j++) {
            if (Caps(List[i].Aliases[j]) == Name) {
                return List[i];
            }
        }
    }
    return EmptyChampion();
}

static function ChampionInfo GetChampionByBotId(int BotId) {
    local array<ChampionInfo> List;
    local int i;

    List = GetAllChampions();
    for (i = 0; i < List.Length; i++) {
        if (List[i].BotId == BotId) {
            return List[i];
        }
    }
    return EmptyChampion();
}

static function ChampionInfo GetChampionByPawnClass(int PawnClassId) {
    local array<ChampionInfo> List;
    local int i;

    List = GetAllChampions();
    for (i = 0; i < List.Length; i++) {
        if (List[i].PawnClassId == PawnClassId) {
            return List[i];
        }
    }
    return EmptyChampion();
}

static function bool ChampionExists(string Name) {
    return GetChampionByName(Name).BotId > 0;
}

static function int GetChampionBotId(string Name) {
    return GetChampionByName(Name).BotId;
}

static function array<string> GetAllChampionNames() {
    local array<ChampionInfo> List;
    local array<string> Names;
    local int i;

    List = GetAllChampions();
    for (i = 0; i < List.Length; i++) {
        Names.AddItem(List[i].Name);
    }
    return Names;
}

// Unknown or empty names fall back to the default champion.
static function ChampionInfo ResolveChampion(string ChampionName) {
    local ChampionInfo C;

    if (ChampionName != "")
        C = GetChampionByName(ChampionName);

    if (C.BotId <= 0) {
        if (ChampionName != "")
            `LogWarn('TmChampions', "Unknown champion '" @ ChampionName @ "' — defaulting to " $ DEFAULT_CHAMPION);
        C = GetChampionByName(DEFAULT_CHAMPION);
    }
    return C;
}

static function ApplyChampionToPRI(TgRepInfo_Player PRI, ChampionInfo C) {
    local TgPlayerController PC;
    local TgRepInfo_Player CPRI;

    if (PRI == none || C.BotId <= 0) {
        return;
    }
    PC = TgPlayerController(PRI.Owner);
    if (PC == none) {
        return;
    }

    PC.m_nVoicePackId = C.VoicePackId;
    PRI.r_nProfileId = C.BotId;
    PRI.r_nSkinId = C.SkinId;
    PRI.r_nHeadSkinId = C.HeadId;
    PRI.r_nWeaponSkinId = C.WeaponSkinId;

    CPRI = PC.CachedPRI;
    CPRI.r_nProfileId = C.BotId;
    CPRI.r_nSkinId = C.SkinId;
    CPRI.r_nHeadSkinId = C.HeadId;
    CPRI.r_nWeaponSkinId = C.WeaponSkinId;
}

static final function AddLoadout(out array<LoadoutInfo> List, int BotId,
    string Talent, string Card1, string Card2, string Card3, string Card4, string Card5)
{
    local LoadoutInfo L;

    L.Talent = Talent;
    L.Card[0] = Card1;
    L.Card[1] = Card2;
    L.Card[2] = Card3;
    L.Card[3] = Card4;
    L.Card[4] = Card5;
    L.BotId = BotId;
    List.AddItem(L);
}

static function array<LoadoutInfo> GetAllLoadouts() {
    local array<LoadoutInfo> List;

    AddLoadout(List, 2205, "Dark Stalker", "Power of the Abyss IV", "Sleight of Hand I", "Buying Time I", "Elusive IV", "Seething Hatred II");  // Androxus
    AddLoadout(List, 2404, "Battering Ram", "Heavy Metal IV", "Percussion II", "Trebuchet I", "Gate Crasher IV", "Watchtower I");               // Ash
    AddLoadout(List, 2073, "Tinkerin", "Healing Station IV", "Bowling Ball IV", "Failsafe II", "Double Time I", "Field Deploy I");              // Barik
    AddLoadout(List, 2281, "Chain Reaction", "Air Blast II", "Backdraft II", "King's New Cloak II", "Royal Decree IV", "King's Court II");      // Bomb King
    AddLoadout(List, 2147, "Bounce House", "Leg Day IV", "Stomping Ground II", "Seismic Wave IV", "Rapid Sustain I", "Giga Siphon I");          // Buck
    AddLoadout(List, 2092, "Exaction", "Incitement IV", "Somersault II", "Onslaught III", "Lunge II", "Megaton I");                             // Cassie
    AddLoadout(List, 2277, "W.Y.R.M. Jets", "Propel IV", "Fuel Tank III", "Survival II", "Follow the Scent I", "Lung Capacity I");              // Drogoz
    AddLoadout(List, 2094, "Over the Moon", "Swift Witch III", "Killing Frost IV", "Cantrip I", "Teleport II", "Great Distance II");            // Evie
    AddLoadout(List, 2071, "Scorch", "Hot Pursuit IV", "Incinerate IV", "Heat Transfer I", "Last Stand II", "Launch I");                        // Fernando
    AddLoadout(List, 2093, "Totemic Ward", "Gale IV", "Shamanic Might I", "Outreach IV", "Crackle II", "Astral Traveler I");                    // Grohk
    AddLoadout(List, 2254, "Ferocity", "Verdant Expanse IV", "Gentle Breeze IV", "Adrenaline I", "Vine Grasp I", "Over Growth II");             // Grover
    AddLoadout(List, 2348, "Mother's Grace", "Geomancer IV", "Steadfast II", "Shear I", "Lodestone I", "Stone Bulwark IV");                     // Inara
    AddLoadout(List, 2431, "Luminary", "Star Seeker IV", "Space Jam IV", "Relativity II", "Lightyears I", "Heavenly Pull I");                   // Jenos
    AddLoadout(List, 2249, "Steady Aim", "Prodigy IV", "Beam Me Up IV", "Open Season I", "Quick Scope II", "True Grit I");                      // Kinessa
    AddLoadout(List, 2362, "Death Hastens", "Warrants Out IV", "Requip II", "Wicked Don't Rest IV", "Conditioned I", "Compel I");               // Lex
    AddLoadout(List, 2417, "Eminence", "Heraldry IV", "Manifest Destiny II", "Highborn II", "Superiority I", "Inheritance III");                // Lian
    AddLoadout(List, 2338, "Cat Burglar", "Street Cred II", "Chase IV", "Scamper IV", "Featherlite I", "Walk it Off I");                        // Maeve
    AddLoadout(List, 2288, "Pluck", "Rampage IV", "Strongarm II", "Surf IV", "Salvage I", "Ebb and Flow I");                                    // Makoa
    AddLoadout(List, 2303, "Ripened Gourd", "Possession IV", "Swift Spirits IV", "Fleeting II", "Ritual Magic I", "Lighter Gourd I");           // Mal'Damba
    AddLoadout(List, 2056, "Catalyst", "Moxie III", "Acumen III", "Side Tanks II", "Gift Giver II", "Smithereens II");                          // Pip
    AddLoadout(List, 2149, "Aerial Assault", "Fuel Reserves IV", "Slow Dampener II", "Crystal Capacitor IV", "Refraction I", "E.M.P. I");       // Ruckus
    AddLoadout(List, 2372, "Mortal Reach", "Veil IV", "Blood Pact II", "Dark Sight I", "Spirit Leech I", "Umbral Gait IV");                     // Seris
    AddLoadout(List, 2307, "Desert Shadow", "Wanderlust IV", "Swagger I", "Run Them Down I", "Mirage II", "Run Like the Wind IV");              // Shalin
    AddLoadout(List, 2057, "Surprise Attack", "Confound III", "Specter III", "Ninja II", "Dissipate III", "Quick Smoker I");                    // Skye
    AddLoadout(List, 2438, "Crack Shot", "Bushwack III", "Dexterous III", "Tactical Retreat III", "Relentless II", "Cooled Mags I");            // Strix
    AddLoadout(List, 2322, "Field Study", "Winddancer III", "Glyph of Health II", "Eldritch Speed IV", "Timeshaper II", "Scribe's Wit I");      // Torvald
    AddLoadout(List, 2314, "Mercy Kill", "Locked and Loaded II", "Bandolier IV", "Tracker II", "Ranger I", "Incensed III");                     // Tyra
    AddLoadout(List, 2285, "Firefight", "Scramble IV", "Compensator II", "Firing Stance IV", "Flak Jacket I", "Second Wind I");                 // Viktor
    AddLoadout(List, 2393, "Blastflower", "Hummingbird I", "Flora IV", "Just Believe! II", "Flitter IV", "Germination I");                      // Willo
    AddLoadout(List, 2267, "Focusing Lens", "Spring Bloom IV", "Spring Forward III", "Rewind I", "Mesmerism III", "Encouragement I");           // Ying
    AddLoadout(List, 2420, "Retaliation", "Blade Dance II", "Master Stance IV", "Perfect Block II", "Hideout II", "Up in Smoke II");            // Zhin

    return List;
}

static function LoadoutInfo EmptyLoadout() {
    local LoadoutInfo L;
    return L;
}

static function LoadoutInfo GetLoadoutByBotId(int BotId) {
    local array<LoadoutInfo> List;
    local int i;

    List = GetAllLoadouts();
    for (i = 0; i < List.Length; i++) {
        if (List[i].BotId == BotId) {
            return List[i];
        }
    }
    return EmptyLoadout();
}

static function LoadoutInfo GetLoadoutForChampion(ChampionInfo C) {
    return GetLoadoutByBotId(C.BotId);
}

static function bool ApplyLoadoutToPawn(TgPlayerController PC, TgPawn_Character Pawn, LoadoutInfo L) {
    local TgInventoryManager InvMgr;
    local int DeviceId;
    local int i;
    local int EquipPoints[5];

    if (PC == none || Pawn == none || L.Talent == "") {
        return false;
    }
    InvMgr = TgInventoryManager(Pawn.InvManager);
    if (InvMgr == none) {
        return false;
    }

    EquipPoints[0] = 19;  // card1
    EquipPoints[1] = 20;  // card2
    EquipPoints[2] = 21;  // card3
    EquipPoints[3] = 22;  // card4
    EquipPoints[4] = 5;   // card5

    for (i = 0; i < 5; i++) {
        DeviceId = PC.GetDeviceIdByName(L.Card[i]);
        if (DeviceId > 0) {
            InvMgr.AddDevice(DeviceId, EquipPoints[i], none, true, 0);
        }
    }

    DeviceId = PC.GetDeviceIdByName(L.Talent);
    if (DeviceId > 0) {
        InvMgr.AddDevice(DeviceId, 25, none, true, 0);
    }

    return true;
}

// --- Forced third person (first person spectator) ---

// Devices don't replicate to spectators, but c_EquipFormState per equip point
// does, so third person windows come from tables instead of device checks.
// Ultimates (equip point 2) that play out in third person. Jenos' Through
// Time and Space already closes the gate natively and needs no entry.
static function int Force3PUltSlotMask(TgPawn ViewPawn)
{
    if (ViewPawn.IsA('TgPawn_Princess')       // Lian
        || ViewPawn.IsA('TgPawn_Flak')        // Ash
        || ViewPawn.IsA('TgPawn_Knight')      // Fernando
        || ViewPawn.IsA('TgPawn_Darklord')    // Zhin
        || ViewPawn.IsA('TgPawn_Shaman')      // Grohk
        || ViewPawn.IsA('TgPawn_BombKing')    // Bomb King
        || ViewPawn.IsA('TgPawn_Drogoz')      // Drogoz
        || ViewPawn.IsA('TgPawn_BarrierTank') // Inara
        || ViewPawn.IsA('TgPawn_Druid'))      // Grover
        return 1 << 2;

    return 0;
}

// Champion internal class names (runtime): Cassie=Huntress,
// Fernando=Knight, Barik=Engineer, Grohk=Shaman, Evie=Mage,
// Lian=Princess, Ash=Flak, Makoa=Makoa, Androxus=Androxus,
// Zhin=Darklord, Maeve=Blades, Willo=Fairy, Sha Lin=Longbow,
// Seris=Oracle, Strix=Owl, Inara=BarrierTank, Terminus=Lazarus,
// Tyra=Salty, Viktor=BRmale/Robosarge, Pip=Alchemist, Vivian=Churchill,
// Moji=Rider, Lex=Lawman, Grover=Druid, Atlas=TimeTraveler,
// Koga=Ninja, Furia=Angel, Dredge=Pirate, Ying=Illusionist,
// Khan=Vanguard. Old export aliases kept as fallbacks where they exist.
static function int Force3PSlotMask(TgPawn ViewPawn)
{
    // Zhin forces third person on both F and Q.
    if (ViewPawn.IsA('TgPawn_Darklord'))
        return (1 << 4) | (1 << 3);

    // Fernando forces it on F and RMB
    if(ViewPawn.IsA('TgPawn_Fernando') || ViewPawn.IsA('TgPawn_Knight'))
        return (1 << 4) | (1 << 16);

    // Androxus forces it on Q only.
    if (ViewPawn.IsA('TgPawn_Androxus'))
        return (1 << 3);

    // Everyone else with a forcing ability uses F only.
    if (ViewPawn.IsA('TgPawn_Huntress')        // Cassie dodge roll
        || ViewPawn.IsA('TgPawn_Cassie')       // (old alias)
        || ViewPawn.IsA('TgPawn_Princess')     // Lian
        || ViewPawn.IsA('TgPawn_Flak')         // Ash
        || ViewPawn.IsA('TgPawn_Engineer')     // Barik
        || ViewPawn.IsA('TgPawn_Barik')        // (old alias)
        || ViewPawn.IsA('TgPawn_Makoa')        // Makoa
        || ViewPawn.IsA('TgPawn_Shaman')       // Grohk
        || ViewPawn.IsA('TgPawn_Grohk')        // (old alias)
        || ViewPawn.IsA('TgPawn_Mage')         // Evie
        || ViewPawn.IsA('TgPawn_Evie')         // (old alias)
        || ViewPawn.IsA('TgPawn_Fairy'))       // Willo
        return (1 << 4);

    // Tyra, Viktor, Sha Lin, Bomb King, Drogoz, Kinessa, Inara, Ruckus,
    // Torvald, Buck, Lex, Maeve, Skye, Grover, Seris, Ying, Strix: none.
    return 0;
}

defaultproperties
{
}
