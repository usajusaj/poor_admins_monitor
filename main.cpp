#include <drogon/drogon.h>

int main(int argc, char** argv) {
    //Load config file
    std::string config = "../config.json";
    if (argc == 2) {
        config = argv[1];
    }

    drogon::app().loadConfigFile(config);
    drogon::app().run();
    return 0;
}
