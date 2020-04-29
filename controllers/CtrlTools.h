//
// Created by matej on 4/28/20.
//
#pragma once

#include <drogon/HttpViewData.h>

using namespace drogon;
using namespace std;

class CtrlTools {
    HttpViewData data;

public:
    unordered_map<string, vector<string>> media;

    explicit CtrlTools(const string& titleSuffix);
    void useCss(const string& styleSheet);
    void useJs(const string& script);

    HttpViewData getData();
};