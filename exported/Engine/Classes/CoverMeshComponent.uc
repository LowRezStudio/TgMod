class CoverMeshComponent extends StaticMeshComponent
    native(AI)
    editinlinenew
    hidecategories(Object);

struct native CoverMeshes
{
    var StaticMesh Base;
    var StaticMesh LeanLeft;
    var StaticMesh LeanRight;
    var StaticMesh LeanLeftPref;
    var StaticMesh LeanRightPref;
    var StaticMesh Climb;
    var StaticMesh Mantle;
    var StaticMesh SlipLeft;
    var StaticMesh SlipRight;
    var StaticMesh SwatLeft;
    var StaticMesh SwatRight;
    var StaticMesh PopUp;
    var StaticMesh PlayerOnly;

    structdefaultproperties
    {
        Base=none
        LeanLeft=none
        LeanRight=none
        LeanLeftPref=none
        LeanRightPref=none
        Climb=none
        Mantle=none
        SlipLeft=none
        SlipRight=none
        SwatLeft=none
        SwatRight=none
        PopUp=none
        PlayerOnly=none
    }
};

var array<CoverMeshes> Meshes;
var Vector LocationOffset;
var StaticMesh AutoAdjustOn;
var StaticMesh AutoAdjustOff;
var StaticMesh Disabled;
var editoronly transient bool bShowWhenNotSelected;

defaultproperties
{
    Meshes[0]=(Base=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_TALL',LeanLeft=none,LeanRight=none,LeanLeftPref=none,LeanRightPref=none,Climb=none,Mantle=none,SlipLeft=none,SlipRight=none,SwatLeft=none,SwatRight=none,PopUp=none,PlayerOnly=none)
    Meshes[1]=(Base=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_TALL',LeanLeft=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_LeanLeftS',LeanRight=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_LeanRightS',LeanLeftPref=none,LeanRightPref=none,Climb=none,Mantle=none,SlipLeft=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_CoverSlipLeft',SlipRight=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_CoverSlipRight',SwatLeft=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_SwatLeft',SwatRight=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_SwatRight',PopUp=none,PlayerOnly=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_PlayerOnlyS')
    Meshes[2]=(Base=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT',LeanLeft=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_LeanLeftM',LeanRight=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_LeanRightM',LeanLeftPref=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_LeanLeftMPref',LeanRightPref=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_LeanRightMPref',Climb=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_Climb',Mantle=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_Mantle',SlipLeft=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_CoverSlipLeft',SlipRight=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_CoverSlipRight',SwatLeft=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_SwatLeft',SwatRight=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_SwatRight',PopUp=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_PopUp',PlayerOnly=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_PlayerOnlyM')
    LocationOffset=(X=0.0000000,Y=0.0000000,Z=-60.0000000)
    AutoAdjustOn=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_AutoAdjust'
    AutoAdjustOff=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_AutoAdjustOff'
    Disabled=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy_Enabled'
    StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_TALL'
    ReplacementPrimitive=none
    HiddenGame=true
    bAcceptsStaticDecals=false
    bAcceptsDynamicDecals=false
    CastShadow=false
    bAcceptsLights=false
    CollideActors=false
    BlockActors=false
    BlockZeroExtent=false
    BlockNonZeroExtent=false
    BlockRigidBody=false
    AlwaysLoadOnClient=false
    AlwaysLoadOnServer=false
}