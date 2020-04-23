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
        }

        static void list(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback);

        static void getDevice(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback, int p1);
    };
}
