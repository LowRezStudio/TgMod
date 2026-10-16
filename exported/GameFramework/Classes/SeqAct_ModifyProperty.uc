class SeqAct_ModifyProperty extends SequenceAction
    native
    forcescriptorder(true)
    hidecategories(Object);

struct native PropertyInfo
{
    var() name PropertyName;
    var() bool bModifyProperty;
    var() string PropertyValue;

    structdefaultproperties
    {
        PropertyName="None"
        bModifyProperty=false
        PropertyValue=""
    }
};

var() editinline array<editinline PropertyInfo> Properties;

defaultproperties
{
    ObjName="Modify Property"
}