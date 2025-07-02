#include "serverapi.h"
#include "game.h"
#include "netserver.h"
#include "network.h"
#include "config.h"
#include "data_manager.h"
#include "gframe.h"
#include <event2/thread.h>
#include <memory>

namespace ygo {
	YGOSERVER_API int start_server(const char* args) {
		int argc = 1;
		char** argv = new char* [13];
		const char* server_name = "ygoserver";
		argv[0] = new char[strlen(server_name) + 1];
		strcpy(argv[0], server_name);
		size_t argLength = strlen(args);
		for (size_t i = 1, j = 0; j < argLength; ) {
			while (args[j] == ' ' && j < argLength) { ++j; }
			if (j < argLength) {
				size_t tokenLength = 0;
				while (args[j + tokenLength] != ' ' && args[j + tokenLength] != '\0') { ++tokenLength; }

				char* currentToken = new char[tokenLength + 1];
				strncpy(currentToken, args + j, tokenLength);
				currentToken[tokenLength] = '\0';

				argv[i] = currentToken;
				i++;
				j += tokenLength;
				argc++;
			}
		}

		int result = main(argc, argv);
		for (int i = 1; i < argc; ++i) {
			if (argv[i]) {
				delete[] argv[i];
				argv[i] = nullptr;
			}
		}
		delete[] argv;

		return result;
	}
	YGOSERVER_API void stop_server() {
		NetServer::StopServer();
	}
}
