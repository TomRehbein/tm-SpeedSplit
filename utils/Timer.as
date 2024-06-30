namespace Timer {
    // needs to be improved! Its not accurate enough
    uint GetRunTime() {
        auto app = GetApp();
        if (app is null) return 0;

        auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
        if (playground is null) return 0;

        auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
        if (player is null) return 0;

        CSmScriptPlayer@ scriptPlayer = cast<CSmScriptPlayer>(player.ScriptAPI);
        auto playgroundScript = cast<CSmArenaRulesMode>(app.PlaygroundScript);

        uint currentTime = 0;

        // online check
        if (playgroundScript is null) {
            currentTime = app.Network.PlaygroundClientScriptAPI.GameTime;
        } else {
            currentTime = playgroundScript.Now;
        }

        uint startTime = scriptPlayer.StartTime;
        uint runTime = currentTime - startTime;

        return runTime;
    }
}