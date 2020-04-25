#pragma once

#include <drogon/HttpSimpleController.h>

using namespace drogon;

class DashCtrl : public drogon::HttpSimpleController<DashCtrl> {
public:
    void asyncHandleHttpRequest(
            const HttpRequestPtr &req,
            std::function<void(const HttpResponsePtr &)> &&callback) override;

    [[maybe_unused]] static void initPathRouting() {
        registerSelf__("/", {Get});
    }
};