#!/bin/bash
set -e
# REPLAY_NAME=$1
# VIDEO_NAME=$2
TMP_VIDEO_PATH=/tmp/tmp-record-video-$RANDOM.mp4
SOUND_SEQUENCE_FILE=/tmp/tmp-audio-sequence-$RANDOM.txt
WINDOW_WIDTH=$(grep window_width ./system_user.conf | grep -oP '\d+')
WINDOW_HEIGHT=$(grep window_height ./system_user.conf | grep -oP '\d+')
FFMPEG_EXEC=ffmpeg
rm -f "$VIDEO_NAME"
./ygopro --auto-record --unlimited-fps --sound-sequence "$SOUND_SEQUENCE_FILE" -r "$REPLAY_NAME" 2>&1 >/dev/null | "$FFMPEG_EXEC" -hwaccel cuda -r 60  -vcodec rawvideo -f rawvideo -pix_fmt rgb24 -s "${WINDOW_WIDTH}x${WINDOW_HEIGHT}" -i - -vcodec h264_nvenc "$TMP_VIDEO_PATH"
FFMPEG_PARAMS=$(python3 ./docker/get-ffmpeg-param.py "$TMP_VIDEO_PATH" "$SOUND_SEQUENCE_FILE" "$VIDEO_NAME")
echo "Audio FFMpeg params: $FFMPEG_PARAMS"
bash -c "$FFMPEG_EXEC $FFMPEG_PARAMS"
rm -f "$TMP_VIDEO_PATH" "$SOUND_SEQUENCE_FILE"
