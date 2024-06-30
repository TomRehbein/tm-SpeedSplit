namespace Map {
    string mapId = "";
    DataManager@ pb = null;
    array<uint> pbSplits = {};

    void Main() {}

    void Update() {
        auto app = GetApp();
        if (app.CurrentPlayground is null) return;

        string currentMapId = app.RootMap.MapInfo.MapUid;
        if (currentMapId == mapId) return;

        mapId = currentMapId;
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