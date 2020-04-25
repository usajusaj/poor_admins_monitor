//
// Created by matej on 4/24/20.
//

#include "DashCtrl.h"

using namespace std;

void DashCtrl::asyncHandleHttpRequest(
        const HttpRequestPtr &req,
        std::function<void(const HttpResponsePtr &)> &&callback) {
    HttpViewData data;
    data.insert("title", "Poor Admin's Monitor");

    auto clientPtr = drogon::app().getDbClient();
    clientPtr->execSqlAsync(
            "SELECT id, name FROM device",
            [callback, data](const orm::Result &r) mutable {
                unordered_map<int, string> devices;

                for (const auto &row : r) {
                    devices[row["id"].as<int>()] = row["name"].as<string>();
                }

                data.insert("devices", devices);

                auto res = drogon::HttpResponse::newHttpViewResponse("DashView", data);
                callback(res);
            },
            [callback, data](const orm::DrogonDbException &e) {
                auto res = drogon::HttpResponse::newHttpViewResponse("DashView", data);
                callback(res);
            });
}