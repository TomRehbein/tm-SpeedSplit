namespace Map {
    string mapId = "";
    DataManager@ mapData = null;

    array<uint> pbSplits = {};
    array<uint> bestSplits = {};
    array<uint> currentSplits = {};

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

        mapData = DataManager("map_" + mapId);
        Json::Value pbData = mapData.LoadData();

        if (pbData.GetType() == Json::Type::Null) {
            print("No PB data found for map: " + mapId);
            return;
        }

        pbSplits = array<uint>(pbData["pbSplits"]);
        bestSplits = array<uint>(pbData["bestSplits"]);
        print("Loaded PB data for map: " + mapId);
    }

    void HandleCheckPoint() {
        uint time = Timer::GetRunTime();
        currentSplits.InsertLast(time);
        print("CP: " + time);
    }

    void HandleReset() {
        currentSplits = {};
        print("Run reset");
    }

    void HandleFinish() {
        if (currentSplits.Length == 0) return;

        if (pbSplits.Length == 0) {
            pbSplits = currentSplits;
            print("New PB set!");
        } else {
            bool newPB = false;
            for (uint i = 0; i < currentSplits.Length; i++) {
                if (currentSplits[i] < pbSplits[i]) {
                    pbSplits[i] = currentSplits[i];
                    newPB = true;
                }
            }

            if (newPB) {
                print("New PB set!");
            }
        }

        currentSplits = {};
    }
}