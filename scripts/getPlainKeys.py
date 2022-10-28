from pathlib import Path
import re

configPath = str(Path.home())+"/.config/awesome/"
fileContent = open(configPath + "keymaps.lua").read()
keySaveFile = open(configPath+"plainKeys","w")


# x = re.compile('awful.key\({\s*(.*)\s*},\s*"(.*)"\s*,(.*)\n(\s*{description\s*=\s*"(.*)"\s*,\s*group\s*=\s*"(.*)"}),?',re.M)

# x = re.compile('awful.key\(\n\s*{(.*)},\s*"(.*)"\s*,\s*function\(\)\s*\n(.*\n)*.*end,\n\s*{description="(.*)",\s*group="(.*)"}',flags=re.M)


x = re.compile('awful.key\(\n\s*{(.*)},\s*"(.*)"(?:.|\n)*?{\s*description\s*=\s*"(.*)"\s*,\s*group\s*=\s*"(.*)"\s*}')

y = x.findall(fileContent)

s = ""

y.sort(key=lambda x:x[3])

for i in y:
    col1 = re.sub(',','+',i[0]).strip()
    s += f"{col1}+{i[1]}{' '*(30-len(col1)-len(i[1]))}{i[2]}{' '*(50-len(i[2]))}{i[3]}\n"


keySaveFile.write(s)
