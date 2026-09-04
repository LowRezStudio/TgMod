class TgDeviceForm_MountPanther extends TgDeviceForm_Mount;

simulated event string GetAnimSetStringForBot(int PlayerBotId)
{
    switch(PlayerBotId)
    {
        // End:0x50
        case 2056:
            return "PC_Alchemist.Anims.AS_PC_Alchemist_3p_Mount_Jaguar";
        // End:0x8B
        case 2057:
            return "PC_Assassin.Anims.AS_PC_Assassin_3p_Mount_Jaguar";
        // End:0xC6
        case 2073:
            return "PC_Engineer.Anims.AS_PC_Engineer_3p_Mount_Jaguar";
        // End:0x101
        case 2092:
            return "PC_Huntress.Anims.AS_PC_Huntress_3p_Mount_Jaguar";
        // End:0x138
        case 2071:
            return "PC_Knight.Anims.AS_PC_Knight_3p_Mount_Jaguar";
        // End:0x16B
        case 2094:
            return "PC_Mage.Anims.AS_PC_Mage_3p_Mount_Jaguar";
        // End:0x1A2
        case 2093:
            return "PC_Shaman.Anims.AS_PC_Shaman_3p_Mount_Jaguar";
        // End:0x1DD
        case 2205:
            return "PC_Androxus.Anims.AS_PC_Androxus_3p_Mount_Jaguar";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}
