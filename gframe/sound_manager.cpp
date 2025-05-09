#include "sound_manager.h"
#include "myfilesystem.h"
#if defined(YGOPRO_USE_MINIAUDIO) && defined(YGOPRO_MINIAUDIO_SUPPORT_OPUS_VORBIS)
#include <miniaudio_libopus.h>
#include <miniaudio_libvorbis.h>
#endif
#ifdef IRRKLANG_STATIC
#include "../ikpmp3/ikpMP3.h"
#endif

namespace ygo {

SoundManager soundManager;

bool SoundManager::Init() {
#ifdef YGOPRO_USE_AUDIO
	bgm_scene = -1;
	previous_bgm_scene = -1;
	RefreshBGMList();
	bgm_process = false;
	rnd.reset((unsigned int)std::time(nullptr));
#ifdef YGOPRO_USE_MINIAUDIO
	engineConfig = ma_engine_config_init();
#ifdef YGOPRO_MINIAUDIO_SUPPORT_OPUS_VORBIS
	ma_decoding_backend_vtable* pCustomBackendVTables[] =
	{
		ma_decoding_backend_libvorbis,
		ma_decoding_backend_libopus
	};
	resourceManagerConfig = ma_resource_manager_config_init();
	resourceManagerConfig.ppCustomDecodingBackendVTables = pCustomBackendVTables;
	resourceManagerConfig.customDecodingBackendCount = sizeof(pCustomBackendVTables) / sizeof(pCustomBackendVTables[0]);
	resourceManagerConfig.pCustomDecodingBackendUserData = NULL;
	if(ma_resource_manager_init(&resourceManagerConfig, &resourceManager) != MA_SUCCESS) {
		return false;
	}
	engineConfig.pResourceManager = &resourceManager;
#endif
	if(ma_engine_init(&engineConfig, &engineSound) != MA_SUCCESS || ma_engine_init(&engineConfig, &engineMusic) != MA_SUCCESS) {
		return false;
	} else {
		return true;
	}
#endif // YGOPRO_USE_MINIAUDIO
#ifdef YGOPRO_USE_IRRKLANG
	engineSound = irrklang::createIrrKlangDevice();
	engineMusic = irrklang::createIrrKlangDevice();
	if(!engineSound || !engineMusic) {
		return false;
	} else {
#ifdef IRRKLANG_STATIC
		irrklang::ikpMP3Init(engineMusic);
#endif
		return true;
	}
#endif // YGOPRO_USE_IRRKLANG
#endif // YGOPRO_USE_AUDIO
	return false;
}
void SoundManager::RefreshBGMList() {
#ifdef YGOPRO_USE_AUDIO
	RefershBGMDir(L"", BGM_DUEL);
	RefershBGMDir(L"duel", BGM_DUEL);
	RefershBGMDir(L"menu", BGM_MENU);
	RefershBGMDir(L"deck", BGM_DECK);
	RefershBGMDir(L"advantage", BGM_ADVANTAGE);
	RefershBGMDir(L"disadvantage", BGM_DISADVANTAGE);
	RefershBGMDir(L"win", BGM_WIN);
	RefershBGMDir(L"lose", BGM_LOSE);
	RefershBGMDir(L"custom", BGM_CUSTOM);
#endif
}
void SoundManager::RefershBGMDir(std::wstring path, int scene) {
	std::wstring search = L"./sound/BGM/" + path;
	FileSystem::TraversalDir(search.c_str(), [this, &path, scene](const wchar_t* name, bool isdir) {
		if(!isdir && (
			IsExtension(name, L".mp3")
#if defined(YGOPRO_MINIAUDIO_SUPPORT_OPUS_VORBIS) || defined(YGOPRO_USE_IRRKLANG)
			|| IsExtension(name, L".ogg")
#endif
			)) {
			std::wstring filename = path + L"/" + name;
			BGMList[BGM_ALL].push_back(filename);
			BGMList[scene].push_back(filename);
		}
	});
}
void SoundManager::PlaySound(char* sound) {
#ifdef YGOPRO_USE_AUDIO
	if(!mainGame->chkEnableSound->isChecked())
		return;
	SetSoundVolume(mainGame->gameConf.sound_volume);
#ifdef YGOPRO_USE_MINIAUDIO
	ma_sound *usingSoundEffectPointer = nullptr;
	for(int i = 0; i < 10; i++) {
		if(playingSoundEffect[i] && !ma_sound_is_playing(playingSoundEffect[i])) {
			ma_sound_uninit(playingSoundEffect[i]);
			if(usingSoundEffectPointer) {
				free(playingSoundEffect[i]);
				playingSoundEffect[i] = nullptr;
			} else {
				usingSoundEffectPointer = playingSoundEffect[i];
			}
		}
		if(!playingSoundEffect[i] && !usingSoundEffectPointer) {
			usingSoundEffectPointer = playingSoundEffect[i] = (ma_sound*)malloc(sizeof(ma_sound));
		}
	}
	if (!usingSoundEffectPointer) {
		// force to stop the first sound
		usingSoundEffectPointer = playingSoundEffect[0];
		ma_sound_uninit(usingSoundEffectPointer);
	}
#ifdef _WIN32
	wchar_t sound_w[1024];
	BufferIO::DecodeUTF8(sound, sound_w);
	ma_sound_init_from_file_w(&engineSound, sound_w, MA_SOUND_FLAG_ASYNC | MA_SOUND_FLAG_STREAM, nullptr, nullptr, usingSoundEffectPointer);
#else
	ma_sound_init_from_file(&engineSound, sound, MA_SOUND_FLAG_ASYNC | MA_SOUND_FLAG_STREAM, nullptr, nullptr, usingSoundEffectPointer);
#endif
	ma_sound_start(usingSoundEffectPointer);
#endif
#ifdef YGOPRO_USE_IRRKLANG
	engineSound->play2D(sound);
#endif
#endif
}
void SoundManager::PlaySoundEffect(int sound) {
#ifdef YGOPRO_USE_AUDIO
	if(!mainGame->chkEnableSound->isChecked())
		return;
	char soundName[32];
	switch(sound) {
	case SOUND_SUMMON: {
		strcpy(soundName, "summon");
		break;
	}
	case SOUND_SPECIAL_SUMMON: {
		strcpy(soundName, "specialsummon");
		break;
	}
	case SOUND_ACTIVATE: {
		strcpy(soundName, "activate");
		break;
	}
	case SOUND_SET: {
		strcpy(soundName, "set");
		break;
	}
	case SOUND_FILP: {
		strcpy(soundName, "flip");
		break;
	}
	case SOUND_REVEAL: {
		strcpy(soundName, "reveal");
		break;
	}
	case SOUND_EQUIP: {
		strcpy(soundName, "equip");
		break;
	}
	case SOUND_DESTROYED: {
		strcpy(soundName, "destroyed");
		break;
	}
	case SOUND_BANISHED: {
		strcpy(soundName, "banished");
		break;
	}
	case SOUND_TOKEN: {
		strcpy(soundName, "token");
		break;
	}
	case SOUND_NEGATE: {
		strcpy(soundName, "negate");
		break;
	}
	case SOUND_ATTACK: {
		strcpy(soundName, "attack");
		break;
	}
	case SOUND_DIRECT_ATTACK: {
		strcpy(soundName, "directattack");
		break;
	}
	case SOUND_DRAW: {
		strcpy(soundName, "draw");
		break;
	}
	case SOUND_SHUFFLE: {
		strcpy(soundName, "shuffle");
		break;
	}
	case SOUND_DAMAGE: {
		strcpy(soundName, "damage");
		break;
	}
	case SOUND_RECOVER: {
		strcpy(soundName, "gainlp");
		break;
	}
	case SOUND_COUNTER_ADD: {
		strcpy(soundName, "addcounter");
		break;
	}
	case SOUND_COUNTER_REMOVE: {
		strcpy(soundName, "removecounter");
		break;
	}
	case SOUND_COIN: {
		strcpy(soundName, "coinflip");
		break;
	}
	case SOUND_DICE: {
		strcpy(soundName, "diceroll");
		break;
	}
	case SOUND_NEXT_TURN: {
		strcpy(soundName, "nextturn");
		break;
	}
	case SOUND_PHASE: {
		strcpy(soundName, "phase");
		break;
	}
	case SOUND_MENU: {
		strcpy(soundName, "menu");
		break;
	}
	case SOUND_BUTTON: {
		strcpy(soundName, "button");
		break;
	}
	case SOUND_INFO: {
		strcpy(soundName, "info");
		break;
	}
	case SOUND_QUESTION: {
		strcpy(soundName, "question");
		break;
	}
	case SOUND_CARD_PICK: {
		strcpy(soundName, "cardpick");
		break;
	}
	case SOUND_CARD_DROP: {
		strcpy(soundName, "carddrop");
		break;
	}
	case SOUND_PLAYER_ENTER: {
		strcpy(soundName, "playerenter");
		break;
	}
	case SOUND_CHAT: {
		strcpy(soundName, "chatmessage");
		break;
	}
	default:
		break;
	}
	char soundPath[40];
	std::snprintf(soundPath, 40, "./sound/%s.wav", soundName);
	PlaySound(soundPath);
#endif // YGOPRO_USE_AUDIO
}
void SoundManager::PlayDialogSound(irr::gui::IGUIElement * element) {
	if(element == mainGame->wMessage) {
		PlaySoundEffect(SOUND_INFO);
	} else if(element == mainGame->wQuery) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wSurrender) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wOptions) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wANAttribute) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wANCard) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wANNumber) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wANRace) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wReplaySave) {
		PlaySoundEffect(SOUND_QUESTION);
	} else if(element == mainGame->wFTSelect) {
		PlaySoundEffect(SOUND_QUESTION);
	}
}
bool SoundManager::IsCurrentlyPlaying(char* song) {
#ifdef YGOPRO_USE_MINIAUDIO
	return currentPlayingMusic[0] && strcmp(currentPlayingMusic, song) == 0 && ma_sound_is_playing(&soundBGM);
#endif
#ifdef YGOPRO_USE_IRRKLANG
	return engineMusic->isCurrentlyPlaying(song);
#endif
	return false;
}
void SoundManager::PlayMusic(char* song, bool loop) {
#ifdef YGOPRO_USE_AUDIO
	if(!mainGame->chkEnableMusic->isChecked())
		return;
	if(!IsCurrentlyPlaying(song)) {
		StopBGM();
	SetMusicVolume(mainGame->gameConf.music_volume);
#ifdef YGOPRO_USE_MINIAUDIO
		strcpy(currentPlayingMusic, song);
#ifdef _WIN32
		wchar_t song_w[1024];
		BufferIO::DecodeUTF8(song, song_w);
		ma_sound_init_from_file_w(&engineMusic, song_w, MA_SOUND_FLAG_ASYNC | MA_SOUND_FLAG_STREAM, nullptr, nullptr, &soundBGM);
#else
		ma_sound_init_from_file(&engineMusic, song, MA_SOUND_FLAG_ASYNC | MA_SOUND_FLAG_STREAM, nullptr, nullptr, &soundBGM);
#endif
		ma_sound_set_looping(&soundBGM, loop);
		ma_sound_start(&soundBGM);
#endif
#ifdef YGOPRO_USE_IRRKLANG
		soundBGM = engineMusic->play2D(song, loop, false, true);
#endif
	}
#endif
}
void SoundManager::PlayBGM(int scene) {
#ifdef YGOPRO_USE_AUDIO
	if(!mainGame->chkEnableMusic->isChecked() || bgm_process)
		return;
	if(!mainGame->chkMusicMode->isChecked())
		scene = BGM_ALL;
	char BGMName[1024];
#if defined(YGOPRO_USE_MINIAUDIO)
	if((scene != bgm_scene) && (bgm_scene != BGM_CUSTOM) || (scene != previous_bgm_scene) && (bgm_scene == BGM_CUSTOM) || !IsCurrentlyPlaying(currentPlayingMusic)) {
#elif defined(YGOPRO_USE_IRRKLANG)
	if((scene != bgm_scene) && (bgm_scene != BGM_CUSTOM) || (scene != previous_bgm_scene) && (bgm_scene == BGM_CUSTOM) || (soundBGM && soundBGM->isFinished())) {
#endif
		int count = BGMList[scene].size();
		if(count <= 0)
			return;
		bgm_scene = scene;
		int bgm = rnd.get_random_integer(0, count -1);
		auto name = BGMList[scene][bgm].c_str();
		wchar_t fname[1024];
		myswprintf(fname, L"./sound/BGM/%ls", name);
		BufferIO::EncodeUTF8(fname, BGMName);
		PlayMusic(BGMName, false);
	}
#endif
}
void SoundManager::PlayCustomBGM(char* BGMName) {
#ifdef YGOPRO_USE_AUDIO
	if(!mainGame->chkEnableMusic->isChecked() || !mainGame->chkMusicMode->isChecked() || bgm_process || IsCurrentlyPlaying(BGMName))
		return;
	bgm_process = true;
	int pscene = bgm_scene;
	if (pscene != BGM_CUSTOM)
		previous_bgm_scene = pscene;
	bgm_scene = BGM_CUSTOM;
	PlayMusic(BGMName, false);
	bgm_process = false;
#endif
}
void SoundManager::PlayCustomSound(char* SoundName) {
	PlaySound(SoundName);
}
void SoundManager::StopBGM() {
#ifdef YGOPRO_USE_MINIAUDIO
	if(!currentPlayingMusic[0])
		return;
	memset(currentPlayingMusic, 0, sizeof(currentPlayingMusic));
	ma_sound_uninit(&soundBGM);
#endif
#ifdef YGOPRO_USE_IRRKLANG
	engineMusic->stopAllSounds();
#endif
}
void SoundManager::StopSound() {
#ifdef YGOPRO_USE_MINIAUDIO
	for(int i = 0; i < 10; i++) {
		if(playingSoundEffect[i]) {
			ma_sound_uninit(playingSoundEffect[i]);
			free(playingSoundEffect[i]);
			playingSoundEffect[i] = nullptr;
		}
	}
#endif
#ifdef YGOPRO_USE_IRRKLANG
	engineSound->stopAllSounds();
#endif
}
void SoundManager::SetSoundVolume(double volume) {
#ifdef YGOPRO_USE_MINIAUDIO
	ma_engine_set_volume(&engineSound, volume);
#endif
#ifdef YGOPRO_USE_IRRKLANG
	engineSound->setSoundVolume(volume);
#endif
}
void SoundManager::SetMusicVolume(double volume) {
#ifdef YGOPRO_USE_MINIAUDIO
	ma_engine_set_volume(&engineMusic, volume);
#endif
#ifdef YGOPRO_USE_IRRKLANG
	engineMusic->setSoundVolume(volume);
#endif
}
}
