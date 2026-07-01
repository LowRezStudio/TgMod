class AServerConfigData extends Object
    config(ServerConfig);


var config bool flag;

struct ChampionData
{
    var string name;
    var array<string> aliases;
    var int BotId;
    var int SkinId;
    var int DeviceSkinId;
    var int HeadId;
    var int sprayId;
    var int mountId;
    var string Talent;
    var string card1;
    var string card2;
    var string card3;
    var string card4;
    var string card5;
};

var config array<ChampionData> Champion;

function InitializeConfig()
{
    local ChampionData TempChamp;
    if(!flag) {
        TempChamp.sprayId = 15587;
        TempChamp.mountId = 12616;

        // Androxus
        TempChamp.name = "androxus";
        TempChamp.aliases.AddItem("andro");
        TempChamp.BotId = 2205; TempChamp.SkinId = 15292; TempChamp.DeviceSkinId = 13168;TempChamp.HeadId = 15160;
        TempChamp.Talent = "Dark Stalker"; TempChamp.card1 = "Power of the Abyss iv"; TempChamp.card2 = "Sleight of Hand i"; TempChamp.card3 = "Buying Time i"; TempChamp.card4 = "elusive iv" ; TempChamp.card5 = "Seething Hatred ii";
        Champion.AddItem(TempChamp);

        // Ash
        TempChamp.name = "ash";
        TempChamp.aliases.RemoveItem("andro");
        TempChamp.BotId = 2404; TempChamp.SkinId = 16977; TempChamp.DeviceSkinId = 16981; TempChamp.HeadId = 18859;
        TempChamp.Talent = "Battering Ram"; TempChamp.card1 = "Heavy Metal iv"; TempChamp.card2 = "Percussion ii"; TempChamp.card3 = "Trebuchet i"; TempChamp.card4 = "Gate Crasher iv"; TempChamp.card5 = "Watchtower i";
        Champion.AddItem(TempChamp);

        // Barik
        TempChamp.name = "barik";
        TempChamp.BotId = 2073; TempChamp.SkinId = 12200; TempChamp.DeviceSkinId = 13169; TempChamp.HeadId = 15217;
        TempChamp.Talent = "Tinkerin"; TempChamp.card1 = "Healing Station iv"; TempChamp.card2 = "Bowling Ball iv"; TempChamp.card3 = "Failsafe ii"; TempChamp.card4 = "Double Time i"; TempChamp.card5 = "Field Deploy i";
        Champion.AddItem(TempChamp);

        // Bomb King
        TempChamp.name = "bombking";
        TempChamp.aliases.AddItem("bk");
        TempChamp.BotId = 2281; TempChamp.SkinId = 15294; TempChamp.DeviceSkinId = 13380; TempChamp.HeadId = 14960;
        TempChamp.Talent = "Chain Reaction"; TempChamp.card1 = "Air Blast ii"; TempChamp.card2 = "Backdraft ii"; TempChamp.card3 = "King's New Cloak ii"; TempChamp.card4 = "Royal Decree iv"; TempChamp.card5 = "King's Court ii";
        Champion.AddItem(TempChamp);

        // Buck
        TempChamp.name = "buck";
        TempChamp.aliases.RemoveItem("bk");
        TempChamp.BotId = 2147; TempChamp.SkinId = 15295; TempChamp.DeviceSkinId = 13170; TempChamp.HeadId = 15572;
        TempChamp.Talent = "Bounce House"; TempChamp.card1 = "Leg Day iv"; TempChamp.card2 = "Stomping Ground ii"; TempChamp.card3 = "Seismic Wave iv"; TempChamp.card4 = "Rapid Sustain i"; TempChamp.card5 = "Giga Siphon i";
        Champion.AddItem(TempChamp);

        // Cassie
        TempChamp.name = "cassie";
        TempChamp.BotId = 2092; TempChamp.SkinId = 12201; TempChamp.DeviceSkinId = 13171; TempChamp.HeadId = 15926;
        TempChamp.Talent = "Exaction"; TempChamp.card1 = "Incitement iv"; TempChamp.card2 = "Somersault ii"; TempChamp.card3 = "Onslaught iii"; TempChamp.card4 = "Lunge ii"; TempChamp.card5 = "Megaton i";
        Champion.AddItem(TempChamp);

        // Drogoz
        TempChamp.name = "drogoz";
        TempChamp.BotId = 2277; TempChamp.SkinId = 13404; TempChamp.DeviceSkinId = 13379; TempChamp.HeadId = 15274;
        TempChamp.Talent = "W.Y.R.M. Jets"; TempChamp.card1 = "Propel iv"; TempChamp.card2 = "Fuel Tank iii"; TempChamp.card3 = "Survival ii"; TempChamp.card4 = "Follow the Scent i"; TempChamp.card5 = "Lung Capacity i";
        Champion.AddItem(TempChamp);

        // Evie
        TempChamp.name = "evie";
        TempChamp.BotId = 2094; TempChamp.SkinId = 15298; TempChamp.DeviceSkinId = 13172; TempChamp.HeadId = 15204;
        TempChamp.Talent = "Over the Moon"; TempChamp.card1 = "Swift Witch iii"; TempChamp.card2 = "Killing Frost iv"; TempChamp.card3 = "Cantrip i"; TempChamp.card4 = "Teleport ii"; TempChamp.card5 = "Great Distance ii";
        Champion.AddItem(TempChamp);

        // Fernando
        TempChamp.name = "fernando";
        TempChamp.aliases.AddItem("nando");
        TempChamp.BotId = 2071; TempChamp.SkinId = 15299; TempChamp.DeviceSkinId = 13173; TempChamp.HeadId = 15257;
        TempChamp.Talent = "Scorch"; TempChamp.card1 = "Hot Pursuit iv"; TempChamp.card2 = "Incinerate iv"; TempChamp.card3 = "Heat Transfer i"; TempChamp.card4 = "Last Stand ii"; TempChamp.card5 = "Launch i";
        Champion.AddItem(TempChamp);

        // Grohk
        TempChamp.name = "grohk";
        TempChamp.aliases.RemoveItem("nando");
        TempChamp.BotId = 2093; TempChamp.SkinId = 15300; TempChamp.DeviceSkinId = 13174; TempChamp.HeadId = 15243;
        TempChamp.Talent = "Totemic Ward"; TempChamp.card1 = "Gale iv"; TempChamp.card2 = "Shamanic Might i"; TempChamp.card3 = "Outreach iv"; TempChamp.card4 = "Crackle ii"; TempChamp.card5 = "Astral Traveler i";
        Champion.AddItem(TempChamp);

        // Grover
        TempChamp.name = "grover";
        TempChamp.BotId = 2254; TempChamp.SkinId = 15301; TempChamp.DeviceSkinId = 13175; TempChamp.HeadId = 15588;
        TempChamp.Talent = "Ferocity"; TempChamp.card1 = "Verdant Expanse iv"; TempChamp.card2 = "Gentle Breeze iv"; TempChamp.card3 = "Adrenaline i"; TempChamp.card4 = "Vine Grasp i"; TempChamp.card5 = "Over growth ii";
        Champion.AddItem(TempChamp);

        // Inara
        TempChamp.name = "inara";
        TempChamp.aliases.AddItem("nara");
        TempChamp.BotId = 2348; TempChamp.SkinId = 16245; TempChamp.DeviceSkinId = 16290; TempChamp.HeadId = 16287;
        TempChamp.Talent = "Mothers Grace"; TempChamp.card1 = "Geomancer iv"; TempChamp.card2 = "Steadfast ii"; TempChamp.card3 = "Shear i"; TempChamp.card4 = "Lodestone i"; TempChamp.card5 = "Stone Bulwark iv";
        Champion.AddItem(TempChamp);

        // Jenos
        TempChamp.name = "jenos";
        TempChamp.aliases.RemoveItem("nara");
        TempChamp.BotId = 2431; TempChamp.SkinId = 19034; TempChamp.DeviceSkinId = 19035; TempChamp.HeadId = 19224;
        TempChamp.Talent = "Luminary"; TempChamp.card1 = "Star Seeker iv"; TempChamp.card2 = "Space Jam iv"; TempChamp.card3 = "Relativity ii"; TempChamp.card4 = "Lightyears i"; TempChamp.card5 = "Heavenly Pull i";
        Champion.AddItem(TempChamp);

        // Kinessa
        TempChamp.name = "kinessa";
        TempChamp.aliases.AddItem("nessa");
        TempChamp.BotId = 2249; TempChamp.SkinId = 12941; TempChamp.DeviceSkinId = 13176; TempChamp.HeadId = 15235;
        TempChamp.Talent = "Steady Aim"; TempChamp.card1 = "Prodigy iv"; TempChamp.card2 = "Beam Me Up iv"; TempChamp.card3 = "Open Season i"; TempChamp.card4 = "Quick Scope ii"; TempChamp.card5 = "True Grit i";
        Champion.AddItem(TempChamp);

        // Lex
        TempChamp.name = "lex";
        TempChamp.aliases.RemoveItem("nessa");
        TempChamp.BotId = 2362; TempChamp.SkinId = 16531; TempChamp.DeviceSkinId = 16532; TempChamp.HeadId = 16958;
        TempChamp.Talent = "Death Hastens"; TempChamp.card1 = "Warrants Out iv"; TempChamp.card2 = "Requip ii"; TempChamp.card3 = "Wicked Dont Rest iv"; TempChamp.card4 = "Conditioned i"; TempChamp.card5 = "Compel i";
        Champion.AddItem(TempChamp);

        // Lian
        TempChamp.name = "lian";
        TempChamp.BotId = 2417; TempChamp.SkinId = 19032; TempChamp.DeviceSkinId = 19033; TempChamp.HeadId = 19321;
        TempChamp.Talent = "Eminence"; TempChamp.card1 = "Heraldry iv"; TempChamp.card2 = "Manifest Destiny ii"; TempChamp.card3 = "Highborn ii"; TempChamp.card4 = "Superiority i"; TempChamp.card5 = "Inheritance iii";
        Champion.AddItem(TempChamp);

        // Maeve
        TempChamp.name = "maeve";
        TempChamp.BotId = 2338; TempChamp.SkinId = 16216; TempChamp.DeviceSkinId = 16221; TempChamp.HeadId = 16217;
        TempChamp.Talent = "Cat Burglar"; TempChamp.card1 = "Street Cred ii"; TempChamp.card2 = "Chase iv"; TempChamp.card3 = "Scamper iv"; TempChamp.card4 = "featherlite i"; TempChamp.card5 = "walk it off i";
        Champion.AddItem(TempChamp);

        // Makoa
        TempChamp.name = "makoa";
        TempChamp.aliases.AddItem("koa");
        TempChamp.BotId = 2288; TempChamp.SkinId = 14465; TempChamp.DeviceSkinId = 14466; TempChamp.HeadId = 15124;
        TempChamp.Talent = "Pluck"; TempChamp.card1 = "Rampage iv"; TempChamp.card2 = "Strongarm ii"; TempChamp.card3 = "Surf iv"; TempChamp.card4 = "Salvage i"; TempChamp.card5 = "Ebb And Flow i";
        Champion.AddItem(TempChamp);

        // Mal'Damba
        TempChamp.name = "maldamba";
        TempChamp.aliases.RemoveItem("koa");
        TempChamp.aliases.AddItem("damba");
        TempChamp.BotId = 2303; TempChamp.SkinId = 14587; TempChamp.DeviceSkinId = 14593; TempChamp.HeadId = 15194;
        TempChamp.Talent = "Ripened Gourd"; TempChamp.card1 = "Possession iv"; TempChamp.card2 = "Swift Spirits iv"; TempChamp.card3 = "Eerie Presence ii"; TempChamp.card4 = "Ritual Magic i"; TempChamp.card5 = "Lighter Gourd i";
        Champion.AddItem(TempChamp);

        // Pip
        TempChamp.name = "pip";
        TempChamp.aliases.RemoveItem("damba");
        TempChamp.BotId = 2056; TempChamp.SkinId = 15303; TempChamp.DeviceSkinId = 13177; TempChamp.HeadId = 14954;
        TempChamp.Talent = "Catalyst"; TempChamp.card1 = "Moxie iii"; TempChamp.card2 = "Acumen iii"; TempChamp.card3 = "Side Tanks ii"; TempChamp.card4 = "Escape Artist iii"; TempChamp.card5 = "Smithereens i";
        Champion.AddItem(TempChamp);

        // Ruckus
        TempChamp.name = "ruckus";
        TempChamp.BotId = 2149; TempChamp.SkinId = 15304; TempChamp.DeviceSkinId = 13178; TempChamp.HeadId = 15795;
        TempChamp.Talent = "Aerial Assault"; TempChamp.card1 = "Fuel Reserves iv"; TempChamp.card2 = "Dampener ii"; TempChamp.card3 = "Crystal Capacitor iv"; TempChamp.card4 = "Refraction i"; TempChamp.card5 = "E.M.P i";
        Champion.AddItem(TempChamp);

        // Seris
        TempChamp.name = "seris";
        TempChamp.BotId = 2372; TempChamp.SkinId = 16584; TempChamp.DeviceSkinId = 16585; TempChamp.HeadId = 16586;
        TempChamp.Talent = "Mortal Reach"; TempChamp.card1 = "Veil iv"; TempChamp.card2 = "Blood Pact ii"; TempChamp.card3 = "Dark Sight i"; TempChamp.card4 = "Spirit Leech i"; TempChamp.card5 = "Umbral Gait iv";
        Champion.AddItem(TempChamp);

        // Sha Lin
        TempChamp.name = "shalin";
        TempChamp.aliases.AddItem("sha");
        TempChamp.BotId = 2307; TempChamp.SkinId = 14890; TempChamp.DeviceSkinId = 14892; TempChamp.HeadId = 15642;
        TempChamp.Talent = "Desert Shadow"; TempChamp.card1 = "Wanderlust iv"; TempChamp.card2 = "Swagger ii"; TempChamp.card3 = "Run Them Down iv"; TempChamp.card4 = "Mirage i"; TempChamp.card5 = "Run like the Wind i";
        Champion.AddItem(TempChamp);

        // Skye
        TempChamp.name = "skye";
        TempChamp.aliases.RemoveItem("sha");
        TempChamp.BotId = 2057; TempChamp.SkinId = 12207; TempChamp.DeviceSkinId = 13179; TempChamp.HeadId = 15407;
        TempChamp.Talent = "Surprise Attack"; TempChamp.card1 = "Victory Rush iv"; TempChamp.card2 = "Poisoner ii"; TempChamp.card3 = "Ninja iv"; TempChamp.card4 = "Dissipate i"; TempChamp.card5 = "Nimble Fingers i";
        Champion.AddItem(TempChamp);

        // Strix
        TempChamp.name = "strix";
        TempChamp.BotId = 2438; TempChamp.SkinId = 19112; TempChamp.DeviceSkinId = 19136; TempChamp.HeadId = 19642;
        TempChamp.Talent = "Crack Shot"; TempChamp.card1 = "Bushwack iii"; TempChamp.card2 = "Dexterous iii"; TempChamp.card3 = "Tactical Retreat iii"; TempChamp.card4 = "Relentless ii"; TempChamp.card5 = "Cooled Mags i";
        Champion.AddItem(TempChamp);

        // Torvald
        TempChamp.name = "torvald";
        TempChamp.aliases.AddItem("torv");
        TempChamp.BotId = 2322; TempChamp.SkinId = 16485; TempChamp.DeviceSkinId = 15809; TempChamp.HeadId = 16236;
        TempChamp.Talent = "Field Study"; TempChamp.card1 = "Winddancer iii"; TempChamp.card2 = "Glyph of Health ii"; TempChamp.card3 = "Eldritch Speed iv"; TempChamp.card4 = "Timeshaper ii"; TempChamp.card5 = "Scribe's Wit i";
        Champion.AddItem(TempChamp);

        // Tyra
        TempChamp.name = "tyra";
        TempChamp.aliases.RemoveItem("torv");
        TempChamp.BotId = 2314; TempChamp.SkinId = 15822; TempChamp.DeviceSkinId = 15821; TempChamp.HeadId = 16068;
        TempChamp.Talent = "Mercy Kill"; TempChamp.card1 = "Locked and Loaded ii"; TempChamp.card2 = "Bandolier iv"; TempChamp.card3 = "Tracker ii"; TempChamp.card4 = "Ranger i"; TempChamp.card5 = "Incensed iii";
        Champion.AddItem(TempChamp);

        // Viktor
        TempChamp.name = "viktor";
        TempChamp.aliases.AddItem("vik");
        TempChamp.BotId = 2285; TempChamp.SkinId = 14173; TempChamp.DeviceSkinId = 14174; TempChamp.HeadId = 15154;
        TempChamp.Talent = "Cardio"; TempChamp.card1 = "Scramble iv"; TempChamp.card2 = "Compensator ii"; TempChamp.card3 = "Firing Stance iv"; TempChamp.card4 = "Flak Jacket i"; TempChamp.card5 = "Second Wind i";
        Champion.AddItem(TempChamp);

        // Willo
        TempChamp.name = "willo";
        TempChamp.aliases.RemoveItem("vik");
        TempChamp.BotId = 2393; TempChamp.SkinId = 16810; TempChamp.DeviceSkinId = 16811; TempChamp.HeadId = 18307;
        TempChamp.Talent = "Blastflower"; TempChamp.card1 = "Hummingbird i"; TempChamp.card2 = "Flora iv"; TempChamp.card3 = "Just Believe! ii"; TempChamp.card4 = "Flitter iv"; TempChamp.card5 = "Germination i";
        Champion.AddItem(TempChamp);

        // Ying
        TempChamp.name = "ying";
        TempChamp.aliases.AddItem("bestwaifu");
        TempChamp.BotId = 2267; TempChamp.SkinId = 13212; TempChamp.DeviceSkinId = 13221; TempChamp.HeadId = 15418;
        TempChamp.Talent = "Lifelike"; TempChamp.card1 = "Spring Bloom iv"; TempChamp.card2 = "Spring Forward iii"; TempChamp.card3 = "Rewind i"; TempChamp.card4 = "Shuffle iii"; TempChamp.card5 = "Efficiency i";
        Champion.AddItem(TempChamp);

        // Zhin
        TempChamp.name = "zhin";
        TempChamp.aliases.RemoveItem("bestwaifu");
        TempChamp.BotId = 2420; TempChamp.SkinId = 18231; TempChamp.DeviceSkinId = 18300; TempChamp.HeadId = 18232;
        TempChamp.Talent = "Retaliation"; TempChamp.card1 = "Blade Dance ii"; TempChamp.card2 = "Master Stance iv"; TempChamp.card3 = "Perfect Block ii"; TempChamp.card4 = "Hideout ii"; TempChamp.card5 = "Up in Smoke ii";
        Champion.AddItem(TempChamp);

        // Churchill (Vivian)
        TempChamp.name = "churchill";
        TempChamp.aliases.AddItem("vivian");
        TempChamp.BotId = 2478; TempChamp.SkinId = 15810; TempChamp.DeviceSkinId = 16236; TempChamp.HeadId = 14174;
        TempChamp.Talent = ""; TempChamp.card1 = ""; TempChamp.card2 = ""; TempChamp.card3 = "";
        Champion.AddItem(TempChamp);

        // Lazarus (Terminus)
        TempChamp.name = "lazarus";
        TempChamp.aliases.RemoveItem("vivian");
        TempChamp.aliases.AddItem("terminus");
        TempChamp.BotId = 2477; TempChamp.SkinId = 19431; TempChamp.DeviceSkinId = 19434; TempChamp.HeadId = 19750;
        TempChamp.Talent = ""; TempChamp.card1 = ""; TempChamp.card2 = ""; TempChamp.card3 = "";
        Champion.AddItem(TempChamp);

        flag = true; // if this gets touched, the entire thing is fucked, but nobody will be dumb enough to touch it
        SaveConfig();
    }
}