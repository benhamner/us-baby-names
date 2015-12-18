
output/NationalNames.csv:
	mkdir -p output
	python src/national_names.py

output/StateNames.csv:
	mkdir -p output
	python src/state_names.py

csv: output/StateNames.csv output/NationalNames.csv

working/noHeader/NationalNames.csv: output/NationalNames.csv
	mkdir -p working/noHeader
	tail +2 $^ > $@

working/noHeader/StateNames.csv: output/StateNames.csv
	mkdir -p working/noHeader
	tail +2 $^ > $@

output/database.sqlite: working/noHeader/NationalNames.csv working/noHeader/StateNames.csv
	-rm output/database.sqlite
	sqlite3 -echo $@ < src/import.sql
db: output/database.sqlite

output/hashes.txt: output/database.sqlite output/NationalReadMe.pdf output/StateReadMe.pdf
	-rm output/hashes.txt
	echo "Current git commit:" >> output/hashes.txt
	git rev-parse HEAD >> output/hashes.txt
	echo "\nCurrent ouput md5 hashes:" >> output/hashes.txt
	md5 output/*.csv >> output/hashes.txt
	md5 output/*.sqlite >> output/hashes.txt
	md5 output/pdfs/*.pdf >> output/hashes.txt
hashes: output/hashes.txt

output/NationalReadMe.pdf: input/names/NationalReadMe.pdf
	cp $^ $@

output/StateReadMe.pdf: input/namesbystate/StateReadMe.pdf
	cp $^ $@
pdf: output/NationalReadMe.pdf output/StateReadMe.pdf

release: output/database.sqlite output/hashes.txt
	zip -r -X output/release-`date -u +'%Y-%m-%d-%H-%M-%S'` output/*

all: csv db hashes release

clean:
	rm -rf working
	rm -rf output
