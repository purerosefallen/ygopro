#ifndef DUELCLIENT_H
#define DUELCLIENT_H

#include <vector>
#include <set>
#include <random>
#include "config.h"
#include "deck_manager.h"
#include "network.h"

namespace ygo {

class HostResult {
public:
	unsigned int host;
	unsigned short port;
	bool isValid() {
		return host > 0 && port > 0;
	}
	HostResult() {
		host = 0;
		port = 0;
	}
};

#ifndef _WIN32
#include <resolv.h>
#include <arpa/nameser.h>
#include <arpa/nameser_compat.h>
class RetrivedSRVRecord {
public:
	bool valid;
	unsigned short priority;
	unsigned short weight;
	unsigned short port;
	char host[100];
	RetrivedSRVRecord(ns_msg nsMsg, int i) {
		valid = false;
		ns_rr rr;
		if (ns_parserr(&nsMsg, ns_s_an, i, &rr) < 0 || ns_rr_type(rr) != T_SRV)
			return;
		priority = ns_get16(ns_rr_rdata(rr));
		weight   = ns_get16(ns_rr_rdata(rr) + NS_INT16SZ);
		port     = ns_get16(ns_rr_rdata(rr) + 2 * NS_INT16SZ);
		if (dn_expand(ns_msg_base(nsMsg), ns_msg_end(nsMsg), ns_rr_rdata(rr) + 3 * NS_INT16SZ, host, sizeof(host)) < 0)
			return;
		valid = true;
	}
};
#endif

class DuelClient {
private:
	static unsigned int connect_state;
	static unsigned char response_buf[SIZE_RETURN_VALUE];
	static size_t response_len;
	static unsigned int watching;
	static bool is_host;
	static event_base* client_base;
	static bufferevent* client_bev;
	static unsigned char duel_client_write[SIZE_NETWORK_BUFFER];
	static bool is_closing;
	static bool is_swapping;
	static int select_hint;
	static int select_unselect_hint;
	static int last_select_hint;
	static unsigned char last_successful_msg[SIZE_NETWORK_BUFFER];
	static size_t last_successful_msg_length;
	static wchar_t event_string[256];
	static std::mt19937 rnd;
	static std::uniform_real_distribution<float> real_dist;
	static bool is_refreshing;
	static int match_kill;
	static event* resp_event;
	static std::set<std::pair<unsigned int, unsigned short>> remotes;

public:
	static unsigned int temp_ip;
	static unsigned short temp_port;
	static unsigned short temp_ver;
	static bool try_needed;
	static unsigned char selftype;
	static bool StartClient(unsigned int ip, unsigned short port, bool create_game = true);
	static void ConnectTimeout(evutil_socket_t fd, short events, void* arg);
	static void StopClient(bool is_exiting = false);
	static void ClientRead(bufferevent* bev, void* ctx);
	static void ClientEvent(bufferevent* bev, short events, void* ctx);
	static int ClientThread();
	static void HandleSTOCPacketLan(unsigned char* data, int len);
	static bool ClientAnalyze(unsigned char* msg, int len);
	static void SwapField();
	static void SetResponseI(int32_t respI);
	static void SetResponseB(void* respB, size_t len);
	static void SendResponse();
	static void SendUpdateDeck(const Deck& deck);
	static unsigned int LookupHost(char *host);
	static bool LookupSRV(char *hostname, HostResult* result);
	static bool CheckHostnameSplitter(char *hostname, HostResult *result);
	static HostResult ParseHost(char *hostname);
	static void SendPacketToServer(unsigned char proto) {
		auto p = duel_client_write;
		BufferIO::Write<uint16_t>(p, 1);
		BufferIO::Write<uint8_t>(p, proto);
#ifdef YGOPRO_MESSAGE_DEBUG
		printf("CTOS: %d\n", proto);
#endif
		bufferevent_write(client_bev, duel_client_write, 3);
	}
	template<typename ST>
	static void SendPacketToServer(unsigned char proto, const ST& st) {
		auto p = duel_client_write;
		static_assert(sizeof(ST) <= MAX_DATA_SIZE, "Packet size is too large.");
		BufferIO::Write<uint16_t>(p, (uint16_t)(1 + sizeof(ST)));
		BufferIO::Write<uint8_t>(p, proto);
		std::memcpy(p, &st, sizeof(ST));
#ifdef YGOPRO_MESSAGE_DEBUG
		printf("CTOS: %d Length: %ld\n", proto, sizeof(ST));
#endif
		bufferevent_write(client_bev, duel_client_write, sizeof(ST) + 3);
	}
	static void SendBufferToServer(unsigned char proto, void* buffer, size_t len) {
		auto p = duel_client_write;
		if (len > MAX_DATA_SIZE)
			len = MAX_DATA_SIZE;
		BufferIO::Write<uint16_t>(p, (uint16_t)(1 + len));
		BufferIO::Write<uint8_t>(p, proto);
		std::memcpy(p, buffer, len);
#ifdef YGOPRO_MESSAGE_DEBUG
		printf("CTOS: %d Length: %ld\n", proto, len);
#endif
		bufferevent_write(client_bev, duel_client_write, len + 3);
	}

	static std::vector<std::wstring> hosts;
	static std::vector<std::wstring> hosts_srvpro;
	static bool is_srvpro;
	static void BeginRefreshHost();
	static int RefreshThread(event_base* broadev);
	static void BroadcastReply(evutil_socket_t fd, short events, void* arg);
};
}

#endif //DUELCLIENT_H
