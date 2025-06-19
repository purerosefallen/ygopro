#ifndef DECKMANAGER_H
#define DECKMANAGER_H

#include <unordered_map>
#include <vector>
#include <sstream>
#include "data_manager.h"
#include "bufferio.h"

#ifndef YGOPRO_MAX_DECK
#define YGOPRO_MAX_DECK					60
#endif

#ifndef YGOPRO_MIN_DECK
#define YGOPRO_MIN_DECK					40
#endif

#ifndef YGOPRO_MAX_EXTRA
#define YGOPRO_MAX_EXTRA					15
#endif

#ifndef YGOPRO_MAX_SIDE
#define YGOPRO_MAX_SIDE					15
#endif

namespace ygo {
	constexpr int DECK_MAX_SIZE = YGOPRO_MAX_DECK;
	constexpr int DECK_MIN_SIZE = YGOPRO_MIN_DECK;
	constexpr int EXTRA_MAX_SIZE = YGOPRO_MAX_EXTRA;
	constexpr int SIDE_MAX_SIZE = YGOPRO_MAX_SIDE;
	constexpr int PACK_MAX_SIZE = 1000;

struct LFList {
	unsigned int hash{};
	std::wstring listName;
	std::unordered_map<unsigned int, int> content;
};
struct Deck {
	std::vector<code_pointer> main;
	std::vector<code_pointer> extra;
	std::vector<code_pointer> side;
	Deck() = default;
	Deck(const Deck& ndeck) {
		main = ndeck.main;
		extra = ndeck.extra;
		side = ndeck.side;
	}
	void clear() {
		main.clear();
		extra.clear();
		side.clear();
	}
};

struct DeckArray {
	std::vector<uint32_t> main;
	std::vector<uint32_t> extra;
	std::vector<uint32_t> side;
};

class DeckManager {
public:
	Deck current_deck;
	std::vector<LFList> _lfList;

	static char deckBuffer[0x10000];

	void LoadLFListSingle(const char* path, bool insert = false);
	void LoadLFListSingle(const wchar_t* path, bool insert = false);
	void LoadLFListSingle(irr::io::IReadFile* reader, bool insert = false);
	void LoadLFList();
	const wchar_t* GetLFListName(unsigned int lfhash);
	const LFList* GetLFList(unsigned int lfhash);
	unsigned int CheckDeck(const Deck& deck, unsigned int lfhash, int rule);
	bool LoadCurrentDeck(const wchar_t* file, bool is_packlist = false);
	bool LoadCurrentDeck(int category_index, const wchar_t* category_name, const wchar_t* deckname);
	bool LoadCurrentDeck(std::istringstream& deckStream, bool is_packlist = false);
	wchar_t DeckFormatBuffer[128];
	int TypeCount(std::vector<code_pointer> list, unsigned int ctype);
	bool LoadDeckFromCode(Deck& deck, const unsigned char *code, int len);
	int SaveDeckToCode(Deck &deck, unsigned char *code);

	static uint32_t LoadDeck(Deck& deck, uint32_t dbuf[], int mainc, int sidec, bool is_packlist = false);
	static uint32_t LoadDeckFromStream(Deck& deck, std::istringstream& deckStream, bool is_packlist = false);
	static bool LoadSide(Deck& deck, uint32_t dbuf[], int mainc, int sidec);
	static void GetCategoryPath(wchar_t* ret, int index, const wchar_t* text);
	static void GetDeckFile(wchar_t* ret, int category_index, const wchar_t* category_name, const wchar_t* deckname);
	static FILE* OpenDeckFile(const wchar_t* file, const char* mode);
	static irr::io::IReadFile* OpenDeckReader(const wchar_t* file);
	static bool SaveDeck(const Deck& deck, const wchar_t* file);
	static void SaveDeck(const Deck& deck, std::stringstream& deckStream);
	static bool DeleteDeck(const wchar_t* file);
	static bool CreateCategory(const wchar_t* name);
	static bool RenameCategory(const wchar_t* oldname, const wchar_t* newname);
	static bool DeleteCategory(const wchar_t* name);
	static bool SaveDeckArray(const DeckArray& deck, const wchar_t* name);

private:
	template<typename LineProvider>
	void _LoadLFListFromLineProvider(LineProvider getLine, bool insert = false) {
		std::vector<LFList> loadedLists;
		auto cur = loadedLists.rend(); // 注意：在临时 list 上操作
		char line[256]{};
		wchar_t strBuffer[256]{};
		char str1[16]{};

		while (getLine(line, sizeof(line))) {
			if (line[0] == '#')
				continue;
			if (line[0] == '!') {
				auto len = std::strcspn(line, "\r\n");
				line[len] = 0;
				BufferIO::DecodeUTF8(&line[1], strBuffer);
				LFList newlist;
				newlist.listName = strBuffer;
				newlist.hash = 0x7dfcee6a;
				loadedLists.push_back(newlist);
				cur = loadedLists.rbegin();
				continue;
			}
			if (cur == loadedLists.rend())
				continue;
			unsigned int code = 0;
			int count = -1;
			if (std::sscanf(line, "%10s%*[ ]%1d", str1, &count) != 2)
				continue;
			if (count < 0 || count > 2)
				continue;
			code = std::strtoul(str1, nullptr, 10);
			cur->content[code] = count;
			cur->hash = cur->hash ^ ((code << 18) | (code >> 14)) ^ ((code << (27 + count)) | (code >> (5 - count)));
		}

		if (insert) {
			_lfList.insert(_lfList.begin(), loadedLists.begin(), loadedLists.end());
		} else {
			_lfList.insert(_lfList.end(), loadedLists.begin(), loadedLists.end());
		}
	}
};

extern DeckManager deckManager;

}

#endif //DECKMANAGER_H
