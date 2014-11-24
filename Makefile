
# TODO: verify that constants.sh exists, if not gyuide user to create one
install:
	[ ! -f constants.sh ] && cp constants.sh.dist constants.sh && echo "ACHTUNG! Please tweak 'constants.sh' before continuing"
