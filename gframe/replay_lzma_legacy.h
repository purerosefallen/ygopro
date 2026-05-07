#pragma once

#include <cstdint>
#include <cstring>
#include <vector>

#include <lzma.h>

namespace ygo {

#ifndef LZMA_FILTER_LZMA1EXT
inline lzma_ret DecodeLegacyReplayLzmaAlone(const uint8_t* props, const uint8_t* input, size_t input_size, uint8_t* output, size_t output_size, size_t& output_pos) {
	output_pos = 0;
	std::vector<uint8_t> lzma_data(13 + input_size);
	std::memcpy(lzma_data.data(), props, 5);
	const auto unpacked_size = static_cast<uint64_t>(output_size);
	for(size_t i = 0; i < 8; ++i)
		lzma_data[5 + i] = static_cast<uint8_t>((unpacked_size >> (i * 8)) & 0xff);
	std::memcpy(lzma_data.data() + 13, input, input_size);

	lzma_stream strm = LZMA_STREAM_INIT;
	lzma_ret lret = lzma_alone_decoder(&strm, UINT64_MAX);
	if(lret != LZMA_OK)
		return lret;
	strm.next_in = lzma_data.data();
	strm.avail_in = lzma_data.size();
	strm.next_out = output;
	strm.avail_out = output_size;
	while(lret == LZMA_OK) {
		const auto prev_in = strm.total_in;
		const auto prev_out = strm.total_out;
		lret = lzma_code(&strm, LZMA_FINISH);
		if(lret == LZMA_OK && prev_in == strm.total_in && prev_out == strm.total_out) {
			lret = LZMA_BUF_ERROR;
			break;
		}
	}
	output_pos = static_cast<size_t>(strm.total_out);
	lzma_end(&strm);
	if(lret == LZMA_STREAM_END && output_pos == output_size)
		return LZMA_OK;
	return lret == LZMA_STREAM_END ? LZMA_DATA_ERROR : lret;
}
#endif

}
