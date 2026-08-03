class MobileMenuBar extends MobileMenuObject;

var(DefaultInit) bool bIsVertical;
var bool bDirty;
var(DefaultInit) int SelectedIndex;
var int FirstItem;
var array<MobileMenuBarItem> Items;

function InitMenuObject(MobilePlayerInput PlayerInput, MobileMenuScene Scene, int ScreenWidth, int ScreenHeight, bool bIsFirstInitialization)
{
    super.InitMenuObject(PlayerInput, Scene, ScreenWidth, ScreenHeight, bIsFirstInitialization);
    UpdateItemViewports();
    //return;    
}

function AddItem(MobileMenuBarItem Item, optional int Index = -1)
{
    // End:0x3A
    if(Index < 0)
    {
        Index = Items.Length + (Index + 1);
    }
    Items.InsertItem(Index, Item);
    bDirty = true;
    //return;    
}

function int Num()
{
    return Items.Length;
    //return ReturnValue;    
}

function MobileMenuBarItem GetSelected()
{
    // End:0x3D
    if((SelectedIndex >= 0) && SelectedIndex < Items.Length)
    {
        return Items[SelectedIndex];
    }
    return none;
    //return ReturnValue;    
}

event bool OnTouch(Interaction.ETouchType EventType, float TouchX, float TouchY, MobileMenuObject ObjectOver, float DeltaTime)
{
    // End:0xA9
    if(bIsVertical)
    {
        TouchY -= Top;
        SelectedIndex = FirstItem;
        J0x34:

        // End:0xA6 [Loop If]
        if(SelectedIndex < (Items.Length - 1))
        {
            TouchY -= float(Items[SelectedIndex].Height);
            // End:0x98
            if(TouchY <= float(0))
            {
                // [Explicit Break]
                goto J0xA6;
            }
            SelectedIndex++;
            // [Loop Continue]
            goto J0x34;
        }
        J0xA6:
        
    }
    else
    {
        TouchX -= Left;
        SelectedIndex = 0;
        J0xC8:

        // End:0x13A [Loop If]
        if(SelectedIndex < (Items.Length - 1))
        {
            TouchX -= float(Items[SelectedIndex].Width);
            // End:0x12C
            if(TouchX <= float(0))
            {
                // [Explicit Break]
                goto J0x13A;
            }
            SelectedIndex++;
            // [Loop Continue]
            goto J0xC8;
        }
    }
    J0x13A:

    return true;
    //return ReturnValue;    
}

function RenderObject(Canvas Canvas, float DeltaTime)
{
    local float OrgX, OrgY;
    local int CurIndex;

    // End:0x17
    if(bDirty)
    {
        UpdateItemViewports();
    }
    OrgX = Canvas.OrgX;
    OrgY = Canvas.OrgY;
    Canvas.SetOrigin(Left, Top);
    CurIndex = 0;
    J0xA3:

    // End:0xEE [Loop If]
    if(CurIndex < Items.Length)
    {
        RenderItem(Canvas, DeltaTime, CurIndex);
        CurIndex++;
        // [Loop Continue]
        goto J0xA3;
    }
    Canvas.OrgX = OrgX;
    Canvas.OrgY = OrgY;
    //return;    
}

function RenderItem(Canvas Canvas, float DeltaTime, int ItemIndex)
{
    Items[ItemIndex].RenderItem(self, Canvas, DeltaTime);
    //return;    
}

function SetFirstItem(int first)
{
    FirstItem = first;
    bDirty = true;
    //return;    
}

function UpdateItemViewports()
{
    local MobileMenuBarItem Item;
    local float pos;
    local int CurIndex;

    pos = 0.0000000;
    Width = 0.0000000;
    Height = 0.0000000;
    // End:0x1E6
    if(bIsVertical)
    {
        CurIndex = FirstItem;
        J0x4D:

        // End:0xF0 [Loop If]
        if(CurIndex < Items.Length)
        {
            Item = Items[CurIndex];
            Width = FMax(Width, float(Item.Width));
            Height += float(Item.Height);
            CurIndex++;
            // [Loop Continue]
            goto J0x4D;
        }
        CurIndex = FirstItem;
        J0x103:

        // End:0x1E3 [Loop If]
        if(CurIndex < Items.Length)
        {
            Item = Items[CurIndex];
            Item.VpPos.X = 0.0000000;
            Item.VpPos.Y = pos;
            pos += float(Item.Height);
            CurIndex++;
            // [Loop Continue]
            goto J0x103;
        }        
    }
    else
    {
        CurIndex = FirstItem;
        J0x1F9:

        // End:0x29C [Loop If]
        if(CurIndex < Items.Length)
        {
            Item = Items[CurIndex];
            Width += float(Item.Width);
            Height = FMax(Height, float(Item.Height));
            CurIndex++;
            // [Loop Continue]
            goto J0x1F9;
        }
        CurIndex = FirstItem;
        J0x2AF:

        // End:0x38F [Loop If]
        if(CurIndex < Items.Length)
        {
            Item = Items[CurIndex];
            Item.VpPos.X = pos;
            Item.VpPos.Y = 0.0000000;
            pos += float(Item.Width);
            CurIndex++;
            // [Loop Continue]
            goto J0x2AF;
        }
    }
    bDirty = false;
    //return;    
}

defaultproperties
{
    bIsVertical=true
    bIsActive=true
}