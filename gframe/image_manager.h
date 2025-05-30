#ifndef IMAGEMANAGER_H
#define IMAGEMANAGER_H

#ifndef _OPENMP
#define YGOPRO_USE_THUMB_LOAD_THREAD
#endif

#include "config.h"
#include "data_manager.h"
#include <unordered_map>
#ifdef YGOPRO_USE_THUMB_LOAD_THREAD
#include <queue>
#include <mutex>
#endif

namespace ygo {

class ImageManager {
public:
	std::vector<std::wstring> ImageList[7];
	int saved_image_id[7];
	bool Initial();
	//random image
	irr::video::ITexture* GetRandomImage(int image_type);
	irr::video::ITexture* GetRandomImage(int image_type, irr::s32 width, irr::s32 height);
	void RefreshRandomImageList();
	void RefreshImageDir(std::wstring path, int image_type);
	void SetDevice(irr::IrrlichtDevice* dev);
	void ClearTexture();
	void RemoveTexture(int code);
	void ResizeTexture();
	irr::video::ITexture* GetTextureFromFile(const char* file, irr::s32 width, irr::s32 height);
	irr::video::ITexture* GetTexture(int code, bool fit = false);
	irr::video::ITexture* GetBigPicture(int code, float zoom);
	irr::video::ITexture* GetTextureThumb(int code);
	irr::video::ITexture* GetTextureField(int code);
#ifdef YGOPRO_USE_THUMB_LOAD_THREAD
	static int LoadThumbThread();
#endif

	std::unordered_map<int, irr::video::ITexture*> tMap[2];
	std::unordered_map<int, irr::video::ITexture*> tThumb;
	std::unordered_map<int, irr::video::ITexture*> tFields;
#ifdef YGOPRO_USE_THUMB_LOAD_THREAD
	std::unordered_map<int, irr::video::IImage*> tThumbLoading;
	std::queue<int> tThumbLoadingCodes;
	std::mutex tThumbLoadingMutex;
	bool tThumbLoadingThreadRunning;
#endif
	irr::IrrlichtDevice* device;
	irr::video::IVideoDriver* driver;
	irr::video::ITexture* tCover[4];
	irr::video::ITexture* tUnknown;
	irr::video::ITexture* tUnknownFit;
	irr::video::ITexture* tUnknownThumb;
	irr::video::ITexture* tBigPicture;
#ifdef YGOPRO_USE_THUMB_LOAD_THREAD
	irr::video::ITexture* tLoading;
#endif
	irr::video::ITexture* tAct;
	irr::video::ITexture* tAttack;
	irr::video::ITexture* tNegated;
	irr::video::ITexture* tChain;
	irr::video::ITexture* tNumber;
	irr::video::ITexture* tLPFrame;
	irr::video::ITexture* tLPBar;
	irr::video::ITexture* tMask;
	irr::video::ITexture* tEquip;
	irr::video::ITexture* tTarget;
	irr::video::ITexture* tChainTarget;
	irr::video::ITexture* tLim;
	irr::video::ITexture* tOT;
	irr::video::ITexture* tHand[3];
	irr::video::ITexture* tBackGround;
	irr::video::ITexture* tBackGround_menu;
	irr::video::ITexture* tBackGround_deck;
	irr::video::ITexture* tCardType;
	irr::video::ITexture* tField[2];
	irr::video::ITexture* tFieldTransparent[2];
	irr::video::ITexture* tRScale[14];
	irr::video::ITexture* tLScale[14];
	irr::video::ITexture* tClock;
};

extern ImageManager imageManager;

}

#endif // IMAGEMANAGER_H
