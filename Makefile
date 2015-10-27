INPUT_FILES=resources/
STATIC=$(INPUT_FILES)css $(INPUT_FILES)js $(INPUT_FILES)fonts

SRC_DIR=source/
OUTPUT_DIR=output/

all: $(SRC_DIR)*.md
	$(eval TMP_OUT=$(patsubst $(SRC_DIR)%.md,$(OUTPUT_DIR)%.html,$?))
	cat $(INPUT_FILES)header.html > $(TMP_OUT)
	markdown_py $? -x toc >> $(TMP_OUT)
	cat $(INPUT_FILES)footer.html >> $(TMP_OUT)
	$(MAKE) copy_static

copy_static:
	cp $(STATIC) $(OUTPUT_DIR) -r
