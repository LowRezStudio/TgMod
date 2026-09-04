class MobileHUD extends HUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

var config bool bShowGameHud;
var config bool bShowMobileHud;
var globalconfig bool bForceMobileHUD;
var config bool bShowMobileTilt;
var config bool bDebugTouches;
var config bool bDebugZones;
var config bool bDebugZonePresses;
var config bool bShowMotionDebug;
var Texture2D JoystickBackground;
var TextureUVs JoystickBackgroundUVs;
var Texture2D JoystickHat;
var TextureUVs JoystickHatUVs;
var Texture2D ButtonImages[2];
var TextureUVs ButtonUVs[2];
var Font ButtonFont;
var Color ButtonCaptionColor;
var Texture2D TrackballBackground;
var TextureUVs TrackballBackgroundUVs;
var Texture2D TrackballTouchIndicator;
var TextureUVs TrackballTouchIndicatorUVs;
var Texture2D SliderImages[4];
var TextureUVs SliderUVs[4];
var config float MobileTiltX;
var config float MobileTiltY;
var config float MobileTiltSize;
var array<SeqEvent_HudRender> KismetRenderEvents;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x40
    if(WorldInfo.IsConsoleBuild(3) || bForceMobileHUD)
    {        
    }
    else
    {
        bShowGameHud = true;
    }
    RefreshKismetLinks();
    //return;    
}

function PostRender()
{
    local MobilePlayerInput MPI;

    super.PostRender();
    // End:0x50
    if(Class'Engine.GameEngine'.static.HasSecondaryScreenActive() == false)
    {
        // End:0x46
        if(ShowMobileHud())
        {
            DrawInputZoneOverlays();
        }
        RenderMobileMenu();
    }
    // End:0x425
    if(bShowMotionDebug)
    {
        MPI = MobilePlayerInput(PlayerOwner.PlayerInput);
        // End:0x425
        if(MPI != none)
        {
            Canvas.SetDrawColor(255, 255, 255, 255);
            Canvas.SetPos(0.0000000, 70.0000000);
            DrawMobileDebugString(0.0000000, 90.0000000, "[Mobile Motion]");
            DrawMobileDebugString(0.0000000, 110.0000000, (((("Attitude: Pitch=" $ string(MPI.aTilt.X)) @ "Yaw=") $ string(MPI.aTilt.Y)) @ "Roll=") $ string(MPI.aTilt.Z));
            DrawMobileDebugString(0.0000000, 130.0000000, (("Rotation:" @ string(MPI.aRotationRate.X)) @ string(MPI.aRotationRate.Y)) @ string(MPI.aRotationRate.Z));
            DrawMobileDebugString(0.0000000, 150.0000000, (("Gravity:" @ string(MPI.aGravity.X)) @ string(MPI.aGravity.Y)) @ string(MPI.aGravity.Z));
            DrawMobileDebugString(0.0000000, 170.0000000, (("Accleration:" @ string(MPI.aAcceleration.X)) @ string(MPI.aAcceleration.Y)) @ string(MPI.aAcceleration.Z));
        }
    }
    RenderKismetHud();
    //return;    
}

function DrawMobileDebugString(float XPos, float YPos, string Str)
{
    Canvas.SetDrawColor(0, 0, 0, 255);
    Canvas.SetPos(XPos, YPos);
    Canvas.DrawText(Str);
    Canvas.SetPos(XPos + float(1), YPos + float(1));
    Canvas.DrawColor = WhiteColor;
    Canvas.DrawText(Str);
    //return;    
}

function bool ShowMobileHud()
{
    return bShowMobileHud && bShowHUD;
    //return ReturnValue;    
}

function RenderMobileMenu()
{
    local MobilePlayerInput MobileInput;
    local float Y;
    local int I;

    MobileInput = MobilePlayerInput(PlayerOwner.PlayerInput);
    // End:0x42
    if(MobileInput == none)
    {
        return;
    }
    // End:0x21B
    if(bDebugTouches)
    {
        Y = 20.0000000;
        Canvas.SetDrawColor(255, 255, 255, 255);
        I = 0;
        J0x90:

        // End:0x21B [Loop If]
        if(I < 5)
        {
            Canvas.SetPos(0.0000000, Y);
            Canvas.DrawText((((("" $ string(I)) @ string(MobileInput.Touches[I].bInUse)) @ string(MobileInput.Touches[I].State)) @ string(MobileInput.Touches[I].Zone)) @ string(MobileInput.Touches[I].Handle));
            Y += float(10);
            I++;
            // [Loop Continue]
            goto J0x90;
        }
    }
    MobileInput.RenderMenus(Canvas, WorldInfo.DeltaSeconds);
    //return;    
}

function DrawInputZoneOverlays()
{
    local int ZoneIndex;
    local MobileInputZone Zone;
    local float Fade;
    local MobilePlayerInput MobileInput;
    local array<MobileInputZone> Zones;

    // End:0x11
    if(!bShowHUD)
    {
        return;
    }
    MobileInput = MobilePlayerInput(PlayerOwner.PlayerInput);
    // End:0x53
    if(MobileInput == none)
    {
        return;
    }
    Canvas.Reset();
    Canvas.ClipX = float(Canvas.SizeX);
    Canvas.ClipY = float(Canvas.SizeY);
    Canvas.Font = Class'Engine.Engine'.static.GetSmallFont();
    // End:0x17A
    if(MobileInput.HasZones())
    {
        Zones = MobileInput.GetCurrentZones();
    }
    ZoneIndex = 0;
    J0x185:

    // End:0x71F [Loop If]
    if(ZoneIndex < Zones.Length)
    {
        Zone = Zones[ZoneIndex];
        // End:0x5A1
        if(!Zone.bIsInvisible)
        {
            Canvas.DrawColor = Zone.RenderColor;
            Canvas.DrawColor.A *= Zone.AnimatingFadeOpacity;
            switch(Zone.State)
            {
                // End:0x2ED
                case 0:
                    Canvas.DrawColor.A *= Zone.InactiveAlpha;
                    // End:0x452
                    break;
                // End:0x39E
                case 1:
                    Fade = Lerp(Zone.InactiveAlpha, 1.0000000, Zone.TransitionTime / Zone.ActivateTime);
                    Canvas.DrawColor.A *= Fade;
                    // End:0x452
                    break;
                // End:0x44F
                case 3:
                    Fade = Lerp(1.0000000, Zone.InactiveAlpha, Zone.TransitionTime / Zone.DeactivateTime);
                    Canvas.DrawColor.A *= Fade;
                    // End:0x452
                    break;
                // End:0xFFFF
                default:
                    break;
            }
            // End:0x491
            if(int(Canvas.DrawColor.A) <= int(0))
            {
                // [Explicit Continue]
                goto J0x711;
            }
            // End:0x5A1
            if(!Zone.OnPreDrawZone(Zone, Canvas))
            {
                switch(Zone.Type)
                {
                    // End:0x513
                    case 0:
                        DrawMobileZone_Button(Zone);
                        // End:0x567
                        break;
                    // End:0x52E
                    case 1:
                        DrawMobileZone_Joystick(Zone);
                        // End:0x567
                        break;
                    // End:0x549
                    case 2:
                        DrawMobileZone_Trackball(Zone);
                        // End:0x567
                        break;
                    // End:0x564
                    case 3:
                        DrawMobileZone_Slider(Zone);
                        // End:0x567
                        break;
                    // End:0xFFFF
                    default:
                        break;
                }
                Zone.OnPostDrawZone(Zone, Canvas);
            }
        }
        // End:0x5C1
        if(bShowMobileTilt)
        {
            DrawMobileTilt(MobileInput);
        }
        // End:0x711
        if(bDebugZones || bDebugZonePresses && (int(Zone.State) == int(2)) || int(Zone.State) == int(1))
        {
            Canvas.SetDrawColor(0, 255, 255, 255);
            Canvas.SetPos(Zone.X, Zone.Y);
            Canvas.DrawBox(Zone.SizeX, Zone.SizeY);
        }
        J0x711:

        ZoneIndex++;
        // [Loop Continue]
        goto J0x185;
    }
    //return;    
}

function DrawMobileZone_Button(MobileInputZone Zone)
{
    local int Pressed;
    local float X, Y, U, V, UL, VL,
	    A;

    local Texture2D Tex;

    Pressed = int(int(Zone.State) == int(2));
    // End:0x767
    if(ButtonImages[Pressed] != none)
    {
        Canvas.SetPos(Zone.X, Zone.Y);
        // End:0x1F3
        if((Pressed == 0) && Zone.OverrideTexture1 != none)
        {
            Tex = Zone.OverrideTexture1;
            U = Zone.OverrideUVs1.U;
            V = Zone.OverrideUVs1.V;
            UL = Zone.OverrideUVs1.UL;
            VL = Zone.OverrideUVs1.VL;            
        }
        else
        {
            // End:0x33F
            if((Pressed == 1) && Zone.OverrideTexture2 != none)
            {
                Tex = Zone.OverrideTexture2;
                U = Zone.OverrideUVs2.U;
                V = Zone.OverrideUVs2.V;
                UL = Zone.OverrideUVs2.UL;
                VL = Zone.OverrideUVs2.VL;                
            }
            else
            {
                Tex = ButtonImages[Pressed];
                U = ButtonUVs[Pressed].U;
                V = ButtonUVs[Pressed].V;
                UL = ButtonUVs[Pressed].UL;
                VL = ButtonUVs[Pressed].VL;
            }
        }
        Canvas.DrawTile(Tex, Zone.ActiveSizeX, Zone.ActiveSizeY, U, V, UL, VL);
        // End:0x767
        if(Zone.Caption != "")
        {
            // End:0x504
            if(ButtonFont != none)
            {
                Canvas.Font = ButtonFont;
            }
            Canvas.StrLen(Zone.Caption, UL, VL);
            X = (Zone.X + (Zone.SizeX / float(2))) - (UL / float(2));
            Y = (Zone.Y + (Zone.SizeY / float(2))) - (VL / float(2));
            Canvas.SetPos(X + Zone.CaptionXAdjustment, Y + Zone.CaptionYAdjustment);
            A = float(Canvas.DrawColor.A);
            Canvas.DrawColor = ButtonCaptionColor;
            Canvas.DrawColor.A = byte(A);
            Canvas.DrawText(Zone.Caption);
        }
    }
    //return;    
}

function DrawMobileZone_Joystick(MobileInputZone Zone)
{
    local int X, Y, Width, Height;
    local Color LineColor;
    local float ClampedX, ClampedY, Scale;
    local Color TempColor;

    // End:0x34F
    if((Zone.OverrideTexture1 != none) || JoystickBackground != none)
    {
        Width = int(Zone.ActiveSizeX);
        Height = int(Zone.ActiveSizeY);
        X = int(Zone.CurrentCenter.X - float(Width / 2));
        Y = int(Zone.CurrentCenter.Y - float(Height / 2));
        Canvas.SetPos(float(X), float(Y));
        // End:0x29D
        if(Zone.OverrideTexture1 != none)
        {
            Canvas.DrawTile(Zone.OverrideTexture1, float(Width), float(Height), Zone.OverrideUVs1.U, Zone.OverrideUVs1.V, Zone.OverrideUVs1.UL, Zone.OverrideUVs1.VL);            
        }
        else
        {
            Canvas.DrawTile(JoystickBackground, float(Width), float(Height), JoystickBackgroundUVs.U, JoystickBackgroundUVs.V, JoystickBackgroundUVs.UL, JoystickBackgroundUVs.VL);
        }
    }
    // End:0xA06
    if((Zone.OverrideTexture2 != none) || JoystickHat != none)
    {
        ClampedX = Zone.CurrentLocation.X - Zone.CurrentCenter.X;
        ClampedY = Zone.CurrentLocation.Y - Zone.CurrentCenter.Y;
        Scale = 1.0000000;
        // End:0x530
        if((ClampedX != float(0)) || ClampedY != float(0))
        {
            Scale = float(Min(int(Zone.ActiveSizeX), int(Zone.ActiveSizeY))) / (2.0000000 * Sqrt((ClampedX * ClampedX) + (ClampedY * ClampedY)));
            Scale = FMin(1.0000000, Scale);
        }
        ClampedX = (ClampedX * Scale) + Zone.CurrentCenter.X;
        ClampedY = (ClampedY * Scale) + Zone.CurrentCenter.Y;
        // End:0x75C
        if(Zone.bRenderGuides)
        {
            TempColor = Canvas.DrawColor;
            LineColor.R = 128;
            LineColor.G = 128;
            LineColor.B = 128;
            LineColor.A = 255;
            Canvas.Draw2DLine(Zone.CurrentCenter.X, Zone.CurrentCenter.Y, ClampedX, ClampedY, LineColor);
            Canvas.DrawColor = TempColor;
        }
        Width = int(Zone.ActiveSizeX * 0.6500000);
        Height = int(Zone.ActiveSizeY * 0.6500000);
        Canvas.SetPos(ClampedX - float(Width / 2), ClampedY - float(Height / 2));
        // End:0x954
        if(Zone.OverrideTexture2 != none)
        {
            Canvas.DrawTile(Zone.OverrideTexture2, float(Width), float(Height), Zone.OverrideUVs2.U, Zone.OverrideUVs2.V, Zone.OverrideUVs2.UL, Zone.OverrideUVs2.VL);            
        }
        else
        {
            Canvas.DrawTile(JoystickHat, float(Width), float(Height), JoystickHatUVs.U, JoystickHatUVs.V, JoystickHatUVs.UL, JoystickHatUVs.VL);
        }
    }
    //return;    
}

function DrawMobileZone_Trackball(MobileInputZone Zone)
{
    local int Width, Height;

    // End:0x2D1
    if((Zone.OverrideTexture1 != none) || TrackballBackground != none)
    {
        Canvas.SetPos(Zone.X, Zone.Y);
        // End:0x1F9
        if(Zone.OverrideTexture1 != none)
        {
            Canvas.DrawTile(Zone.OverrideTexture1, Zone.SizeX, Zone.SizeY, Zone.OverrideUVs1.U, Zone.OverrideUVs1.V, Zone.OverrideUVs1.UL, Zone.OverrideUVs1.VL);            
        }
        else
        {
            Canvas.DrawTile(TrackballBackground, Zone.SizeX, Zone.SizeY, TrackballBackgroundUVs.U, TrackballBackgroundUVs.V, TrackballBackgroundUVs.UL, TrackballBackgroundUVs.VL);
        }
    }
    // End:0x656
    if(((Zone.OverrideTexture2 != none) || TrackballTouchIndicator != none) && (int(Zone.State) == int(2)) || int(Zone.State) == int(1))
    {
        Width = int(Zone.ActiveSizeX * 0.6500000);
        Height = int(Zone.ActiveSizeY * 0.6500000);
        Canvas.SetPos(Zone.CurrentLocation.X - float(Width / 2), Zone.CurrentLocation.Y - float(Height / 2));
        // End:0x5A4
        if(Zone.OverrideTexture2 != none)
        {
            Canvas.DrawTile(Zone.OverrideTexture2, float(Width), float(Height), Zone.OverrideUVs2.U, Zone.OverrideUVs2.V, Zone.OverrideUVs2.UL, Zone.OverrideUVs2.VL);            
        }
        else
        {
            Canvas.DrawTile(TrackballTouchIndicator, float(Width), float(Height), TrackballTouchIndicatorUVs.U, TrackballTouchIndicatorUVs.V, TrackballTouchIndicatorUVs.UL, TrackballTouchIndicatorUVs.VL);
        }
    }
    //return;    
}

function DrawMobileTilt(MobilePlayerInput MobileInput)
{
    local float X, Y, Scale, Yaw, Pitch;

    Yaw = (2.0000000 * FClamp(MobileInput.MobileYaw - MobileInput.MobileYawCenter, -0.5000000, 0.5000000)) * MobileInput.MobileYawMultiplier;
    Pitch = (2.0000000 * FClamp(MobileInput.MobilePitch - MobileInput.MobilePitchCenter, -0.5000000, 0.5000000)) * MobileInput.MobilePitchMultiplier;
    X = (MobileTiltX + ((Yaw * MobileTiltSize) / float(2))) - MobileTiltX;
    Y = (MobileTiltY + ((Pitch * MobileTiltSize) / float(2))) - MobileTiltY;
    Scale = 1.0000000;
    // End:0x1FF
    if((X != float(0)) || Y != float(0))
    {
        Scale = MobileTiltSize / (2.0000000 * Sqrt(((X * X) * Y) * Y));
        Scale = FMin(1.0000000, Scale);
    }
    X = (X * Scale) + MobileTiltX;
    Y = (Y * Scale) + MobileTiltY;
    Canvas.DrawColor = WhiteColor;
    Canvas.Draw2DLine(MobileTiltX, MobileTiltY, X, Y, Canvas.DrawColor);
    //return;    
}

function DrawMobileZone_Slider(MobileInputZone Zone)
{
    local float X, Y;
    local TextureUVs UVs;
    local Texture2D Tex;

    // End:0x77
    if(Zone.OverrideTexture1 != none)
    {
        Tex = Zone.OverrideTexture1;
        UVs = Zone.OverrideUVs1;        
    }
    else
    {
        Tex = SliderImages[int(Zone.SlideType)];
        UVs = SliderUVs[int(Zone.SlideType)];
    }
    X = ((int(Zone.SlideType) > 1) ? Zone.CurrentLocation.X - (Zone.ActiveSizeX * 0.5000000) : Zone.X);
    Y = ((int(Zone.SlideType) > 1) ? Zone.Y : Zone.CurrentLocation.Y - (Zone.ActiveSizeY * 0.5000000));
    Canvas.SetPos(X, Y);
    Canvas.DrawTile(Tex, Zone.ActiveSizeX, Zone.ActiveSizeY, UVs.U, UVs.V, UVs.UL, UVs.VL);
    //return;    
}

function RefreshKismetLinks()
{
    local array<SequenceObject> HudEvents;
    local Sequence GameSeq;
    local int I;

    GameSeq = WorldInfo.GetGameSequence();
    // End:0xC1
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'GameFramework.SeqEvent_HudRender', true, HudEvents);
        I = 0;
        J0x75:

        // End:0xC1 [Loop If]
        if(I < HudEvents.Length)
        {
            AddKismetRenderEvent(SeqEvent_HudRender(HudEvents[I]));
            I++;
            // [Loop Continue]
            goto J0x75;
        }
    }
    //return;    
}

function AddKismetRenderEvent(SeqEvent_HudRender NewEvent)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < KismetRenderEvents.Length)
    {
        // End:0x46
        if(KismetRenderEvents[I] == NewEvent)
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x5F:

    // End:0xBD [Loop If]
    if(I < KismetRenderEvents.Length)
    {
        // End:0xAF
        if(KismetRenderEvents[I] == none)
        {
            KismetRenderEvents[I] = NewEvent;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x5F;
    }
    KismetRenderEvents.AddItem(NewEvent);
    //return;    
}

function RenderKismetHud()
{
    local int I;
    local array<byte> boolVars;

    I = 0;
    J0x0B:

    // End:0x147 [Loop If]
    if(I < KismetRenderEvents.Length)
    {
        boolVars.Length = 0;
        KismetRenderEvents[I].GetBoolVars(boolVars, "Active");
        // End:0x139
        if(((boolVars.Length == 0) || int(boolVars[0]) != int(0)) && KismetRenderEvents[I].bIsActive)
        {
            // End:0x139
            if((KismetRenderEvents[I] != none) && KismetRenderEvents[I].bIsActive)
            {
                KismetRenderEvents[I].Render(Canvas, self);
            }
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

defaultproperties
{
    bShowMobileHud=true
    JoystickBackgroundUVs=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    JoystickHatUVs=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    ButtonUVs[0]=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    ButtonUVs[1]=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    TrackballBackgroundUVs=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    TrackballTouchIndicatorUVs=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    SliderUVs[0]=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    SliderUVs[1]=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    SliderUVs[2]=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    SliderUVs[3]=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
}