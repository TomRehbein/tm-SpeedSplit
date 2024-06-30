namespace RunManager {
    bool finished = false;
    bool retiered = false;
    uint RaceTime = 0;
    uint prevRaceTime = 0;

    void Update() {
        if (GameState::State != "game") return;

        auto app = GetApp();
        auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
        auto sequence = playground.GameTerminals[0].UISequence_Current;
        auto playgroundScript = cast<CSmArenaRulesMode>(app.PlaygroundScript);
        auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
        if (player is null) return;

        auto scriptPlayer = cast<CSmScriptPlayer>(player.ScriptAPI);
        CSmScriptPlayer::EPost post = scriptPlayer.Post;

        // Detect start
        // Detect finish
        // Detect retiered
    }
}