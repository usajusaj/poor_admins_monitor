//
// Created by matej on 4/24/20.
//

#include "DashCtrl.h"
#include "CtrlTools.h"

using namespace std;

void DashCtrl::dash(
        const HttpRequestPtr &req,
        std::function<void(const HttpResponsePtr &)> &&callback) {
    CtrlTools ctrlData ("");
    ctrlData.useJs("/static/js/Chart.bundle.min.js");
    ctrlData.useJs("/static/js/pam-chart.js");

    auto clientPtr = drogon::app().getDbClient();
    clientPtr->execSqlAsync(
            "SELECT id, name FROM device",
            [callback, ctrlData](const orm::Result &r) mutable {
                unordered_map<int, string> devices;

                for (const auto &row : r) {
                    devices[row["id"].as<int>()] = row["name"].as<string>();
                }

                auto data = ctrlData.getData();

                data.insert("devices", devices);

                auto res = drogon::HttpResponse::newHttpViewResponse("DashView", data);
                callback(res);
            },
            [callback, ctrlData](const orm::DrogonDbException &e) mutable {
                auto res = drogon::HttpResponse::newHttpViewResponse("DashView", ctrlData.getData());
                callback(res);
            });
}

void DashCtrl::realtime(
        const HttpRequestPtr &req,
        std::function<void(const HttpResponsePtr &)> &&callback) {
    CtrlTools ctrlData ("Real-time");
    ctrlData.useJs("/static/js/pam-rt.js");

    auto clientPtr = drogon::app().getDbClient();
    clientPtr->execSqlAsync(
            "SELECT id, name FROM device",
            [callback, ctrlData](const orm::Result &r) mutable {
                unordered_map<int, string> devices;

                for (const auto &row : r) {
                    devices[row["id"].as<int>()] = row["name"].as<string>();
                }

                auto data = ctrlData.getData();

                data.insert("device_list", devices);

                auto res = drogon::HttpResponse::newHttpViewResponse("RealTimeView", data);
                callback(res);
            },
            [callback, ctrlData](const orm::DrogonDbException &e) mutable {
                auto res = drogon::HttpResponse::newHttpViewResponse("RealTimeView", ctrlData.getData());
                callback(res);
            });
}