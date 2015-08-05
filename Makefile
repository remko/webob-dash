TARGET=WebOb.docset
DOCS=webob/docs
VERSION=$(shell git --git-dir=webob/.git describe --tags)

all:
	sphinx-build $(DOCS) html
	-rm -rf $(TARGET)
	doc2dash -n $(basename $(TARGET)) --index-page index.html html
	-rm -rf dist
	mkdir dist
	tar --exclude='.DS_Store' -cvzf dist/$(basename $(TARGET)).tgz $(TARGET)
	cat docset.json | sed -e "s/{version}/$(VERSION)/" > dist/docset.json

clean:
	-rm -rf $(TARGET) html dist

init:
	git submodule update --init
	pip install -q -r requirements.txt
