use XML::LibXML;
use XML::LibXSLT;

my $doc = XML::LibXSLT -> new ()
	-> parse_stylesheet (XML::LibXML -> load_xml (location => $ARGV [0]))
	-> transform        (XML::LibXML -> load_xml (IO => STDIN));
	
$doc -> documentElement () -> setNamespace ('http://www.w3.org/1999/XSL/Transform', 'xsl', 0);

print $doc -> toString (2);