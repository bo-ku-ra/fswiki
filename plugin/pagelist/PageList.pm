############################################################
# 
# ページ一覧っぽい一覧を表示するプラグイン
# 
############################################################
package plugin::pagelist::PageList;
#use strict;
#===========================================================
# コンストラクタ
#===========================================================
sub new {
	my $class = shift;
	my $self = {};
	return bless $self,$class;
}

#===========================================================
# アクションの実行
#===========================================================
sub do_action {
	my $self = shift;
	my $wiki = shift;
	$self->{once} = $wiki->config('pagelist');
	my $cgi = $wiki->get_CGI;
	
	$wiki->set_title("ページの一覧");
#	my @list = $wiki->get_page_list({-sort=>'last_modified',-permit=>'show'});
	my $cnt = $cgi->param("cnt");
	if($cnt eq ""){ $cnt = 0; }
	my $row = $cnt * $self->{once};
	
	my $content;
	
	#===========================================================
	# 一覧をアルファベット順に修正
	#===========================================================
	# 更新日時は recentプラグインの発展におまかせするとして、
	# 一覧では名前順の表示にしよう。（その方が見やすい）
	#
	# ユーザ定義スタイルに以下を設定しページ権限毎に表示色が変わる
	#
	# /* ページ参照権限 */
	# .adminpage {
	#   background-color : #ffcccc;
	# }
	#
	# .userpage {
	#   background-color : #ccccee;
	# }


	my @list = $wiki->get_page_list({-sort=>'name',-permit=>'show'});

	# FSWikiにとって特別な意味のあるページをまとめると便利だよね。（正規表現で指定）
	my $reserve = '(FrontPage|EditHelper|Menu|Header|Footer|InterWikiName|Help|Help/FSWiki|Help/YukiWiki|Keyword|Template/.*)';

	my %icontent;
	my $fscontent;

	foreach(@list){
	my $tmp;
	my $initial;
		if (substr(Util::escapeHTML($_),0,2) =~ /[\xA1-\xFE][\xA1-\xFE]/) {
		#全角だ(EUC)
		#$initial = substr(Util::escapeHTML($_),0,2);
		$initial = '日本語';
		} else {
			if ($str =~ /\x8E/) {
	 		#半角カナだ(EUC)
			#$initial = substr(Util::escapeHTML($_),0,1);
			$initial = '日本語';
			} else {
			#半角だ(EUC)
			$initial = substr(Util::escapeHTML($_),0,1);
			$initial =~ tr/[a-z]/[A-Z]/;
				if($initial =~ /\W/ || $initial =~ /\d/){ #英数字以外か数字にマッチしたら
				$initial = '数字・記号';
				}
			}
		}

	#ページの参照権限により表示を変えるため、classを与える。
	$tmp = 	Util::escapeHTML($_);
	my $page = $wiki->get_page_level($_);
	if($page == 2){$tmp = "<span class=\"adminpage\">$tmp</span>";}
	if($page == 1){$tmp = "<span class=\"userpage\">$tmp</span>";}

	$tmp = 	"<li><a href=\"".$wiki->config('script_name')."?page=".Util::url_encode($_)."\">".
		$tmp."</a>".
		" - ".Util::format_date($wiki->get_last_modified2($_)).
		"</li>\n";


	$icontent{$initial} .= 	$tmp;
		if(Util::escapeHTML($_) =~ /$reserve/o){
		$fscontent .= $tmp;
		}
	}

	$fscontent = "<h3><a href=\"#_FSWiki\" name=\"FSWiki\">FSWiki</a></h3>\n<ul>" . $fscontent . "</ul>\n";

	my $mokuji = '|';
	foreach(sort keys %icontent){
	my $tmp;
	$tmp = Util::url_encode($_);
	$tmp =~ s/\%//g; #firefoxでは、日本語のURLエンコードのリンクがうまくいかなかったので %を削除。
	$content .= "<h4><a href=\"#_" . $tmp . "\" name=\"" . $tmp . "\">" . Util::escapeHTML($_) . "</a></h4>\n<ul>$icontent{$_}</ul>\n";
	$mokuji .= "&nbsp;<a href=\"#" . $tmp . "\" name=\"_" . $tmp . "\">" . Util::escapeHTML($_) . "</a>&nbsp;|";
	}

	$content = $mokuji . "&nbsp;<a href=\"#FSWiki\" name=\"_FSWiki\">FSWiki</a>&nbsp;|\n<h3>ページの一覧</h3>\n" . $content . $fscontent;

	return $content;
}

1;
