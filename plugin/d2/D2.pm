################################################################################
#
# <p>d2でレンダリングして出力するプラグイン。</p>
# <pre>
# {{d2 横幅(～100)
# ここにD2のソース
# }}
# </pre>
# <p>横幅指定がなければautoになります。</p>
#
################################################################################
package plugin::d2::D2;

#==============================================================================
# コンストラクタ
#==============================================================================
sub new {
	my $class = shift;
	my $self = {};
	return bless $self,$class;
}

#==============================================================================
# ブロックメソッド
#==============================================================================
sub block {
	my $self = shift;
	my $wiki = shift;
	my $text = shift;
	my $width = shift;

       if($width eq ''){ $width = "auto"; } else {
        if($width > 100){ $width = "100vw"; } else { $width = $width . "vw";}
       }

        my @chars = ('A'..'Z', 'a'..'z', 0..9);
        # 15・30の範囲でランダムな長さを決める
        my $length = 15 + int(rand(16));  # 15 + 0・15 → 15・30
        # ランダム文字列を生成
        my $r = join '', map { $chars[rand @chars] } 1 .. $length;

	my $buf  = '<div id="d2source_' . $r . '" style="width: ' . $width . ';">';

#	foreach my $line (split(/(\r\n)|\n|\r/,Util::escapeHTML($text))){
	foreach my $line (split(/(\r\n)|\n|\r/, $text)){
		$buf .= "$line\n";
	}
	$buf .= '</div>';
	return $buf;
}

1;
