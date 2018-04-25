To generate `sources.txt`, first run configure ffmpeg

	../src/configure

Then, generate `vars.txt` from config.asm

	awk '!($0 ~ "^;") {print $2}' config.asm >vars.txt

Build `sources.txt` from vars.txt and ffmpeg's `Makefile`s

	make -f sources.mk >../sources.txt

Finally, clean up what `./configure` left behind

	git clean -df .
