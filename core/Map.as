namespace Map {
    string mapId = "";
    DataManager@ pb = null;
    array<uint> pbSplits = {};

    void Main() {}

    void Update() {
        if (GameState::State != "game") return;

        auto app = GetApp();
        string currentMapId = app.RootMap.MapInfo.MapUid;
        if (currentMapId == mapId) return;

        mapId = currentMapId;
        print("Map changed to: " + mapId);
        if (!IO::FileExists("map_" + mapId + ".json")) {
            pbSplits = {};
            return;
        }

        pb = DataManager("map_" + mapId);
        Json::Value pbData = pb.LoadData();

        if (pbData.GetType() == Json::Type::Null) {
            print("No PB data found for map: " + mapId);
            return;
        }

        pbSplits = array<uint>(pbData["pbSplits"]);
        print("Loaded PB data for map: " + mapId);
    }
}