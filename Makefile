all: ebin/ 
	./rebar compile
#	(cd src;$(MAKE) all)
	(cd site;$(MAKE) all)

edoc:
	(cd src;$(MAKE) edoc)

test:
	(cd src;$(MAKE) test)

clean:
	./rebar clean
#	(cd src;$(MAKE) clean)
	(cd site;$(MAKE) clean)

clean_plt:
	(cd src;$(MAKE) clean_plt)

dialyzer:
	(cd src;$(MAKE) dialyzer)

ebin/:
	@mkdir -p ebin
