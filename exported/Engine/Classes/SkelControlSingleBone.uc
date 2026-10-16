class SkelControlSingleBone extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

var(Adjustments) bool bApplyTranslation;
var(Adjustments) bool bApplyRotation;
var(Translation) bool bAddTranslation;
var(Rotation) bool bAddRotation;
var(Rotation) bool bRemoveMeshRotation;
var(Translation) Vector BoneTranslation;
var(Translation) SkelControlBase.EBoneControlSpace BoneTranslationSpace;
var(Rotation) SkelControlBase.EBoneControlSpace BoneRotationSpace;
var(Translation) name TranslationSpaceBoneName;
var(Rotation) Rotator BoneRotation;
var(Rotation) name RotationSpaceBoneName;
