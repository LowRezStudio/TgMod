class TmCheatManager extends TgBattleCheatManager within TgPlayerController
    config(Game);

exec function Tempest() {
    `LogInfo('CheatManager',"Test !");
}

exec function TempestSC(string champ) {
    self.SwitchClass(champ,,,);
}