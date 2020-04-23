#include "api_v1_Device.h"

using namespace api::v1;
using namespace std;

/*
 * List all known devices
 */
void Device::list(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback) {
    auto clientPtr = drogon::app().getDbClient();
    clientPtr->execSqlAsync(
            "SELECT id, name, last_ts, last_reading FROM device",
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
            "SELECT * FROM device WHERE id=?;",
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
