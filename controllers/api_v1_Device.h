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
                           "/get/{}",
                           {Get},
                           true,
                           "Device::getDevice");

            registerMethod(&Device::history,
                           "/get/{}/history",
                           {Get},
                           true,
                           "Device::history");
        }

        static void list(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback);

        static void getDevice(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1);

        static void history(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1);
    };
}
