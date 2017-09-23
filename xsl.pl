use XML::LibXML;
use XML::LibXSLT;

print XML::LibXSLT -> new ()
	-> parse_stylesheet (XML::LibXML -> load_xml (location => $ARGV [0]))
	-> transform        (XML::LibXML -> load_xml (IO => STDIN))
	-> toString (2)