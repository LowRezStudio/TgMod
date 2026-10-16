class PComPlayerProfile extends OnlinePlayerStorage
    native
    config(Engine);

struct PropertyPair {
    var int PropertyId;
    var int Value;
    structdefaultproperties {}
};

struct AccoladeStruct {
    var int AccoladeId;
    var int ActivityId;
    var int Type;
    var int Value;
    structdefaultproperties {}
};

struct BadgeStruct {
    var int BadgeId;
    var int ActivityId;
    var int Icon;
    var int Tier;
    var int Progress;
    var int MaxValue;
    var int Category;
    var init string Title;
    var init string Description;
    structdefaultproperties {}
};

var int Rank;
var int Kills;
var int Deaths;
var int Assists;
var int XpLevel;
var int HZPoints;
var int XPPoints;
var int AssistPoints;
var int AverageScore;
var int BoostHoursRemaining;
var int InfoMask;
var int TimePlayed;
var int TotalAccolades;
var int FastestSki;
var int FlagGrabs;
var int FlagCaps;
var int GensDestroyed;
var int ObjsDestroyed;
var bool bVIP;
var bool bBoost;
var int PlayerID;
var init string PlayerName;
var array<BadgeStruct> Badges;
var array<BadgeStruct> TopBadges;
var array<PropertyPair> ClassTimePlayed;
var array<AccoladeStruct> Accolades;
