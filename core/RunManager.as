namespace RunManager {
    bool finished = false;
    bool retiered = false;
    uint RaceTime = 0;
    uint prevRaceTime = 0;

    uint GetRunTime() {
        auto app = GetApp();
        auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
        auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
        auto scriptPlayer = player is null ? null : cast<CSmScriptPlayer>(player.ScriptAPI);
        auto playgroundScript = cast<CSmArenaRulesMode>(app.PlaygroundScript);

        // online check
        if (playgroundScript is null) {
            return app.Network.PlaygroundClientScriptAPI.GameTime - scriptPlayer.StartTime;
        } else {
            return playgroundScript.Now - scriptPlayer.StartTime;
        }
    }

    void Update() {
        auto app = GetApp();
        if (app is null || app.CurrentPlayground is null) {
            return;
        }

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