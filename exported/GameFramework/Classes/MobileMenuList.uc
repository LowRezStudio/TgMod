class MobileMenuList extends MobileMenuObject;

const NumInDragHistory = 4;

struct SelectedMenuItem
{
    var int Index;
    var float Offset;
    var bool bEndOfList;

    structdefaultproperties
    {
        Index=0
        Offset=0.0000000
        bEndOfList=false
    }
};

struct DragHistoryData
{
    var float TouchTime;
    var float TouchCoord;

    structdefaultproperties
    {
        TouchTime=0.0000000
        TouchCoord=0.0000000
    }
};

struct MenuListDragInfo
{
    var bool bIsDragging;
    var MobileMenuListItem TouchedItem;
    var SelectedMenuItem OrigSelectedItem;
    var Vector2D StartTouch;
    var float TouchTime;
    var float ScrollAmount;
    var float AbsScrollAmount;
    var DragHistoryData UpdateHistory[4];
    var int NumUpdates;
    var bool bHasSelectedChanged;

    structdefaultproperties
    {
        bIsDragging=false
        TouchedItem=none
        OrigSelectedItem=(Index=0,Offset=0.0000000,bEndOfList=false)
        StartTouch=(X=0.0000000,Y=0.0000000)
        TouchTime=0.0000000
        ScrollAmount=0.0000000
        AbsScrollAmount=0.0000000
        UpdateHistory[0]=(TouchTime=0.0000000,TouchCoord=0.0000000)
        UpdateHistory[1]=(TouchTime=0.0000000,TouchCoord=0.0000000)
        UpdateHistory[2]=(TouchTime=0.0000000,TouchCoord=0.0000000)
        UpdateHistory[3]=(TouchTime=0.0000000,TouchCoord=0.0000000)
        NumUpdates=0
        bHasSelectedChanged=false
    }
};

struct MenuListMovementInfo
{
    var bool bIsMoving;
    var SelectedMenuItem OrigSelectedItem;
    var float FullMovement;
    var float TotalTime;
    var float CurrentTime;

    structdefaultproperties
    {
        bIsMoving=false
        OrigSelectedItem=(Index=0,Offset=0.0000000,bEndOfList=false)
        FullMovement=0.0000000
        TotalTime=0.0000000
        CurrentTime=0.0000000
    }
};

var(DefaultInit) bool bIsVerticalList;
var(DefaultInit) bool bDisableScrolling;
var(DefaultInit) bool bForceSelectedToLineup;
var bool bTapToScrollToItem;
var bool bLoops;
var(DefaultInit) float SelectedOffset;
var array<MobileMenuListItem> Items;
var SelectedMenuItem SelectedItem;
var MenuListDragInfo Drag;
var MenuListMovementInfo Movement;
var float Deacceleration;
var float EaseOutExp;
var IntPoint ScreenSize;
var int FirstVisible;
var int LastVisible;
var int NumShowEndOfList;
var float EndOfListSupression;

function InitMenuObject(MobilePlayerInput PlayerInput, MobileMenuScene Scene, int ScreenWidth, int ScreenHeight, bool bIsFirstInitialization)
{
    ScreenSize.X = ScreenWidth;
    ScreenSize.Y = ScreenHeight;
    super.InitMenuObject(PlayerInput, Scene, ScreenWidth, ScreenHeight, bIsFirstInitialization);
    SelectedOffset *= ((bIsVerticalList) ? Height : Width);
    //return;    
}

function AddItem(MobileMenuListItem Item, optional int Index = -1)
{
    // End:0x3A
    if(Index < 0)
    {
        Index = Items.Length + (Index + 1);
    }
    Items.InsertItem(Index, Item);
    //return;    
}

function int Num()
{
    return Items.Length;
    //return ReturnValue;    
}

function MobileMenuListItem GetSelected()
{
    local MobileMenuListItem Item;

    // End:0xC9
    if((SelectedItem.Index >= 0) && SelectedItem.Index < Items.Length)
    {
        Item = Items[SelectedItem.Index];
        // End:0xBF
        if((Item != none) && !Item.bIsVisible)
        {
            Item = none;
        }
        return Item;
    }
    return none;
    //return ReturnValue;    
}

function float GetAmountSelected(MobileMenuListItem Item)
{
    local MobileMenuListItem Selected;
    local float Half;

    Selected = GetSelected();
    // End:0xC6
    if(Item == Selected)
    {
        Half = ((bIsVerticalList) ? Item.Height : Item.Width) * 0.5000000;
        return FMax(0.0001000, FMin(1.0000000, 1.0000000 - (Abs(SelectedItem.Offset) / Half)));
    }
    return 0.0000000;
    //return ReturnValue;    
}

function int GetVisibleIndexOfSelected()
{
    local MobileMenuListItem Item, Selected;
    local int Index;

    Selected = GetSelected();
    Index = 0;
    // End:0x86
    foreach Items(Item)
    {
        // End:0x58
        if(Item == Selected)
        {            
            return Index;
        }
        // End:0x85
        if(Item.bIsVisible)
        {
            Index++;
        }        
    }    
    return -1;
    //return ReturnValue;    
}

function int SetSelectedToVisibleIndex(int VisibleIndex)
{
    local int Index;

    Index = 0;
    J0x0B:

    // End:0xA7 [Loop If]
    if(Index < Items.Length)
    {
        // End:0x99
        if(Items[Index].bIsVisible)
        {
            // End:0x8E
            if(VisibleIndex <= 0)
            {
                SelectedItem.Index = Index;
                return Index;
            }
            VisibleIndex--;
        }
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    SelectedItem.Index = -1;
    return -1;
    //return ReturnValue;    
}

function int GetNumVisible()
{
    local int Index, Count;

    Index = 0;
    J0x0B:

    // End:0x68 [Loop If]
    if(Index < Items.Length)
    {
        // End:0x5A
        if(Items[Index].bIsVisible)
        {
            Count++;
        }
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    return Count;
    //return ReturnValue;    
}

function bool SetSelectedItem(int ItemIndex, optional bool bForceAll = false)
{
    // End:0xDB
    if((ItemIndex >= 0) && ItemIndex < Items.Length)
    {
        // End:0xDB
        if(Items[ItemIndex].bIsVisible)
        {
            SelectedItem.Index = ItemIndex;
            // End:0xD9
            if(bForceAll)
            {
                Drag.OrigSelectedItem = SelectedItem;
                Movement.OrigSelectedItem = SelectedItem;
            }
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

event bool OnTouch(Interaction.ETouchType EventType, float TouchX, float TouchY, MobileMenuObject ObjectOver, float DeltaTime)
{
    local float Velocity, SwipeDelta, FinalScrollDist, CalcScrollDist, SwipeTime;

    local MobileMenuListItem Selected;
    local int Index, Index0;
    local bool bUdpateTouchItem;

    TouchX -= Left;
    TouchY -= Top;
    Drag.TouchTime += DeltaTime;
    // End:0x318
    if(int(EventType) == int(0))
    {
        Movement.bIsMoving = false;
        Drag.bIsDragging = true;
        Drag.OrigSelectedItem = SelectedItem;
        Drag.StartTouch.X = TouchX;
        Drag.StartTouch.Y = TouchY;
        Drag.ScrollAmount = 0.0000000;
        Drag.AbsScrollAmount = 0.0000000;
        Drag.bHasSelectedChanged = false;
        Drag.TouchTime = 0.0000000;
        Drag.NumUpdates = 0;
        Index = 0;
        J0x1E7:

        // End:0x244 [Loop If]
        if(Index < 4)
        {
            Drag.UpdateHistory[Index].TouchTime = 0.0000000;
            Index++;
            // [Loop Continue]
            goto J0x1E7;
        }
        Drag.TouchedItem = GetItemClickPosition(TouchX, TouchY);
        // End:0x315
        if(Drag.TouchedItem != none)
        {
            Drag.bIsDragging = !Drag.TouchedItem.OnTouch(EventType, TouchX, TouchY, DeltaTime);
        }        
    }
    else
    {
        // End:0x349
        if(!Drag.bIsDragging)
        {
            bUdpateTouchItem = true;            
        }
        else
        {
            // End:0x8FA
            if((int(EventType) == int(3)) || int(EventType) == int(4))
            {
                bUdpateTouchItem = true;
                Drag.bIsDragging = false;
                Movement.bIsMoving = true;
                Movement.CurrentTime = 0.0000000;
                Movement.OrigSelectedItem = SelectedItem;
                // End:0x589
                if((!Drag.bHasSelectedChanged && Drag.StartTouch.X == TouchX) && Drag.StartTouch.Y == TouchY)
                {
                    Selected = GetSelected();
                    // End:0x586
                    if((Drag.TouchTime > 0.0500000) && bTapToScrollToItem)
                    {
                        // End:0x542
                        if(bIsVerticalList)
                        {
                            FinalScrollDist = TouchY - (SelectedOffset + (Selected.Height / float(2)));                            
                        }
                        else
                        {
                            FinalScrollDist = TouchX - (SelectedOffset + (Selected.Width / float(2)));
                        }
                    }                    
                }
                else
                {
                    // End:0x780
                    if(Drag.NumUpdates >= 2)
                    {
                        Index = (Drag.NumUpdates - 1) % 4;
                        Index0 = (Drag.NumUpdates - Min(Drag.NumUpdates, 4)) % 4;
                        SwipeDelta = -Drag.UpdateHistory[Index].TouchCoord - Drag.UpdateHistory[Index0].TouchCoord;
                        SwipeTime = Drag.UpdateHistory[Index].TouchTime - Drag.UpdateHistory[Index0].TouchTime;
                        Velocity = ((SwipeTime > float(0)) ? SwipeDelta / SwipeTime : 0.0000000);
                        FinalScrollDist = Square(Velocity) / (2.0000000 * Deacceleration);
                    }
                }
                // End:0x79C
                if(bDisableScrolling)
                {
                    FinalScrollDist = 0.0000000;
                }
                // End:0x7D9
                if(SwipeDelta < float(0))
                {
                    CalcScrollDist = CalculateSelectedItem(SelectedItem, -FinalScrollDist, true);                    
                }
                else
                {
                    CalcScrollDist = CalculateSelectedItem(SelectedItem, FinalScrollDist, true);
                }
                // End:0x86F
                if(!bForceSelectedToLineup && !SelectedItem.bEndOfList)
                {
                    // End:0x85C
                    if(SwipeDelta < float(0))
                    {
                        CalcScrollDist = -FinalScrollDist;                        
                    }
                    else
                    {
                        CalcScrollDist = FinalScrollDist;
                    }
                }
                SelectedItem = Movement.OrigSelectedItem;
                Movement.TotalTime = Sqrt(Abs(CalcScrollDist) / (2.0000000 * Deacceleration));
                Movement.FullMovement = CalcScrollDist;                
            }
            else
            {
                Drag.UpdateHistory[Drag.NumUpdates % 4].TouchTime = Drag.TouchTime;
                Drag.UpdateHistory[Drag.NumUpdates % 4].TouchCoord = ((bIsVerticalList) ? TouchY : TouchX);
                Drag.NumUpdates++;
                // End:0xA66
                if(Drag.OrigSelectedItem.Index != SelectedItem.Index)
                {
                    Drag.bHasSelectedChanged = true;
                }
                Drag.ScrollAmount = ((bIsVerticalList) ? Drag.StartTouch.Y - TouchY : Drag.StartTouch.X - TouchX);
                Index = (Drag.NumUpdates - 1) % 4;
                Index0 = (Drag.NumUpdates - Min(Drag.NumUpdates, 4)) % 4;
                SwipeDelta = Abs(Drag.UpdateHistory[Index].TouchCoord - Drag.UpdateHistory[Index0].TouchCoord);
                // End:0xC3D
                if(bDisableScrolling)
                {
                    Drag.ScrollAmount = 0.0000000;
                    SwipeDelta = 0.0000000;
                }
                Drag.AbsScrollAmount += SwipeDelta;
            }
        }
    }
    // End:0xD77
    if(bUdpateTouchItem)
    {
        // End:0xD77
        if(Drag.TouchedItem != none)
        {
            // End:0xD29
            if(Drag.TouchedItem == (GetItemClickPosition(TouchX, TouchY)))
            {
                Drag.TouchedItem.OnTouch(EventType, TouchX, TouchY, DeltaTime);                
            }
            else
            {
                Drag.TouchedItem.OnTouch(EventType, -1.0000000, -1.0000000, DeltaTime);
            }
        }
    }
    return true;
    //return ReturnValue;    
}

function MobileMenuListItem GetItemClickPosition(out float MouseX, out float MouseY)
{
    local int ScrollAmount, CurIndex, ScrollSize;
    local MobileMenuListItem Item;

    ScrollAmount = int(((bIsVerticalList) ? MouseY : MouseX));
    ScrollAmount -= int(SelectedOffset);
    CurIndex = int(FMax(0.0000000, float(SelectedItem.Index)));
    // End:0x8E
    if(CurIndex >= Items.Length)
    {
        return none;
    }
    Item = Items[CurIndex];
    ScrollSize = ItemScrollSize(Item);
    J0xC8:

    // End:0x191 [Loop If]
    if(ScrollAmount < 0)
    {
        // End:0xF4
        if(CurIndex > 0)
        {
            CurIndex--;            
        }
        else
        {
            // End:0x11B
            if(bLoops)
            {
                CurIndex = Items.Length - 1;                
            }
            else
            {
                // [Explicit Break]
                goto J0x191;
            }
        }
        Item = Items[CurIndex];
        // End:0x18E
        if(Item.bIsVisible)
        {
            ScrollSize = ItemScrollSize(Item);
            ScrollAmount += ScrollSize;
        }
        // [Loop Continue]
        goto J0xC8;
    }
    J0x191:

    // End:0x262 [Loop If]
    if(ScrollAmount > ScrollSize)
    {
        // End:0x1D1
        if(CurIndex < (Items.Length - 1))
        {
            CurIndex++;            
        }
        else
        {
            // End:0x1EC
            if(bLoops)
            {
                CurIndex = 0;                
            }
            else
            {
                // [Explicit Break]
                goto J0x262;
            }
        }
        Item = Items[CurIndex];
        // End:0x25F
        if(Item.bIsVisible)
        {
            ScrollAmount -= ScrollSize;
            ScrollSize = ItemScrollSize(Item);
        }
        // [Loop Continue]
        goto J0x191;
    }
    J0x262:

    // End:0x2D1
    if(bIsVerticalList)
    {
        MouseY = float(ScrollAmount);
        // End:0x2CE
        if((ScrollAmount < 0) || float(ScrollAmount) > Item.Height)
        {
            Item = none;
        }        
    }
    else
    {
        MouseX = float(ScrollAmount);
        // End:0x330
        if((ScrollAmount < 0) || float(ScrollAmount) > Item.Width)
        {
            Item = none;
        }
    }
    return Item;
    //return ReturnValue;    
}

function float CalculateSelectedItem(out SelectedMenuItem Selected, float ScrollAmount, bool bForceZeroAdjustment)
{
    local float AdjustValue, ScrollSize, Scrolled, HalfScroll;
    local int CurIndex;
    local MobileMenuListItem Item;

    AdjustValue = Selected.Offset;
    Scrolled = AdjustValue;
    ScrollAmount -= AdjustValue;
    CurIndex = int(FMax(0.0000000, float(Selected.Index)));
    // End:0x9C
    if(CurIndex >= Items.Length)
    {
        return 0.0000000;
    }
    Item = Items[CurIndex];
    ScrollSize = float(ItemScrollSize(Item));
    Selected.bEndOfList = false;
    J0xF7:

    // End:0x231 [Loop If]
    if(ScrollAmount < float(0))
    {
        // End:0x125
        if(CurIndex > 0)
        {
            CurIndex--;            
        }
        else
        {
            // End:0x14C
            if(bLoops)
            {
                CurIndex = Items.Length - 1;                
            }
            else
            {
                ScrollAmount *= EndOfListSupression;
                Selected.bEndOfList = true;
                // [Explicit Break]
                goto J0x231;
            }
        }
        Item = Items[CurIndex];
        // End:0x22E
        if(Item.bIsVisible)
        {
            ScrollSize = float(ItemScrollSize(Item));
            ScrollAmount += ScrollSize;
            Scrolled -= ScrollSize;
            Selected.Index = CurIndex;
        }
        // [Loop Continue]
        goto J0xF7;
    }
    J0x231:

    HalfScroll = ScrollSize / float(2);
    J0x24A:

    // End:0x3BD [Loop If]
    if(ScrollAmount > HalfScroll)
    {
        // End:0x295
        if(CurIndex < (Items.Length - (NumShowEndOfList + 1)))
        {
            CurIndex++;            
        }
        else
        {
            // End:0x2B0
            if(bLoops)
            {
                CurIndex = 0;                
            }
            else
            {
                ScrollAmount -= HalfScroll;
                ScrollAmount *= EndOfListSupression;
                ScrollAmount += HalfScroll;
                Selected.bEndOfList = true;
                // [Explicit Break]
                goto J0x3BD;
            }
        }
        Item = Items[CurIndex];
        // End:0x3BA
        if(Item.bIsVisible)
        {
            ScrollAmount -= ScrollSize;
            Scrolled += ScrollSize;
            Selected.Index = CurIndex;
            ScrollSize = float(ItemScrollSize(Item));
        }
        // [Loop Continue]
        goto J0x24A;
    }
    J0x3BD:

    // End:0x3EF
    if(bForceZeroAdjustment)
    {
        Selected.Offset = 0.0000000;        
    }
    else
    {
        Selected.Offset = -ScrollAmount;
        Scrolled -= ScrollAmount;
    }
    return Scrolled;
    //return ReturnValue;    
}

function UpdateScroll(float DeltaTime)
{
    local float ScrollAmount;

    // End:0x6F
    if(Drag.bIsDragging)
    {
        SelectedItem = Drag.OrigSelectedItem;
        ScrollAmount = Drag.ScrollAmount;        
    }
    else
    {
        // End:0x1DC
        if(Movement.bIsMoving)
        {
            SelectedItem = Movement.OrigSelectedItem;
            Movement.CurrentTime += DeltaTime;
            // End:0x194
            if(Movement.CurrentTime < Movement.TotalTime)
            {
                ScrollAmount = FInterpEaseOut(0.0000000, Movement.FullMovement, Movement.CurrentTime / Movement.TotalTime, EaseOutExp);                
            }
            else
            {
                ScrollAmount = Movement.FullMovement;
                Movement.bIsMoving = false;
            }            
        }
        else
        {
            return;
        }
    }
    CalculateSelectedItem(SelectedItem, ScrollAmount, false);
    //return;    
}

function RenderObject(Canvas Canvas, float DeltaTime)
{
    local MobileMenuListItem Item;
    local float OrgX, OrgY;
    local int VpEnd, CurIndex, first, Last, SelectedIdx, NumItems,
	    RealIndex;

    local Vector2D VpPos, VpSize;

    NumItems = Items.Length;
    // End:0x25
    if(NumItems == 0)
    {
        return;
    }
    UpdateScroll(DeltaTime);
    VpSize.X = Width;
    VpSize.Y = Height;
    SelectedIdx = int(FMax(0.0000000, float(SelectedItem.Index)));
    // End:0xD6
    if(bLoops)
    {
        SelectedIdx += NumItems;
    }
    first = SelectedIdx;
    // End:0x25D
    if(bIsVerticalList)
    {
        VpPos.X = Left;
        VpPos.Y = (Top + SelectedOffset) + SelectedItem.Offset;
        VpEnd = int(Top + Height);
        J0x18B:

        // End:0x25A [Loop If]
        if((first > 0) && VpPos.Y > Top)
        {
            first--;
            Item = Items[first % NumItems];
            // End:0x257
            if(Item.bIsVisible)
            {
                VpPos.Y -= Item.Height;
            }
            // [Loop Continue]
            goto J0x18B;
        }        
    }
    else
    {
        VpPos.X = (Left + SelectedOffset) + SelectedItem.Offset;
        VpPos.Y = Top;
        VpEnd = int(Left + Width);
        J0x2F2:

        // End:0x3C1 [Loop If]
        if((first > 0) && VpPos.X > Left)
        {
            first--;
            Item = Items[first % NumItems];
            // End:0x3BE
            if(Item.bIsVisible)
            {
                VpPos.X -= Item.Width;
            }
            // [Loop Continue]
            goto J0x2F2;
        }
    }
    J0x3C1:

    // End:0x42B [Loop If]
    if((first + 1) < NumItems)
    {
        Item = Items[first];
        // End:0x41D
        if(Item.bIsVisible)
        {
            // [Explicit Break]
            goto J0x42B;
        }
        first++;
        // [Loop Continue]
        goto J0x3C1;
    }
    J0x42B:

    Last = first;
    CurIndex = 0;
    J0x449:

    // End:0x729 [Loop If]
    if(CurIndex < NumItems)
    {
        RealIndex = ((bLoops) ? (first + CurIndex) % NumItems : first + CurIndex);
        // End:0x4C6
        if(RealIndex >= NumItems)
        {
            // [Explicit Break]
            goto J0x729;
        }
        Item = Items[RealIndex];
        // End:0x71B
        if(Item.bIsVisible)
        {
            Last = first + CurIndex;
            // End:0x627
            if(bIsVerticalList)
            {
                VpSize.Y = Item.Height;
                Item.VpPos = VpPos;
                Item.VpSize = VpSize;
                VpPos.Y += VpSize.Y;
                // End:0x624
                if(VpPos.Y >= float(VpEnd))
                {
                    // [Explicit Break]
                    goto J0x729;
                }                
            }
            else
            {
                VpSize.X = Item.Width;
                Item.VpPos = VpPos;
                Item.VpSize = VpSize;
                VpPos.X += VpSize.X;
                // End:0x71B
                if(VpPos.X >= float(VpEnd))
                {
                    // [Explicit Break]
                    goto J0x729;
                }
            }
        }
        CurIndex++;
        // [Loop Continue]
        goto J0x449;
    }
    J0x729:

    OrgX = Canvas.OrgX;
    OrgY = Canvas.OrgY;
    CurIndex = first;
    J0x78C:

    // End:0x8AE [Loop If]
    if(CurIndex < SelectedIdx)
    {
        Item = Items[CurIndex % NumItems];
        // End:0x8A0
        if(Item.bIsVisible)
        {
            Canvas.SetOrigin(Item.VpPos.X, Item.VpPos.Y);
            Item.RenderItem(self, Canvas, DeltaTime);
        }
        CurIndex++;
        // [Loop Continue]
        goto J0x78C;
    }
    CurIndex = Last;
    J0x8C1:

    // End:0x9E3 [Loop If]
    if(CurIndex >= SelectedIdx)
    {
        Item = Items[CurIndex % NumItems];
        // End:0x9D5
        if(Item.bIsVisible)
        {
            Canvas.SetOrigin(Item.VpPos.X, Item.VpPos.Y);
            Item.RenderItem(self, Canvas, DeltaTime);
        }
        CurIndex--;
        // [Loop Continue]
        goto J0x8C1;
    }
    FirstVisible = first;
    LastVisible = Last;
    Canvas.OrgX = OrgX;
    Canvas.OrgY = OrgY;
    //return;    
}

function int ItemScrollSize(MobileMenuListItem Item)
{
    return int(((bIsVerticalList) ? Item.Height : Item.Width));
    //return ReturnValue;    
}

defaultproperties
{
    bIsVerticalList=true
    bForceSelectedToLineup=true
    bTapToScrollToItem=true
    Deacceleration=1500.0000000
    EaseOutExp=4.0000000
    EndOfListSupression=0.4000000
    bIsActive=true
}