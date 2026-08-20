class UIUtils extends Object
    abstract
    dependson(TgObject);

// Mirrors the spectator health-bar constants so other mods can reuse the same frame mapping.
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

/** Sets text on Parent handling the game's inconsistent TF holder pattern.
 *  Tries Parent.TF -> Parent.Text -> Parent.textField -> Parent.SetText. */
static function bool SetGameText(GFxObject Parent, string Text)
{
    local GFxObject TF;
    if (Parent == none) return false;
    TF = Parent.GetObject("TF");
    if (TF != none) { TF.SetText(Text); return true; }
    TF = Parent.GetObject("Text");
    if (TF != none) { TF.SetText(Text); return true; }
    TF = Parent.GetObject("textField");
    if (TF != none) { TF.SetText(Text); return true; }
    Parent.SetText(Text);
    return true;
}

/** Mirrors text from Src to Dst (Dst.SetText(Src.GetText())) with none guards. */
static function MirrorText(GFxObject Dst, GFxObject Src)
{
    if (Dst == none || Src == none) return;
    Dst.SetText(Src.GetText());
}


// Image / TextureLoader - tgscript.widgets.TextureLoader (Texture256)

/** Loads Url into a CLIK UILoader/TextureLoader. Idempotent: no-ops if _source already Url.
 *  Handles the source/_source/initialSource dance, Invoke("load"), and
 *  contentHolder visibility fixups discovered in the spectator Icon clone. */
static function bool LoadTextureLoader(GFxObject Loader, string Url)
{
    local array<ASValue> Args;
    local ASValue V;

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
    if (Loader.GetObject("contentHolder") != none)
    {
        Loader.GetObject("contentHolder").SetVisible(true);
        Loader.GetObject("contentHolder").SetAlpha(100.0);
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

    HealthN = FCeil(fH * float(NumTicks));
    ShieldN = FCeil(fS * float(NumTicks));
    if (HealthN < 0) HealthN = 0;
    if (ShieldN < 0) ShieldN = 0;
    if (HealthN > NumTicks) HealthN = NumTicks;
    if (HealthN + ShieldN > NumTicks) ShieldN = NumTicks - HealthN;

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

static function SyncShieldText(GFxObject OgGroup, GFxObject Group)
{
    local GFxObject OgST, ClST, OgNow, OgMax, ClNow, ClMax;
    OgST = OgGroup.GetObject("ShieldText");
    ClST = Group.GetObject("ShieldText");
    if (OgST == none || ClST == none) return;
    ClST.SetDisplayInfo(OgST.GetDisplayInfo());
    ClST.SetWidth(OgST.GetWidth());
    ClST.SetHeight(OgST.GetHeight());
    ClST.SetVisible(OgST.GetBool("_visible"));
    ClST.SetAlpha(OgST.GetFloat("_alpha"));
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
    ClCombat.SetDisplayInfo(OgCombat.GetDisplayInfo());
    ClCombat.SetWidth(OgCombat.GetWidth());
    ClCombat.SetHeight(OgCombat.GetHeight());
    ClCombat.SetVisible(OgCombat.GetBool("_visible"));
    ClCombat.SetAlpha(OgCombat.GetFloat("_alpha"));
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
    local GFxObject OgFeed, ClFeed, OgEntry, ClEntry, OgTF;
    local int i;
    local string ChildName;

    if (MaxEntries <= 0) MaxEntries = MAX_HEAL_ENTRIES;

    OgFeed = OgGroup.GetObject("HealFeedContainer");
    ClFeed = Group.GetObject("HealFeedContainer");
    if (OgFeed == none || ClFeed == none) return;

    ClFeed.SetDisplayInfo(OgFeed.GetDisplayInfo());
    ClFeed.SetWidth(OgFeed.GetWidth());
    ClFeed.SetHeight(OgFeed.GetHeight());
    ClFeed.SetVisible(OgFeed.GetBool("_visible"));
    ClFeed.SetAlpha(OgFeed.GetFloat("_alpha"));

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
        ClEntry.SetDisplayInfo(OgEntry.GetDisplayInfo());
        ClEntry.SetWidth(OgEntry.GetWidth());
        ClEntry.SetHeight(OgEntry.GetHeight());
        ClEntry.SetX(OgEntry.GetX());
        ClEntry.SetY(OgEntry.GetY());
        ClEntry.SetVisible(OgEntry.GetBool("_visible"));
        ClEntry.SetAlpha(OgEntry.GetFloat("_alpha"));
        ClEntry.SetText(OgEntry.GetText());
        OgTF = OgEntry.GetObject("TF");
        if (OgTF != none && ClEntry.GetObject("TF") != none)
            ClEntry.GetObject("TF").SetText(OgTF.GetText());
        else if (OgEntry.GetObject("Text") != none && ClEntry.GetObject("Text") != none)
            ClEntry.GetObject("Text").SetText(OgEntry.GetObject("Text").GetText());
    }
    if (OgFeed.GetText() != "" || ClFeed.GetText() != "")
        ClFeed.SetText(OgFeed.GetText());
}
