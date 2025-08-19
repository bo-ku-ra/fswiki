##############################################################################
#
# mermaid描画プラグイン（mermaidのjavascriptモジュールはテンプレートに仕込む）
#
##############################################################################
#
# tmpl/site/default/default.tmpl の<head></head>内に以下を仕込む
#
##############################################################################
# <script type="module">
#     import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs';
#     mermaid.initialize({ startOnLoad: true, theme: 'default', securityLevel: 'loose'});
#    //Themes [default, neutral, dark, forest, base]
# </script>
# <script>
# // ページが完全に読み込まれた後に実行される関数
# window.onload = function() {
#  window.addEventListener('resize', function() {  // リサイズイベントをリスニング
#  window.location.reload();                       // ページをリロード
#  });
# };
# </script>
# <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
##############################################################################
package plugin::mermaid::Install;
use strict;

sub install {
	my $wiki = shift;
	
	$wiki->add_block_plugin("mmd" ,"plugin::mermaid::mermaid" ,"TEXT");

}

1;
