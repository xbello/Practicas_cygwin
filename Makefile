OUTPUT_DIR=output/
OUTPUT_FILE=$(OUTPUT_DIR)index.html

all:
	cat header.html > $(OUTPUT_FILE)
	markdown-calibre trucos.txt >> $(OUTPUT_FILE)
	cat header.html >> $(OUTPUT_FILE)
