#include "serverapi.h"

namespace ygo {
	extern "C" DECL_DLLEXPORT int start_server(const char* args) {
		int argc = 1;
		char** argv = new char* [13];
		argv[0] = "ygoserver";
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
		delete[] argv;

		return result;
	}
	extern "C" DECL_DLLEXPORT void stop_server() {
		NetServer::StopServer();
	}
}
