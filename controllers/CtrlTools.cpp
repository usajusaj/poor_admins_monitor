//
// Created by matej on 4/28/20.
//

#include "CtrlTools.h"

CtrlTools::CtrlTools(const string &titleSuffix) {
    string title = "Poor Admin's Monitor";
    if (!titleSuffix.empty()) {
        title += " - " + titleSuffix;
    }

    data.insert("title", title);
    data.insert("js", vector<string>());
    data.insert("css", vector<string>());
}

void CtrlTools::useCss(const string &styleSheet){
    media["css"].push_back(styleSheet);
}

void CtrlTools::useJs(const string &script){
    media["js"].push_back(script);
}

HttpViewData CtrlTools::getData() {
    data.insert("js", media["js"]);
    data.insert("css", media["css"]);

    return data;
}
