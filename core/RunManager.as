namespace RunManager {
    bool retired = false;

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

        // Detect retire
        if (!retired && post == CSmScriptPlayer::EPost::Char) {
            retired = true;
        } else if (retired && post != CSmScriptPlayer::EPost::CarDriver) {
            Map::HandleReset();
            retired = false;
        }
    }
}