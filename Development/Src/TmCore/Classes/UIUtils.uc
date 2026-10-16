class UIUtils extends Object
    abstract
    dependson(TgObject);

// Health-bar frames shared with other mods.
const HEALTH_FRAME_SHIELD = 5;
const HEALTH_FRAME_SHADOW = 6;
const MAX_FILL_TICKS      = 100;
const MAX_HEAL_ENTRIES    = 12;

/** Copies DisplayInfo + Width/Height from SrcParent.GetObject(Name) to DstParent.GetObject(Name). */
static function MirrorClip(GFxObject DstParent, GFxObject SrcParent, string ClipName)
{
    local GFxObject Src, Dst;
    Src = SrcParent.GetObject(ClipName);
    Dst = DstParent.GetObject(ClipName);
    if (Src == none || Dst == none) return;
    Dst.SetDisplayInfo(Src.GetDisplayInfo());
    Dst.SetWidth(Src.GetWidth());
    Dst.SetHeight(Src.GetHeight());
}

/** SetText on the first existing text holder: Parent.TF -> Text -> textField -> SetText. */
static function bool SetGameText(GFxObject Parent, coerce string Text)
{
    local GFxObject TF;
    local string Names[3];
    local int i;

    if (Parent == none) return false;
    Names[0] = "TF";
    Names[1] = "Text";
    Names[2] = "textField";
    for (i = 0; i < 3; i++)
    {
        TF = Parent.GetObject(Names[i]);
        if (TF != none) { TF.SetText(Text); return true; }
    }
    Parent.SetText(Text);
    return true;
}

/** Dst.SetText(Src.GetText()) with none guards. */
static function MirrorText(GFxObject Dst, GFxObject Src)
{
    if (Dst == none || Src == none) return;
    Dst.SetText(Src.GetText());
}

// TextureLoader (tgscript.widgets.TextureLoader)

/** Loads Url into a CLIK UILoader/TextureLoader; no-ops if _source already Url. */
static function bool LoadTextureLoader(GFxObject Loader, string Url)
{
    local array<ASValue> Args;
    local ASValue V;
    local GFxObject Holder;

    if (Loader == none) return false;
    if (Url == "" || Url == "undefined") return false;

    if (Loader.GetString("_source") != Url)
    {
        Loader.SetString("_source", "");
        Loader.SetString("source", Url);
        V.Type = AS_String;
        V.S = Url;
        Args.AddItem(V);
        Loader.Invoke("load", Args);
    }
    Loader.SetVisible(true);
    Loader.SetBool("_visible", true);
    Loader.SetBool("visible", true);
    Loader.SetFloat("_alpha", 100.0);
    Loader.SetAlpha(100.0);
    Holder = Loader.GetObject("contentHolder");
    if (Holder != none)
    {
        Holder.SetVisible(true);
        Holder.SetAlpha(100.0);
    }
    return true;
}

static function bool SyncIcon(GFxObject CloneIcon, GFxObject OrigIcon)
{
    local string Url;
    if (CloneIcon == none || OrigIcon == none) return false;
    Url = OrigIcon.GetString("initialSource");
    if (Url == "" || Url == "undefined") return false;
    return LoadTextureLoader(CloneIcon, Url);
}

static function int FindBurnIconFrameByDeviceId(TgGfxScene DataSource, int DeviceId)
{
    local UIDataManager DM;
    local int i;
    if (DataSource == none || DeviceId == 0 || DataSource.m_pUIData == none) return 0;
    DM = DataSource.m_pUIData;
    if (DM.m_CommonData == none) return 0;
    for (i = 0; i < DM.m_CommonData.m_BurnAll.Length; i++)
        if (DM.m_CommonData.m_BurnAll[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnAll[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnA.Length; i++)
        if (DM.m_CommonData.m_BurnA[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnA[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnB.Length; i++)
        if (DM.m_CommonData.m_BurnB[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnB[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnC.Length; i++)
        if (DM.m_CommonData.m_BurnC[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnC[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnD.Length; i++)
        if (DM.m_CommonData.m_BurnD[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnD[i].m_nIcon;
    return 0;
}

static function GetSpectatedBurnIds(TgRepInfo_Player ViewPRI, TgPawn ViewPawn, out int DeviceIds[4], out int Powers[4])
{
    local int i, eq;
    local TgDevice Dev;
    for (i = 0; i < 4; i++)
    {
        eq = 8 + i;
        DeviceIds[i] = 0;
        Powers[i] = 0;
        if (ViewPRI != none)
        {
            DeviceIds[i] = ViewPRI.r_PlayerDevices[eq].CurrentDeviceId;
            Powers[i] = ViewPRI.r_PlayerDevices[eq].Power;

            if (DeviceIds[i] != 0 && Powers[i] == 0)
                Powers[i] = ViewPRI.r_PlayerDevices[eq].CurrentDeviceCount;
            if (DeviceIds[i] != 0 && Powers[i] == 0) Powers[i] = 1;
        }

        if (DeviceIds[i] == 0 && ViewPawn != none)
        {
            Dev = ViewPawn.GetDeviceByEqPoint(eq);
            if (Dev != none)
            {
                DeviceIds[i] = Dev.r_nDeviceId;
                if (Powers[i] == 0 && DeviceIds[i] != 0) Powers[i] = 1;
            }
        }
    }
}

static function bool SyncBurnsToScene(UIHudCards CardsHUD, UIHudBurns BurnHUD, int DeviceIds[4], int Powers[4])
{
    local int i, Frame;
    local GFxObject IconObj, PowerLevel, Obj;
    local TgGfxScene DataSource;
    if (CardsHUD == none) return false;
    DataSource = BurnHUD != none ? BurnHUD : CardsHUD;
    for (i = 0; i < 4; i++)
    {
        IconObj = CardsHUD.m_CardDisplayGroup.Items[i].Icon;
        Obj = CardsHUD.m_CardDisplayGroup.Items[i].Obj;
        if (IconObj == none) continue;
        if (DeviceIds[i] == 0)
        {
            CardsHUD.FadeOut(IconObj, 0.05);
            if (Obj != none) CardsHUD.FadeOut(Obj, 0.05);
            continue;
        }

        Frame = FindBurnIconFrameByDeviceId(DataSource, DeviceIds[i]);
        if (Frame == 0 && DataSource != CardsHUD)
            Frame = FindBurnIconFrameByDeviceId(CardsHUD, DeviceIds[i]);
        if (Frame > 0)
        {
            CardsHUD.CancelAnim(IconObj);
            IconObj.GotoAndStopI(Frame);
            CardsHUD.FadeIn(IconObj, 0.05);
            if (Obj != none) { CardsHUD.CancelAnim(Obj); CardsHUD.FadeIn(Obj, 0.05); }
        }
        PowerLevel = CardsHUD.m_CardDisplayGroup.Items[i].PowerLevel;
        if (PowerLevel != none && Powers[i] > 0)
            PowerLevel.GotoAndStopI(Powers[i]);
    }
    return true;
}

static function BuildFillTicks(UIComponent_HealthBar Bar, GFxObject Container, int TeamColor, out int LastCount)
{
    local GFxObject Tick;
    local int i;

    if (Bar == none || Container == none) return;
    if (LastCount == Bar.m_mcHealthBarTicks.Length) return;

    for (i = 0; i < MAX_FILL_TICKS; i++)
    {
        Tick = Container.GetObject("HealthTick" $ i);
        if (Tick != none) Tick.RemoveMovieClip("");
    }
    for (i = 0; i < Bar.m_mcHealthBarTicks.Length; i++)
    {
        Tick = Container.AttachMovie("HealthTick", "HealthTick" $ i);
        Tick.SetDisplayInfo(Bar.m_mcHealthBarTicks[i].GetDisplayInfo());
        Tick.SetWidth(Bar.m_mcHealthBarTicks[i].GetWidth());
        Tick.SetHeight(Bar.m_mcHealthBarTicks[i].GetHeight());
        Tick.SetX(Bar.m_mcHealthBarTicks[i].GetX());
        Tick.GotoAndStopI(TeamColor);
    }
    LastCount = Bar.m_mcHealthBarTicks.Length;
}

static function BuildBorderTicks(UIComponent_HealthBar Bar, GFxObject Group, int TeamColor, out int bBuilt)
{
    local BarTickTypes BT;
    local int i;

    if (bBuilt != 0) return;
    if (Bar == none || Group == none) return;

    for (i = 0; i < Bar.m_BarTickTypes.Length; i++)
    {
        BT = Bar.m_BarTickTypes[i];
        if (BT.eBorderTickType == EHTT_Damage) continue;
        if (i != 0 && BT.mcLeftBorderTick != none)
            CreateBorderTick(Group, BT, BT.mcLeftBorderTick, "BorderTickL" $ i, 0, TeamColor);
        if (i != Bar.m_BarTickTypes.Length - 1 && BT.mcRightBorderTick != none)
            CreateBorderTick(Group, BT, BT.mcRightBorderTick, "BorderTickR" $ i, 1, TeamColor);
    }
    bBuilt = 1;
}

static function CreateBorderTick(GFxObject Group, BarTickTypes BT, GFxObject Src, string InstName, int Depth, int TeamColor)
{
    local GFxObject Tick;
    local int FrameTo;

    Tick = Group.GetObject(BT.sContainerName).AttachMovie("HealthTick", InstName, Depth);
    if (Tick == none) return;

    Tick.SetDisplayInfo(Src.GetDisplayInfo());
    Tick.SetWidth(Src.GetWidth());
    Tick.SetHeight(Src.GetHeight());

    if (BT.eBorderTickType == EHTT_Health) FrameTo = TeamColor;
    else if (BT.eBorderTickType == EHTT_Shield) FrameTo = HEALTH_FRAME_SHIELD;
    else FrameTo = HEALTH_FRAME_SHADOW;
    Tick.GotoAndStopI(FrameTo);
    Tick.SetVisible(true);
}

static function MirrorBarMasks(UIComponent_HealthBar Bar, GFxObject OgGroup, GFxObject Group)
{
    local BarTickTypes BT;
    local GFxObject OgMask, ClMask;
    local int i;

    if (Bar == none || OgGroup == none || Group == none) return;

    for (i = 0; i < Bar.m_BarTickTypes.Length; i++)
    {
        BT = Bar.m_BarTickTypes[i];
        OgMask = OgGroup.GetObject(BT.sMaskName);
        ClMask = Group.GetObject(BT.sMaskName);
        if (OgMask != none && ClMask != none)
        {
            ClMask.SetX(OgMask.GetX());
            ClMask.SetWidth(OgMask.GetWidth());
            ClMask.SetVisible(OgMask.GetBool("_visible"));
        }
    }
}

static function RecolorHealthTicks(UIComponent_HealthBar Bar, GFxObject Container, int TeamColor)
{
    local int NumTicks, HealthN, ShieldN, k;
    local float fH, fS;
    local GFxObject Tick;
    local BarTickTypes BT2;

    if (Bar == none || Container == none) return;
    NumTicks = Bar.m_mcHealthBarTicks.Length;
    if (NumTicks <= 0) return;

    fH = 0.0; fS = 0.0;
    for (k = 0; k < Bar.m_BarTickTypes.Length; k++)
    {
        BT2 = Bar.m_BarTickTypes[k];
        if (BT2.eBorderTickType == EHTT_Health) fH = BT2.fWidth;
        else if (BT2.eBorderTickType == EHTT_Shield) fS = BT2.fWidth;
    }

    HealthN = Clamp(FCeil(fH * float(NumTicks)), 0, NumTicks);
    ShieldN = Clamp(FCeil(fS * float(NumTicks)), 0, NumTicks - HealthN);

    for (k = 0; k < NumTicks; k++)
    {
        Tick = Container.GetObject("HealthTick" $ k);
        if (Tick == none) continue;
        if (k < HealthN) Tick.GotoAndStopI(TeamColor);
        else if (k < HealthN + ShieldN) Tick.GotoAndStopI(HEALTH_FRAME_SHIELD);
        else Tick.GotoAndStopI(HEALTH_FRAME_SHADOW);
        Tick.SetVisible(true);
    }
}

/** Copies display info, size, visibility and alpha from Src to Dst. */
static function MirrorVisual(GFxObject Dst, GFxObject Src)
{
    Dst.SetDisplayInfo(Src.GetDisplayInfo());
    Dst.SetWidth(Src.GetWidth());
    Dst.SetHeight(Src.GetHeight());
    Dst.SetVisible(Src.GetBool("_visible"));
    Dst.SetAlpha(Src.GetFloat("_alpha"));
}

static function SyncShieldText(GFxObject OgGroup, GFxObject Group)
{
    local GFxObject OgST, ClST, OgNow, OgMax, ClNow, ClMax;
    OgST = OgGroup.GetObject("ShieldText");
    ClST = Group.GetObject("ShieldText");
    if (OgST == none || ClST == none) return;
    MirrorVisual(ClST, OgST);
    OgNow = OgST.GetObject("ShieldNow");
    OgMax = OgST.GetObject("ShieldMax");
    ClNow = ClST.GetObject("ShieldNow");
    ClMax = ClST.GetObject("ShieldMax");
    if (OgNow != none && ClNow != none)
    {
        ClNow.SetText(OgNow.GetText());
        ClNow.SetVisible(OgNow.GetBool("_visible"));
        ClNow.SetAlpha(OgNow.GetFloat("_alpha"));
    }
    if (OgMax != none && ClMax != none)
    {
        ClMax.SetText(OgMax.GetText());
        ClMax.SetVisible(OgMax.GetBool("_visible"));
        ClMax.SetAlpha(OgMax.GetFloat("_alpha"));
    }
}

static function SyncCombat(GFxObject OgGroup, GFxObject Group)
{
    local GFxObject OgCombat, ClCombat, OgBar, ClBar;
    OgCombat = OgGroup.GetObject("Combat");
    ClCombat = Group.GetObject("Combat");
    if (OgCombat == none || ClCombat == none) return;
    MirrorVisual(ClCombat, OgCombat);
    OgBar = OgCombat.GetObject("Bar");
    ClBar = ClCombat.GetObject("Bar");
    if (OgBar != none && ClBar != none)
    {
        ClBar.SetDisplayInfo(OgBar.GetDisplayInfo());
        ClBar.SetWidth(OgBar.GetWidth());
        ClBar.SetHeight(OgBar.GetHeight());
        ClBar.SetX(OgBar.GetX());
        ClBar.SetVisible(OgBar.GetBool("_visible"));
        ClBar.SetAlpha(OgBar.GetFloat("_alpha"));
    }
}

static function SyncHealFeedContainer(GFxObject OgGroup, GFxObject Group, optional int MaxEntries)
{
    local GFxObject OgFeed, ClFeed, OgEntry, ClEntry, OgTF, ClTF;
    local int i;
    local string ChildName;

    if (MaxEntries <= 0) MaxEntries = MAX_HEAL_ENTRIES;

    OgFeed = OgGroup.GetObject("HealFeedContainer");
    ClFeed = Group.GetObject("HealFeedContainer");
    if (OgFeed == none || ClFeed == none) return;

    MirrorVisual(ClFeed, OgFeed);

    for (i = 0; i < MaxEntries; i++)
    {
        ChildName = "Entry" $ i;
        OgEntry = OgFeed.GetObject(ChildName);
        if (OgEntry == none) OgEntry = OgFeed.GetObject("HealEntry" $ i);
        if (OgEntry == none) OgEntry = OgFeed.GetObject("HealFeedItem" $ i);
        if (OgEntry == none) OgEntry = OgFeed.GetObject("Item" $ i);
        if (OgEntry == none) OgEntry = OgFeed.GetElementObject(i);
        if (OgEntry == none) continue;

        ClEntry = ClFeed.GetObject(ChildName);
        if (ClEntry == none)
        {
            ClEntry = ClFeed.AttachMovie("HealFeedItem", ChildName, i);
            if (ClEntry == none) ClEntry = ClFeed.AttachMovie("HealEntry", ChildName, i);
            if (ClEntry == none) ClEntry = ClFeed.AttachMovie("Entry", ChildName, i);
            if (ClEntry == none) continue;
        }
        MirrorVisual(ClEntry, OgEntry);
        ClEntry.SetX(OgEntry.GetX());
        ClEntry.SetY(OgEntry.GetY());
        ClEntry.SetText(OgEntry.GetText());
        OgTF = OgEntry.GetObject("TF");
        ChildName = "TF";
        if (OgTF == none) { OgTF = OgEntry.GetObject("Text"); ChildName = "Text"; }
        if (OgTF != none)
        {
            ClTF = ClEntry.GetObject(ChildName);
            if (ClTF != none) ClTF.SetText(OgTF.GetText());
        }
    }
    if (OgFeed.GetText() != "" || ClFeed.GetText() != "")
        ClFeed.SetText(OgFeed.GetText());
}
