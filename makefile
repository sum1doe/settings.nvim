make:
	echo "Default in case you accidentally just run make. Options are upload, download and clean"

yoink:
	cp -r ../lua/ .
	cp ../init.lua .

yeet:
	cp -r ./lua/ ../lua/
	cp -r init.lua ../.

upload: yoink
	git add .
	git commit *
	git push

download: yeet
	git pull

clean:
	rm -r lua/
	rm init.lua

