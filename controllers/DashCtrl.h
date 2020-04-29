#pragma once

#include <drogon/HttpController.h>

using namespace drogon;
using namespace std;

class DashCtrl : public drogon::HttpController<DashCtrl> {
public:
    [[maybe_unused]] static void initPathRouting() {
        registerMethod(&DashCtrl::dash,
                       "/",
                       {Get},
                       false,
                       "DeviceCtrl::dash");

        registerMethod(&DashCtrl::realtime,
                       "/rt",
                       {Get},
                       false,
                       "DeviceCtrl::realtime");
    }

    static void dash(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback);

    static void realtime(const HttpRequestPtr &req, function<void(const HttpResponsePtr &)> &&callback);
};