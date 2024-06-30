// figure out, if the user is in a game oder in the lobby or in the main menu
namespace GameState {
    string _state = "";

    string get_State() {
        return _state;
    }

    void Update() {
        auto app = GetApp();
        if (app is null) return;

        if (app.CurrentPlayground is null) {
            _state = "menu";
        } else {
            auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
            if (playground is null || playground.GameTerminals.Length == 0) {
                _state = "lobby";
            } else {
                _state = "game";
            }
        }
    }
}