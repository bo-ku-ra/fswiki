############################################################
#
# 【自作】一覧っぽい一覧表示
#
############################################################
package plugin::pagelist::Install;
use strict;

sub install {
	my $wiki = shift;
	$wiki->add_menu("一覧"  ,$wiki->config('script_name')."?action=PAGELIST",995.5);
	$wiki->add_handler("PAGELIST","plugin::pagelist::PageList");
}

1;
