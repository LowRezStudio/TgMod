class UIDataStore_Registry extends UIDataStore
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

struct native RegistryKeyValuePair
{
    var string Key;
    var string Value;

    structdefaultproperties
    {
        Key=""
        Value=""
    }
};

var array<RegistryKeyValuePair> RegistryData;

event bool GetData(string Key, out string out_Data)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x97 [Loop If]
    if(I < RegistryData.Length)
    {
        // End:0x89
        if(RegistryData[I].Key == Key)
        {
            out_Data = RegistryData[I].Value;
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

event SetData(string Key, string Value)
{
    local int I;
    local RegistryKeyValuePair KVP;

    I = 0;
    J0x0B:

    // End:0x97 [Loop If]
    if(I < RegistryData.Length)
    {
        // End:0x89
        if(RegistryData[I].Key == Key)
        {
            RegistryData[I].Value = Value;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    KVP.Key = Key;
    KVP.Value = Value;
    RegistryData.AddItem(KVP);
    //return;    
}

defaultproperties
{
    Tag="Registry"
}