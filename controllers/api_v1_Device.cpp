#include "api_v1_Device.h"

using namespace api::v1;
using namespace std;

/*
 * List all known devices
 */
void Device::list(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback) {
    auto clientPtr = drogon::app().getDbClient();
    clientPtr->execSqlAsync(
            "SELECT id, name, datetime(last_ts,'localtime'), last_reading FROM device",
            [callback](const orm::Result &r) {
                Json::Value ret;

                int i = 0;
                for (const auto &row : r) {
                    ret["devices"][i]["id"] = row["id"].as<int>();
                    ret["devices"][i]["name"] = row["name"].as<string>();
                    i++;
                }

                callback(HttpResponse::newHttpJsonResponse(ret));
            },
            [callback](const orm::DrogonDbException &e) {
                Json::Value ret;
                ret["error"] = "Database error";
                callback(HttpResponse::newHttpJsonResponse(ret));
            });
}

/*
 * Get single device details
 */
void Device::getDevice(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1) {
    auto clientPtr = drogon::app().getDbClient();
    clientPtr->execSqlAsync(
            "SELECT id, name, datetime(last_ts, 'localtime'), last_reading FROM device WHERE id=?;",
            [callback](const orm::Result &r) {
                Json::Value ret;

                if (r.empty()) {
                    ret["error"] = "Device not found";
                } else {
                    const auto &row = r.front();

                    ret["device"]["id"] = row["id"].as<int>();
                    ret["device"]["name"] = row["name"].as<string>();
                    ret["device"]["time"] = row["last_ts"].as<string>();
                    ret["device"]["temperature"] = row["last_reading"].as<int>() / 1000.;
                }
                callback(HttpResponse::newHttpJsonResponse(ret));
            },
            [callback](const orm::DrogonDbException &e) {
                Json::Value ret;
                ret["error"] = "Database error";
                callback(HttpResponse::newHttpJsonResponse(ret));
            }, p1);
}

void
Device::historyRange(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1, int p2) {
    auto clientPtr = drogon::app().getDbClient();

    int limit = 100;
    if (p2 > 0) {
        limit = p2;
    }

    clientPtr->execSqlAsync(
            "SELECT device, datetime(ts, 'localtime') as ts, value FROM reading WHERE device=? ORDER BY ts DESC LIMIT " +
            to_string(limit),
            [callback](const orm::Result &r) {
                Json::Value ret;

                if (r.empty()) {
                    ret["error"] = "Device not found";
                } else {
                    int i = 0;
                    for (const auto &row : r) {
                        ret["device"]["id"] = row["device"].as<int>();
                        ret["device"]["history"][i]["ts"] = row["ts"].as<string>();
                        ret["device"]["history"][i]["t"] = row["value"].as<int>() / 1000.;
                        i++;
                    }
                }
                callback(HttpResponse::newHttpJsonResponse(ret));
            },
            [callback](const orm::DrogonDbException &e) {
                Json::Value ret;
                ret["error"] = "Database error";
                callback(HttpResponse::newHttpJsonResponse(ret));
            }, p1);
}

void Device::history(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1) {
    Device::historyRange(req, move(callback), p1, 100);
}