#!/usr/bin/env zx

import { tmpdir } from "os";

const [scriptName, source, target] = argv._;

const {} = path.parse(source);

const colorSubset = path.join(tmpdir, "color-subset.png");
const colorSubsetOperation = $`ffmpeg -i ${source} -vf palettegen=max_colors=256 ${colorSubset}`;
$`open ${colorSubset}`;

zx`ffmpeg -i bottom-sheet.mov -i palette.png -ss 15 -t 15 -filter_complex "scale=1105:-1:flags=lanczos[x];[x][1:v]paletteuse" -r 30 ${target}.gif`;
