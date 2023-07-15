{*
*    The MIT License (MIT)
*
*    Copyright (c) 2015 Emmanuel MARICHAL
*
*    Permission is hereby granted, free of charge, to any person obtaining a copy
*    of this software and associated documentation files (the "Software"), to deal
*    in the Software without restriction, including without limitation the rights
*    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*    copies of the Software, and to permit persons to whom the Software is
*    furnished to do so, subject to the following conditions:
*
*    The above copyright notice and this permission notice shall be included in
*    all copies or substantial portions of the Software.
*
*    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*    THE SOFTWARE.
*}
&lt;script type=&quot;riot/tag&quot;&gt;X_RN_XX_RN_X_*_&lt;ps-table&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;form method=&quot;post&quot; method=&quot;post&quot; class=&quot;form-horizontal clearfix&quot;&gt;X_RN_XX_RN_X_*_&lt;input type=&quot;hidden&quot; name=&quot;token&quot; value=&quot;&quot;&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;panel col-lg-12&quot;&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;panel-heading&quot;&gt;X_RN_X_*_&lt;i class=&quot;{ opts.icon }&quot; if={ opts.icon }&gt;&lt;/i&gt; { opts.header }X_RN_X_*_&lt;span class=&quot;badge&quot;&gt;{ this.rows.length }&lt;/span&gt;X_RN_X_*_&lt;span class=&quot;panel-heading-action&quot; if={ this.top_actions }&gt;X_RN_X_*_&lt;a class=&quot;list-toolbar-btn&quot; href=&quot;{ this.base_action_url }&amp;action={ elem.action }&quot; title=&quot;{ elem.title }&quot; each={ elem, index in this.top_actions }&gt;X_RN_X_*_&lt;span data-toggle=&quot;tooltip&quot; class=&quot;label-tooltip&quot; data-original-title=&quot;{ elem.title }&quot; data-html=&quot;true&quot; data-placement=&quot;top&quot;&gt;X_RN_X_*_&lt;i class=&quot;process-icon-new&quot;&gt;&lt;/i&gt;X_RN_X_*_&lt;/span&gt;X_RN_X_*_&lt;/a&gt;X_RN_X_*_&lt;/span&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;table-responsive-row clearfix&quot;&gt;X_RN_X_*_&lt;table class=&quot;table&quot;&gt;X_RN_XX_RN_X_*_&lt;thead&gt;X_RN_X_*_&lt;tr class=&quot;nodrag nodrop&quot;&gt;X_RN_X_*_&lt;th each={ elem, index in this.columns } class=&quot;{ this.columns_classes[this.columns.indexOf(elem)] }&quot;&gt;X_RN_X_*_&lt;span class=&quot;title_box&quot;&gt;X_RN_X_*_{ elem.content }X_RN_X_*_&lt;/span&gt;X_RN_X_*_&lt;/th&gt;X_RN_X_*_&lt;th class=&quot;fixed-width-md&quot; if={ this.primary_action }&gt;&lt;/th&gt;X_RN_X_*_&lt;/tr&gt;X_RN_X_*_&lt;/thead&gt;X_RN_XX_RN_X_*_&lt;tbody&gt;X_RN_XX_RN_X_*_&lt;tr class=&quot;odd&quot; each={ row, i in this.rows }&gt;X_RN_X_*_&lt;td each={ value, key in this.columns_keys } class=&quot;{ this.columns_classes[key] }&quot;&gt;X_RN_X_*_&lt;i class=&quot;icon-{ row[value] == 1 ? 'check' : 'remove' } status&quot; if={ this.columns[key].bool }&gt;&lt;/i&gt;X_RN_X_*_&lt;span if={ !this.columns[key].bool }&gt;{ row[value] }&lt;/span&gt;X_RN_X_*_&lt;/td&gt;X_RN_X_*_&lt;td if={ this.primary_action }&gt;X_RN_X_*_&lt;div class=&quot;btn-group-action&quot;&gt;X_RN_X_*_&lt;div class=&quot;btn-group pull-right&quot;&gt;X_RN_X_*_&lt;a href=&quot;{ this.base_action_url }&amp;action={ this.primary_action.action }&amp;{ this.identifier }={ row[this.identifier] }&quot; title=&quot;{ this.primary_action.title }&quot; class=&quot;edit btn btn-default&quot;&gt;X_RN_X_*_&lt;i class=&quot;icon-{ this.primary_action.icon }&quot;&gt;&lt;/i&gt; { this.primary_action.title }X_RN_X_*_&lt;/a&gt;X_RN_X_*_&lt;button class=&quot;btn btn-default dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; if={ this.secondary_actions.length }&gt;X_RN_X_*_&lt;i class=&quot;icon-caret-down&quot;&gt;&lt;/i&gt;&amp;nbsp;X_RN_X_*_&lt;/button&gt;X_RN_X_*_&lt;ul class=&quot;dropdown-menu&quot; if={ this.secondary_actions.length }&gt;X_RN_X_*_&lt;li each={ elem, index in this.secondary_actions }&gt;X_RN_X_*_&lt;a href=&quot;{ this.base_action_url }&amp;action={ elem.action }&amp;{ this.identifier }={ row[this.identifier] }&quot; title=&quot;{ elem.title }&quot;&gt;X_RN_X_*_&lt;i class=&quot;icon-{ elem.icon }&quot;&gt;&lt;/i&gt; { elem.title }X_RN_X_*_&lt;/a&gt;X_RN_X_*_&lt;/li&gt;X_RN_X_*_&lt;/ul&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/td&gt;X_RN_X_*_&lt;/tr&gt;X_RN_XX_RN_X_*_&lt;tr if={ this.empty_table }&gt;X_RN_X_*_&lt;td class=&quot;list-empty&quot; colspan=&quot;{ this.columns.length + 1 }&quot;&gt;X_RN_X_*_&lt;div class=&quot;list-empty-msg&quot;&gt;X_RN_X_*_&lt;i class=&quot;icon-warning-sign list-empty-icon&quot;&gt;&lt;/i&gt;X_RN_X_*_{ this.opts.noItemsText }X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/td&gt;X_RN_X_*_&lt;/tr&gt;X_RN_XX_RN_X_*_&lt;/tbody&gt;X_RN_XX_RN_X_*_&lt;/table&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_&lt;/form&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;div class=&quot;toolbar-placeholder&quot;&gt;X_RN_X_*_&lt;div class=&quot;toolbarBox toolbarHead&quot;&gt;X_RN_XX_RN_X_*_&lt;ul class=&quot;cc_button&quot; if={ this.top_actions }&gt;X_RN_X_*_&lt;li each={ elem, index in this.top_actions }&gt;X_RN_X_*_&lt;a class=&quot;toolbar_btn&quot; href=&quot;{ this.base_action_url }&amp;action={ elem.action }&quot; title=&quot;{ elem.title }&quot;&gt;X_RN_X_*_&lt;img src=&quot;{ elem.img }&quot; if={ !elem.fa } /&gt;X_RN_X_*_&lt;i class=&quot;fa fa-{ elem.fa }&quot;&gt;&lt;/i&gt;X_RN_X_*_&lt;div&gt;{ elem.title }&lt;/div&gt;X_RN_X_*_&lt;/a&gt;X_RN_X_*_&lt;/li&gt;X_RN_X_*_&lt;/ul&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;pageTitle&quot;&gt;X_RN_X_*_&lt;h3&gt;{ opts.header }&lt;/h3&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_&lt;form method=&quot;post&quot; class=&quot;form&quot;&gt;X_RN_XX_RN_X_*_&lt;table class=&quot;table_grid&quot; name=&quot;list_table&quot;&gt;X_RN_X_*_&lt;tbody&gt;X_RN_X_*_&lt;tr&gt;X_RN_X_*_&lt;td&gt;X_RN_X_*_&lt;table class=&quot;table&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot; style=&quot;width: 100%; margin-bottom:10px;&quot;&gt;X_RN_X_*_&lt;thead&gt;X_RN_X_*_&lt;tr class=&quot;nodrag nodrop&quot; style=&quot;height: 40px&quot;&gt;X_RN_X_*_&lt;th each={ elem, index in this.columns } class=&quot;{ this.columns_classes[this.columns.indexOf(elem)] }&quot;&gt;X_RN_X_*_&lt;span class=&quot;title_box&quot;&gt;X_RN_X_*_{ elem.content }X_RN_X_*_&lt;/span&gt;X_RN_X_*_&lt;/th&gt;X_RN_X_*_&lt;th if={ this.primary_action }&gt;&lt;/th&gt;X_RN_X_*_&lt;/tr&gt;X_RN_X_*_&lt;/thead&gt;X_RN_XX_RN_X_*_&lt;tbody&gt;X_RN_XX_RN_X_*_&lt;tr class=&quot;row_hover&quot; each={ row, i in this.rows }&gt;X_RN_XX_RN_X_*_&lt;td each={ value, key in this.columns_keys } class=&quot;{ this.columns_classes[key] }&quot;&gt;X_RN_X_*_&lt;img src=&quot;../img/admin/{ row[value] == 1 ? 'enabled' : 'disabled' }.gif&quot; if={ this.columns[key].bool &amp;&amp; !this.columns[key].fa }&gt;X_RN_X_*_&lt;i class=&quot;fa fa-{ row[value] == 1 ? 'check fa-bool-true' : 'times fa-bool-false' }&quot; if={ this.columns[key].bool &amp;&amp; this.columns[key].fa }&gt;&lt;/i&gt;X_RN_X_*_&lt;span if={ !this.columns[key].bool }&gt;{ row[value] }&lt;/span&gt;X_RN_X_*_&lt;/td&gt;X_RN_XX_RN_X_*_&lt;td class=&quot;right&quot; style=&quot;white-space: nowrap;&quot; if={ this.primary_action }&gt;X_RN_X_*_&lt;a href=&quot;{ this.base_action_url }&amp;action={ this.primary_action.action }&amp;{ this.identifier }={ row[this.identifier] }&quot; title=&quot;{ this.primary_action.title }&quot;&gt;X_RN_X_*_&lt;img src=&quot;{ this.primary_action.img }&quot; alt=&quot;{ this.primary_action.title }&quot; if={ !this.primary_action.fa }&gt;X_RN_X_*_&lt;i class=&quot;fa fa-{ this.primary_action.fa }&quot; if={ this.primary_action.fa }&gt;&lt;/i&gt;X_RN_X_*_&lt;/a&gt;X_RN_XX_RN_X_*_&lt;a each={ elem, index in this.secondary_actions } href=&quot;{ this.base_action_url }&amp;action={ elem.action }&amp;{ this.identifier }={ row[this.identifier] }&quot; title=&quot;{ elem.title }&quot;&gt;X_RN_X_*_&lt;img src=&quot;{ elem.img }&quot; alt=&quot;{ elem.title }&quot; if={ !elem.fa }&gt;X_RN_X_*_&lt;i class=&quot;fa fa-{ elem.fa }&quot; if={ elem.fa }&gt;&lt;/i&gt;X_RN_X_*_&lt;/a&gt;X_RN_X_*_&lt;/td&gt;X_RN_XX_RN_X_*_&lt;/tr&gt;X_RN_XX_RN_X_*_&lt;tr if={ this.empty_table }&gt;X_RN_X_*_&lt;td class=&quot;center&quot; colspan=&quot;{ this.columns.length + 1 }&quot;&gt;{ this.opts.noItemsText }&lt;/td&gt;X_RN_X_*_&lt;/tr&gt;X_RN_XX_RN_X_*_&lt;/tbody&gt;X_RN_X_*_&lt;/table&gt;X_RN_X_*_&lt;/td&gt;X_RN_X_*_&lt;/tr&gt;X_RN_X_*_&lt;/tbody&gt;X_RN_X_*_&lt;/table&gt;X_RN_XX_RN_X_*_&lt;/form&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;style scoped&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_i.status.icon-check { X_RN_X_*_color: #72C279;X_RN_X_*_}X_RN_XX_RN_X_*_i.status.icon-remove { X_RN_X_*_color: #E08F95;X_RN_X_*_}X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_.help-context-AdminModules { X_RN_X_*_display: none !important;X_RN_X_*_}X_RN_XX_RN_X_*_&gt; .toolbar-placeholder { X_RN_X_*_margin-top: 20px;X_RN_X_*_}X_RN_XX_RN_X_*_&gt; .toolbar-placeholder .pageTitle h3 { X_RN_X_*_font-weight: normal;X_RN_X_*_}X_RN_XX_RN_X_*_&gt; form { X_RN_X_*_margin-bottom: 15px;X_RN_X_*_}X_RN_XX_RN_X_*_.toolbarBox .toolbar_btn { X_RN_X_*_color: #585a69;X_RN_X_*_padding: 5px;X_RN_X_*_margin-top: -2px;X_RN_X_*_margin-right: 2pxX_RN_X_*_}X_RN_XX_RN_X_*_.toolbarBox .toolbar_btn i { X_RN_X_*_font-size: 2.5em;X_RN_X_*_}X_RN_XX_RN_X_*_.fa { X_RN_X_*_font-size: 1.3em;X_RN_X_*_margin: 0 2px;X_RN_X_*_color: #585a69;X_RN_X_*_}X_RN_XX_RN_X_*_.fa-bool-true { X_RN_X_*_color: #83CA79;X_RN_X_*_}X_RN_XX_RN_X_*_.fa-bool-false { X_RN_X_*_color: #FF575A;X_RN_X_*_}X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/style&gt;X_RN_XX_RN_X_*_content = JSON.parse(this.root.getAttribute('content'))X_RN_XX_RN_X_*_this.columns = content.columnsX_RN_X_*_this.rows = content.rowsX_RN_X_*_this.empty_table = this.rows.length == 0X_RN_XX_RN_X_*_this.columns_classes = []X_RN_X_*_this.columns_keys = []X_RN_XX_RN_X_*_for (var i in this.columns) { X_RN_X_*_this.columns_classes.push(this.columns[i].center == true ? 'center' : '')X_RN_X_*_this.columns_keys.push(this.columns[i].key)X_RN_X_*_}X_RN_XX_RN_X_*_this.base_action_url = currentIndex + &quot;&amp;token={Tools::getAdminTokenLite(Context::getContext()-&gt;controller-&gt;controller_name)|escape:'htmlall':'UTF-8'}&amp;&quot; + jQuery.param(content.url_params)X_RN_XX_RN_X_*_if (typeof content.rows_actions == 'object' &amp;&amp; content.rows_actions.length &gt; 0) { X_RN_X_*_this.primary_action = content.rows_actions.slice(0, 1)[0]X_RN_X_*_this.secondary_actions = content.rows_actions.slice(1)X_RN_X_*_}X_RN_X_*_elseX_RN_X_*_this.primary_action = nullX_RN_XX_RN_X_*_this.top_actions = content.top_actionsX_RN_XX_RN_X_*_this.identifier = content.identifierX_RN_XX_RN_X_*_&lt;/ps-table&gt;X_RN_XX_RN_X&lt;/script&gt;X_RN_X