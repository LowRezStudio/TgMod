class DebugCameraHUD extends HUD
    transient
    config(Game)
    hidecategories(Navigation);

var bool bDrawDebugText;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    //return;    
}

function bool DisplayMaterials(float X, out float Y, float DY, MeshComponent MeshComp)
{
    local int MaterialIndex;
    local bool bDisplayedMaterial;
    local MaterialInterface Material;

    bDisplayedMaterial = false;
    // End:0x157
    if(MeshComp != none)
    {
        MaterialIndex = 0;
        J0x26:

        // End:0x157 [Loop If]
        if(MaterialIndex < MeshComp.GetNumElements())
        {
            Material = MeshComp.GetMaterial(MaterialIndex);
            // End:0x149
            if(Material != none)
            {
                Y += DY;
                Canvas.SetPos(X + DY, Y);
                Canvas.DrawText(("Material: '" $ string(Material.Name)) $ "'");
                bDisplayedMaterial = true;
            }
            ++MaterialIndex;
            // [Loop Continue]
            goto J0x26;
        }
    }
    return bDisplayedMaterial;
    //return ReturnValue;    
}

event PostRender()
{
    local DebugCameraController DCC;
    local float XL, YL, X, Y;
    local string MyText;
    local Vector CamLoc, ZeroVec;
    local Rotator CamRot;
    local TraceHitInfo HitInfo;
    local Actor HitActor;
    local editinline MeshComponent MeshComp;
    local Vector HitLoc, HitNormal;
    local bool bFoundMaterial;

    super.PostRender();
    DCC = DebugCameraController(PlayerOwner);
    // End:0xA8E
    if((DCC != none) && bDrawDebugText)
    {
        Canvas.SetDrawColor(0, 0, 255, 255);
        MyText = "DebugCameraHUD";
        Canvas.Font = Class'Engine.Engine'.static.GetSmallFont();
        Canvas.StrLen(MyText, XL, YL);
        X = float(Canvas.SizeX) * 0.0500000;
        Y = YL;
        YL += (float(2) * Y);
        Canvas.SetPos(X, YL);
        Canvas.DrawText(MyText, true);
        Canvas.SetDrawColor(128, 128, 128, 255);
        CamLoc = DCC.PlayerCamera.CameraCache.POV.Location;
        CamRot = DCC.PlayerCamera.CameraCache.POV.Rotation;
        YL += Y;
        Canvas.SetPos(X, YL);
        Canvas.DrawText((("CamLoc:" $ string(CamLoc)) @ "CamRot:") $ string(CamRot));
        HitActor = Trace(HitLoc, HitNormal, ((Vector(CamRot) * float(5000)) * float(20)) + CamLoc, CamLoc, true, ZeroVec, HitInfo);
        // End:0x8C5
        if(HitActor != none)
        {
            YL += Y;
            Canvas.SetPos(X, YL);
            Canvas.DrawText((("HitLoc:" $ string(HitLoc)) @ "HitNorm:") $ string(HitNormal));
            YL += Y;
            Canvas.SetPos(X, YL);
            Canvas.DrawText("HitDist:" @ string(VSize(CamLoc - HitLoc)));
            YL += Y;
            Canvas.SetPos(X, YL);
            Canvas.DrawText(("HitActor: '" $ string(HitActor.Name)) $ "'");
            YL += Y;
            Canvas.SetPos(X, YL);
            Canvas.DrawText(("PhysMat: '" $ string(HitInfo.PhysMaterial)) $ "'");
            bFoundMaterial = false;
            // End:0x701
            if(HitInfo.Material != none)
            {
                YL += Y;
                Canvas.SetPos(X + Y, YL);
                Canvas.DrawText("Material:" $ string(HitInfo.Material.Name));
                bFoundMaterial = true;                
            }
            else
            {
                // End:0x77B
                if(HitInfo.HitComponent != none)
                {
                    bFoundMaterial = DisplayMaterials(X, YL, Y, MeshComponent(HitInfo.HitComponent));                    
                }
                else
                {
                    // End:0x7F8
                    foreach HitActor.AllOwnedComponents(Class'Engine.MeshComponent', MeshComp)
                    {
                        bFoundMaterial = bFoundMaterial || DisplayMaterials(X, YL, Y, MeshComp);                        
                    }                    
                }
            }
            // End:0x88E
            if(bFoundMaterial == false)
            {
                YL += Y;
                Canvas.SetPos(X + Y, YL);
                Canvas.DrawText("Material: NONE");
            }
            DrawDebugLine(HitLoc, HitLoc + (HitNormal * float(30)), 255, 255, 231);            
        }
        else
        {
            YL += Y;
            Canvas.SetPos(X, YL);
            Canvas.DrawText("Not trace hit");
        }
        // End:0xA8E
        if((DCC.bShowSelectedInfo == true) && DCC.SelectedActor != none)
        {
            YL += Y;
            Canvas.SetPos(X, YL);
            Canvas.DrawText(("Selected actor: '" $ string(DCC.SelectedActor.Name)) $ "'");
            DisplayMaterials(X, YL, Y, MeshComponent(DCC.SelectedComponent));
        }
    }
    //return;    
}

defaultproperties
{
    bHidden=false
}