class AnimSet extends Object
    native(Anim)
    hidecategories(Object);

struct native AnimSetMeshLinkup
{
    var array<int> BoneToTrackTable;

    structdefaultproperties
    {
        BoneToTrackTable=none
    }
};

var() bool bAnimRotationOnly;
var() bool m_bUsesHandIK;
var() bool m_bCompressOutFacialBones;
var array<name> TrackBoneNames;
var array<AnimSequence> Sequences;
var native transient map{VOID,VOID} SequenceCache;
var transient array<AnimSetMeshLinkup> LinkupCache;
var native transient map{VOID,VOID} SkelMesh2LinkupCache;
var transient array<byte> BoneUseAnimTranslation;
var transient array<byte> ForceUseMeshTranslation;
var() array<name> UseTranslationBoneNames;
var() array<name> ForceMeshTranslationBoneNames;
var name PreviewSkelMeshName;
var name BestRatioSkelMeshName;
var array<name> m_FacialFilteredBones;

defaultproperties
{
    m_FacialFilteredBones[0]="Cheeks"
    m_FacialFilteredBones[1]="CheeksWeighted"
    m_FacialFilteredBones[2]="EyebrowMiddle"
    m_FacialFilteredBones[3]="EyebrowMiddleWeighted"
    m_FacialFilteredBones[4]="L_Eye"
    m_FacialFilteredBones[5]="L_Eyebrow"
    m_FacialFilteredBones[6]="L_EyebrowWeighted"
    m_FacialFilteredBones[7]="R_Eye"
    m_FacialFilteredBones[8]="R_Eyebrow"
    m_FacialFilteredBones[9]="R_EyebrowWeighted"
    m_FacialFilteredBones[10]="UpperLip"
    m_FacialFilteredBones[11]="UpperLipWeighted"
    m_FacialFilteredBones[12]="JawForward"
    m_FacialFilteredBones[13]="Jaw"
    m_FacialFilteredBones[14]="JawWeighted"
    m_FacialFilteredBones[15]="L_MouthCorner"
    m_FacialFilteredBones[16]="L_MouthCornerWeighted"
    m_FacialFilteredBones[17]="L_CheekPullWeighted"
    m_FacialFilteredBones[18]="LowerLip"
    m_FacialFilteredBones[19]="LowerLipWeighted"
    m_FacialFilteredBones[20]="R_MouthCorner"
    m_FacialFilteredBones[21]="R_MouthCornerWeighted"
    m_FacialFilteredBones[22]="R_CheekPullWeighted"
    m_FacialFilteredBones[23]="EyelidsTop"
}