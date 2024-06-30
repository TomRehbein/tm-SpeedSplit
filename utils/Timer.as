namespace Timer {
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
}