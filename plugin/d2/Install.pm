##############################################################################
#
# d2描画するプラグインです。（d2のjavascriptモジュールはテンプレートに仕込む）
#
##############################################################################
#
# tmpl/site/default/default.tmpl の<head></head>内に以下を仕込む
#
##############################################################################
# <script type="module">
# import { D2 } from 'https://esm.sh/@terrastruct/d2@nightly/es2022/d2.mjs';
# 
# document.addEventListener('DOMContentLoaded', async () => {
#     const sourceElements = document.querySelectorAll('[id^="d2source_"]');
# 
#     for (const el of sourceElements) {
#         const source = el.textContent.trim();
#         try {
#             const d2 = new D2();
#             const result = await d2.compile(source);
# 
#             // HTMLが完全に描画された後にレンダリングを開始
#             requestAnimationFrame(async () => {
#                 const svg = await d2.render(result.diagram, {
#                     pad: 5,
#                     scale: 1,
#                 });
# 
#                 el.innerHTML = svg;
#                 el.style.display = 'flex';
#             });
#         } catch (err) {
#             console.error(`Error rendering D2 for element #${el.id}:`, err);
#         }
#     }
# });
# </script>
##############################################################################



package plugin::d2::Install;
use strict;

sub install {
	my $wiki = shift;
	
	$wiki->add_block_plugin("d2" ,"plugin::d2::D2" ,"TEXT");

}

1;
