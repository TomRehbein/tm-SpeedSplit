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
            print("No PB data found for map: " + mapId);
            ClearPbAndBestSplits();
            return;
        }

        LoadMapData(mapId);
    }

    void LoadMapData(const string &in mapId) {
        @mapData = DataManager("map_" + mapId);
        Json::Value loadedData = mapData.LoadData();

        if (loadedData.GetType() == Json::Type::Null) {
            print("No PB data found for map: " + mapId);
            pbSplits = {};
            bestSplits = {};
            return;
        }

        if (!loadedData.HasKey("pbSplits") || loadedData["pbSplits"].GetType() != Json::Type::Array ){
            print("Invalid PB data found for map: " + mapId);
            pbSplits = {};
        } else {
            pbSplits = DataManager::JsonToArray(loadedData["pbSplits"]);
        }

        if (!loadedData.HasKey("bestSplits") || loadedData["bestSplits"].GetType() != Json::Type::Array ){
            print("Invalid best splits data found for map: " + mapId);
            bestSplits = {};
        } else {
            bestSplits = DataManager::JsonToArray(loadedData["bestSplits"]);
        }

        print("Loaded PB data for map: " + mapId);
    }

    void ClearPbAndBestSplits() {
        pbSplits = {};
        bestSplits = {};
        print("PB and best splits cleared.");
    }

    void HandleCheckPoint() {
        uint time = Timer::GetRunTime();
        currentSplits.InsertLast(time);
        print("CP: " + time);
    }

    void HandleReset() {
        if (CheckBestSplits()) {
            SaveMapData();
        }
        currentSplits = {};
        print("Run reset");
    }

    void HandleFinish() {
        bool saveMapData = false;

        HandleCheckPoint();

        if (pbSplits.Length == 0 || ( currentSplits.Length > 0 && currentSplits[currentSplits.Length - 1] < pbSplits[pbSplits.Length - 1])) {
            pbSplits = currentSplits;
            saveMapData = true;
            print("New PB!");
        }

        if (CheckBestSplits()) {
            saveMapData = true;
        }

        if (saveMapData) {
            SaveMapData();
        }
    }

    bool CheckBestSplits() {
        if (currentSplits.Length == 0) return false;

        bool newBest = false;

        if (bestSplits.Length == 0) {
            bestSplits = currentSplits;
            newBest = true;
        } else {
            for (uint i = 0; i < currentSplits.Length; i++) {
                if (currentSplits[i] < bestSplits[i]) {
                    bestSplits[i] = currentSplits[i];
                    newBest = true;
                }
            }
        }

        if (newBest) {
            print("New best splits set!");
        }

        return newBest;
    }

    void SaveMapData() {
        Json::Value newMapData = Json::Object();

        Json::Value pbSplitsJson = DataManager::ArrayToJson(pbSplits);
        Json::Value bestSplitsJson = DataManager::ArrayToJson(bestSplits);

        if (pbSplitsJson.GetType() == Json::Type::Array && bestSplitsJson.GetType() == Json::Type::Array) {
            newMapData["pbSplits"] = pbSplitsJson;
            newMapData["bestSplits"] = bestSplitsJson;

            @mapData = DataManager("map_" + mapId);
            mapData.SaveData(newMapData);
            print("Map data saved successfully.");
        } else {
            print("Error converting splits to JSON.");
        }
    }
}