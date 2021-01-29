#!/usr/bin/python3
import sys
from string import Template

videoFilename = sys.argv[1]
sequenceFilename = sys.argv[2]
targetFilename = sys.argv[3]
commands = ["-i", '"' + videoFilename + '"']
commandFirstPart = '"'
#commandSecondPart = '[0]'
commandSecondPart = ''

sequenceFile = open(sequenceFilename, "r")

def parseSoundLine(frame, soundName, sequence):
  global commandFirstPart, commandSecondPart
  ms = frame * 1000 / 60
  soundFilename = Template('"./sound/${soundName}.wav"').substitute(soundName=soundName)
  commands.append('-i')
  commands.append(soundFilename)
  commandFirstPart += Template("[${sequence}]volume=50dB[audioext${sequence}];[audioext${sequence}]adelay=${ms}|${ms}[audiodelay${sequence}];").substitute(sequence=sequence, ms=ms)
  commandSecondPart += Template("[audiodelay${sequence}]").substitute(sequence=sequence)

sequence = 1
while True:
  line = sequenceFile.readline()
  if not line:
    break
  lineObj = line.split(' ')
  parseSoundLine(frame=int(lineObj[0]), soundName=lineObj[1].strip(), sequence=sequence)
  sequence += 1

commands.append("-filter_complex")
commandSecondPart += Template('amix=inputs=${soundCount}[aout]"').substitute(soundCount=sequence - 1)
commandFirstPart += commandSecondPart
commands.append(commandFirstPart)
#commands.append("-map")
#commands.append('0:v')
commands.append("-c:v")
commands.append("copy")
commands.append("-map")
commands.append('0:v')
commands.append("-map")
commands.append('"[aout]"')
commands.append('"' + targetFilename + '"')
print(' '.join(commands))
