INPUT_FILES=resources/
STATIC=$(INPUT_FILES)css $(INPUT_FILES)js $(INPUT_FILES)fonts

OUTPUT_DIR=output/
OUTPUT_FILE=$(OUTPUT_DIR)index.html

all:
	cat $(INPUT_FILES)header.html > $(OUTPUT_FILE)
	markdown_py trucos.txt -x toc >> $(OUTPUT_FILE)
	cat $(INPUT_FILES)footer.html >> $(OUTPUT_FILE)
	cp $(STATIC) $(OUTPUT_DIR) -r
