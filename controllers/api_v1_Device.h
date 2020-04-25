#pragma once

#include <drogon/HttpController.h>

using namespace drogon;
using namespace std;

namespace api::v1 {
    class Device : public drogon::HttpController<Device> {
    public:
        [[maybe_unused]] static void initPathRouting() {
            registerMethod(&Device::list,
                           "/list",
                           {Get},
                           true,
                           "Device::list");

            registerMethod(&Device::getDevice,
                           "/get/{device_id}",
                           {Get},
                           true,
                           "Device::getDevice");

            registerMethod(&Device::history,
                           "/get/{device_id}/history",
                           {Get},
                           true,
                           "Device::history");

            registerMethod(&Device::historyRange,
                           "/get/{device_id}/history?minutes={minutes}",
                           {Get},
                           true,
                           "Device::historyRange");
        }

        static void list(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback);

        static void getDevice(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1);

        static void
        historyRange(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1, int p2);

        static void history(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1);
    };
}
