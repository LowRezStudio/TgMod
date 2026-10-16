class SeqVar_ObjectList extends SeqVar_Object
    native(Sequence)
    hidecategories(Object);

var() array<Object> ObjList;

function Object GetObjectValue()
{
    return ((ObjList.Length > 0) ? ObjList[0] : none);
    //return ReturnValue;    
}

function SetObjectValue(Object NewValue)
{
    ObjList[0] = NewValue;
    //return;    
}

defaultproperties
{
    ObjName="Object List"
}