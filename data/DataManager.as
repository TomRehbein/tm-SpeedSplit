class DataManager {
    string filename = "";
    Json::Value data = Json::Value();

    DataManager(const string &in _filename) {
        filename = _filename + ".json";
        data = LoadData();
    }

    void SaveData(const Json::Value &in newData) {
        data = newData;
        Json::ToFile(filename, data);
    }

    Json::Value LoadData() {
        if (!IO::FileExists(filename)) {
            error("File not found: " + filename);
            return Json::Value();
        }

        Json::Value newData = Json::FromFile(filename);
        if (newData.GetType() == Json::Type::Null) {
            error("Failed to parse JSON data from file: " + filename);
            return Json::Value();
        }

        print("Loaded data from file: " + filename);
        return newData;
    }

    void DeleteData() {
        if (!IO::FileExists(filename)) {
            error("File not found: " + filename);
            return;
        }

        IO::Delete(filename);
        data = Json::Value();
    }
}

namespace DataManager {
    DataManager@ Get(const string &in filename) {
        return DataManager(filename);
    }
}