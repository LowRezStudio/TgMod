class SpeechRecognition extends Object
    native
    collapsecategories
    hidecategories(Object);

struct native RecognisableWord
{
    var() int Id;
    var() string ReferenceWord;
    var() string PhoneticWord;

    structdefaultproperties
    {
        Id=0
        ReferenceWord=""
        PhoneticWord=""
    }
};

struct native RecogVocabulary
{
    var() array<RecognisableWord> WhoDictionary;
    var() array<RecognisableWord> WhatDictionary;
    var() array<RecognisableWord> WhereDictionary;
    var string VocabName;
    var array<byte> VocabData;
    var array<byte> WorkingVocabData;

    structdefaultproperties
    {
        WhoDictionary=none
        WhatDictionary=none
        WhereDictionary=none
        VocabName=""
        VocabData=none
        WorkingVocabData=none
    }
};

struct native RecogUserData
{
    var int ActiveVocabularies;
    var array<byte> UserData;

    structdefaultproperties
    {
        ActiveVocabularies=0
        UserData=none
    }
};

var() string Language;
var() float ConfidenceThreshhold;
var() array<RecogVocabulary> Vocabularies;
var array<byte> VoiceData;
var array<byte> WorkingVoiceData;
var array<byte> UserData;
var RecogUserData InstanceData[4];
var duplicatetransient transient bool bDirty;
var duplicatetransient transient bool bInitialised;
var duplicatetransient native const Pointer FnxVoiceData;

defaultproperties
{
    Language="INT"
    ConfidenceThreshhold=50.0000000
}