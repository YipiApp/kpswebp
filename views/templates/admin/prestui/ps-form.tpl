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
&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;form-group&quot;&gt;X_RN_X_*_&lt;label class=&quot;control-label col-lg-3 { opts.required == 'true' ? 'required' : '' }&quot;&gt;X_RN_X_*_&lt;span class=&quot;label-tooltip&quot; data-toggle=&quot;tooltip&quot; data-html=&quot;true&quot; data-original-title=&quot;{ opts.hint }&quot; if={ opts.hint }&gt;{ opts.label }&lt;/span&gt;X_RN_X_*_&lt;span if={ !opts.hint }&gt;{ opts.label }&lt;/span&gt;X_RN_X_*_&lt;/label&gt;X_RN_X_*_&lt;div class=&quot;col-lg-9&quot;&gt;&lt;yield/&gt;&lt;/div&gt;X_RN_X_*_&lt;div class=&quot;col-lg-9 col-lg-offset-3&quot;&gt;&lt;div class=&quot;help-block&quot; if={ opts.help }&gt;&lt;raw content=&quot;{ opts.help }&quot;/&gt;&lt;/div&gt;&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;div style=&quot;clear: both; padding-top:15px;&quot;&gt;X_RN_XX_RN_X_*_&lt;label class=&quot;conf_title&quot;&gt;&lt;sup if={ opts.required }&gt;*&amp;nbsp;&lt;/sup&gt;{ opts.label }&lt;/label&gt;X_RN_X_*_&lt;div class=&quot;margin-form&quot;&gt;X_RN_X_*_&lt;yield/&gt;X_RN_X_*_&lt;p class=&quot;preference_description&quot; if={ opts.help }&gt;&lt;raw content=&quot;{ opts.help }&quot;/&gt;&lt;/p&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-input-text-core&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;{literal}{ opts.prefix || opts.suffix ? 'input-group input ' : '' }{ opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }{/literal}&quot;&gt;X_RN_X_*_&lt;span class=&quot;input-group-addon&quot; if={ opts.prefix }&gt;{ opts.prefix}&lt;/span&gt;X_RN_X_*_&lt;input type=&quot;text&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; class=&quot;input { opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }&quot; placeholder=&quot;{ opts.placeholder }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot;&gt;X_RN_X_*_&lt;span class=&quot;input-group-addon&quot; if={ opts.suffix }&gt;{ opts.suffix}&lt;/span&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;span if={ opts.prefix }&gt;{ opts.prefix }&amp;nbsp;&lt;/span&gt;&lt;input type=&quot;text&quot; size=&quot;{ opts.size }&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; placeholder=&quot;{ opts.placeholder }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot;&gt;&lt;span if={ opts.suffix }&gt;&amp;nbsp;{ opts.suffix }&lt;/span&gt;X_RN_XX_RN_X_*_{/if}X_RN_X_*_X_RN_X_*_&lt;/ps-input-text-core&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-input-text&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_&lt;ps-input-text-core name=&quot;{ opts.name }&quot; fixed-width=&quot;{ opts.fixedWidth }&quot; suffix=&quot;{ opts.suffix }&quot; prefix=&quot;{ opts.prefix }&quot; placeholder=&quot;{ opts.placeholder }&quot; required-input=&quot;{ opts.requiredInput }&quot; size=&quot;{ opts.size }&quot; value=&quot;{ opts.value }&quot;&gt;&lt;/ps-input-text-core&gt;X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-input-text&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-label-information&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_&lt;yield/&gt;X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-label-information&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-input-file-core&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;{literal}{ opts.prefix || opts.suffix ? 'input-group input ' : '' }{ opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }{/literal}&quot;&gt;X_RN_X_*_&lt;span class=&quot;input-group-addon&quot; if={ opts.prefix }&gt;{ opts.prefix}&lt;/span&gt;X_RN_X_*_&lt;input type=&quot;file&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; class=&quot;input { opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }&quot; placeholder=&quot;{ opts.placeholder }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot;&gt;X_RN_X_*_&lt;span class=&quot;input-group-addon&quot; if={ opts.suffix }&gt;{ opts.suffix}&lt;/span&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;span if={ opts.prefix }&gt;{ opts.prefix }&amp;nbsp;&lt;/span&gt;&lt;input type=&quot;file&quot; size=&quot;{ opts.size }&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; placeholder=&quot;{ opts.placeholder }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot;&gt;&lt;span if={ opts.suffix }&gt;&amp;nbsp;{ opts.suffix }&lt;/span&gt;X_RN_XX_RN_X_*_{/if}X_RN_X_*_X_RN_X_*_&lt;/ps-input-file-core&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-input-file&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_&lt;ps-input-file-core name=&quot;{ opts.name }&quot; fixed-width=&quot;{ opts.fixedWidth }&quot; suffix=&quot;{ opts.suffix }&quot; prefix=&quot;{ opts.prefix }&quot; placeholder=&quot;{ opts.placeholder }&quot; required-input=&quot;{ opts.requiredInput }&quot; size=&quot;{ opts.size }&quot; value=&quot;{ opts.value }&quot;&gt;&lt;/ps-input-file-core&gt;X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-input-file&gt;X_RN_X&lt;/script&gt;X_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-input-text-lang&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;yield/&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;div class=&quot;translatable&quot;&gt;X_RN_XX_RN_X_*_&lt;yield/&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;displayed_flag&quot;&gt;&lt;img class=&quot;language_current pointer&quot; src=&quot;../img/l/{ this.parent.opts.activeLang }.jpg&quot; onclick=&quot;toggleLanguageFlags(this);&quot;&gt;&lt;/div&gt;X_RN_X_*_&lt;div class=&quot;language_flags&quot; style=&quot;display: none;&quot;&gt;X_RN_X_*_&lt;img class=&quot;pointer&quot; src=&quot;../img/l/{ lang.idLang }.jpg&quot; alt=&quot;{ lang.langName }&quot; each={ lang in this.parent.langs } onclick=&quot;changeFormLanguage({ lang.idLang }, '{ lang.isoLang }', 0)&quot;&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version == 1.5}X_RN_XX_RN_X_*_&lt;style scoped&gt;X_RN_XX_RN_X_*_.language_flags .pointer { X_RN_X_*_margin: 2px;X_RN_X_*_}X_RN_XX_RN_X_*_.translatable div[class^=lang_] { X_RN_X_*_float: left;X_RN_X_*_}X_RN_XX_RN_X_*_&lt;/style&gt;X_RN_XX_RN_X_*_this.langs = []X_RN_XX_RN_X_*_this.on('mount', function() { X_RN_X_*_that = thisX_RN_X_*_that.tags['ps-form-group'].tags['ps-input-text-lang-value'].forEach(function(elem) { X_RN_X_*_that.langs.push(elem.opts)X_RN_X_*_$(elem.root).addClass('lang_'+elem.opts.idLang)X_RN_X_*_if (that.opts.activeLang != elem.opts.idLang)X_RN_X_*_$(elem.root).hide()X_RN_X_*_})X_RN_X_*_that.update()X_RN_X_*_})X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-input-text-lang&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-input-text-lang-value&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;translatable-field row lang-{ this.opts.idLang }&quot; style=&quot;display: { this.parent.opts.activeLang == this.opts.idLang ? 'block' : 'none' };&quot;&gt;X_RN_X_*_&lt;div class=&quot;col-lg-{ this.parent.opts.colLg }&quot;&gt;X_RN_X_*_&lt;ps-input-text-core name=&quot;{ this.parent.opts.name }_{ this.opts.idLang }&quot; placeholder=&quot;{ opts.placeholder }&quot; required-input=&quot;{ this.parent.opts.requiredInput }&quot; fixed-width=&quot;{ this.parent.opts.fixedWidth }&quot; value=&quot;{ opts.value }&quot;&gt;&lt;/ps-input-text-core&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;div class=&quot;col-lg-2&quot;&gt;X_RN_X_*_&lt;button type=&quot;button&quot; class=&quot;btn btn-default dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; tabindex=&quot;-1&quot;&gt;X_RN_X_*_{ this.opts.isoLang }X_RN_X_*_&lt;span class=&quot;caret&quot;&gt;&lt;/span&gt;X_RN_X_*_&lt;/button&gt;X_RN_X_*_&lt;ul class=&quot;dropdown-menu&quot;&gt;X_RN_X_*_&lt;li each={ dropdown_lang in this.langs }&gt;X_RN_X_*_&lt;a href=&quot;javascript:hideOtherLanguage({ dropdown_lang.idLang });&quot;&gt;{ dropdown_lang.langName }&lt;/a&gt;X_RN_X_*_&lt;/li&gt;X_RN_X_*_&lt;/ul&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_this.langs = []X_RN_XX_RN_X_*_this.on('mount', function() { X_RN_X_*_that = thisX_RN_X_*_if (that.parent)X_RN_X_*_{ X_RN_X_*_that.parent.tags['ps-input-text-lang-value'].forEach(function(elem) { X_RN_X_*_that.langs.push(elem.opts)X_RN_X_*_})X_RN_X_*_that.update()X_RN_X_*_}X_RN_X_*_})X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;ps-input-text-core name=&quot;{ this.parent.opts.name }_{ this.opts.idLang }&quot; placeholder=&quot;{ opts.placeholder }&quot; required-input=&quot;{ this.parent.opts.requiredInput }&quot; size=&quot;{ this.parent.opts.size }&quot; value=&quot;{ opts.value }&quot;&gt;&lt;/ps-input-text-core&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-input-text-lang-value&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_XX_RN_X_*_&lt;ps-textarea-core&gt;X_RN_XX_RN_X_*_&lt;textarea name=&quot;{ opts.name }&quot; class=&quot;{ rte: opts.richEditor == 'true', autoload_rte: opts.richEditor == 'true'}&quot; rows=&quot;{ opts.rows }&quot; {if $ps_version < 1.6}cols=&quot;{ opts.cols }&quot;{/if}&gt;&lt;yield/&gt;&lt;/textarea&gt;X_RN_XX_RN_X_*_&lt;/ps-textarea-core&gt;X_RN_XX_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_XX_RN_X_*_&lt;ps-textarea&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_&lt;ps-textarea-core rich-editor=&quot;{ opts.richEditor }&quot; name=&quot;{ opts.name }&quot; rows=&quot;{ opts.rows }&quot; cols=&quot;{ opts.cols }&quot;&gt;&lt;yield/&gt;&lt;/ps-textarea-core&gt;X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-textarea&gt;X_RN_XX_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-textarea-lang&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;yield/&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;div class=&quot;translatable&quot;&gt;X_RN_XX_RN_X_*_&lt;yield/&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;displayed_flag&quot;&gt;&lt;img class=&quot;language_current pointer&quot; src=&quot;../img/l/{ this.parent.opts.activeLang }.jpg&quot; onclick=&quot;toggleLanguageFlags(this);&quot;&gt;&lt;/div&gt;X_RN_X_*_&lt;div class=&quot;language_flags&quot; style=&quot;display: none;&quot;&gt;X_RN_X_*_&lt;img class=&quot;pointer&quot; src=&quot;../img/l/{ lang.idLang }.jpg&quot; alt=&quot;{ lang.langName }&quot; each={ lang in this.parent.langs } onclick=&quot;changeFormLanguage({ lang.idLang }, '{ lang.isoLang }', 0)&quot;&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version == 1.5}X_RN_XX_RN_X_*_&lt;style scoped&gt;X_RN_XX_RN_X_*_.language_flags .pointer { X_RN_X_*_margin: 2px;X_RN_X_*_}X_RN_XX_RN_X_*_.translatable div[class^=lang_] { X_RN_X_*_float: left;X_RN_X_*_}X_RN_XX_RN_X_*_&lt;/style&gt;X_RN_XX_RN_X_*_this.langs = []X_RN_XX_RN_X_*_this.on('mount', function() { X_RN_X_*_that = thisX_RN_X_*_that.tags['ps-form-group'].tags['ps-textarea-lang-value'].forEach(function(elem) { X_RN_X_*_that.langs.push(elem.opts)X_RN_X_*_$(elem.root).addClass('lang_'+elem.opts.idLang)X_RN_X_*_if (that.opts.activeLang != elem.opts.idLang)X_RN_X_*_$(elem.root).hide()X_RN_X_*_})X_RN_X_*_that.update()X_RN_X_*_})X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-textarea-lang&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-textarea-lang-value&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;translatable-field row lang-{ this.opts.idLang }&quot; style=&quot;display: { this.parent.opts.activeLang == this.opts.idLang ? 'block' : 'none' };&quot;&gt;X_RN_X_*_&lt;div class=&quot;col-lg-{ this.parent.opts.colLg }&quot;&gt;X_RN_X_*_&lt;ps-textarea-core name=&quot;{ this.parent.opts.name }_{ this.opts.idLang }&quot; rows=&quot;{ this.parent.parent.opts.rows }&quot; cols=&quot;{ this.parent.parent.opts.cols }&quot; rich-editor=&quot;{ this.parent.opts.richEditor }&quot;&gt;&lt;yield/&gt;&lt;/ps-textarea-core&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;div class=&quot;col-lg-2&quot;&gt;X_RN_X_*_&lt;button type=&quot;button&quot; class=&quot;btn btn-default dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; tabindex=&quot;-1&quot;&gt;X_RN_X_*_{ this.opts.isoLang }X_RN_X_*_&lt;span class=&quot;caret&quot;&gt;&lt;/span&gt;X_RN_X_*_&lt;/button&gt;X_RN_X_*_&lt;ul class=&quot;dropdown-menu&quot;&gt;X_RN_X_*_&lt;li each={ dropdown_lang in this.langs }&gt;X_RN_X_*_&lt;a href=&quot;javascript:hideOtherLanguage({ dropdown_lang.idLang });&quot;&gt;{ dropdown_lang.langName }&lt;/a&gt;X_RN_X_*_&lt;/li&gt;X_RN_X_*_&lt;/ul&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_this.langs = []X_RN_XX_RN_X_*_this.on('mount', function() { X_RN_X_*_that = thisX_RN_X_*_if (that.parent)X_RN_X_*_{ X_RN_X_*_that.parent.tags['ps-textarea-lang-value'].forEach(function(elem) { X_RN_X_*_that.langs.push(elem.opts)X_RN_X_*_})X_RN_X_*_that.update()X_RN_X_*_}X_RN_X_*_})X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;ps-textarea-core name=&quot;{ this.parent.opts.name }_{ this.opts.idLang }&quot; rows=&quot;{ this.parent.parent.opts.rows }&quot; cols=&quot;{ this.parent.parent.opts.cols }&quot; rich-editor=&quot;{ this.parent.opts.richEditor }&quot;&gt;&lt;yield/&gt;&lt;/ps-textarea-core&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-textarea-lang-value&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X{if $ps_version < 1.6}X_RN_X_*_&lt;script type=&quot;text/javascript&quot; src=&quot;{$smarty.const.__PS_BASE_URI__|escape:'quotes':'UTF-8'}/js/tinymce.inc.js&quot;&gt;&lt;/script&gt;X_RN_X{/if}X_RN_XX_RN_X&lt;script type=&quot;text/javascript&quot;&gt;X_RN_X_*_var iso = iso_user;X_RN_X_*_var pathCSS = &quot;{$smarty.const._THEME_CSS_DIR_|escape:'quotes':'UTF-8'}&quot;;X_RN_X_*_var ad = &quot;{$smarty.const.__PS_BASE_URI__|escape:'htmlall':'UTF-8'}{basename($smarty.const._PS_ADMIN_DIR_)|escape:'quotes':'UTF-8'}&quot;;X_RN_XX_RN_X_*_$( document ).ready(function() { X_RN_X_*_if ($(&quot;ps-textarea .autoload_rte&quot;).length &gt; 0) { X_RN_X_*_tinySetup({ editor_selector: &quot;autoload_rte&quot; })X_RN_X_*_}X_RN_X_*_});X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-switch&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;span class=&quot;switch prestashop-switch fixed-width-lg&quot;&gt;X_RN_X_*_&lt;input type=&quot;radio&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }_on&quot; value=&quot;1&quot; checked={ opts.active == 'true' } disabled=&quot;{ opts.disabled == 'true' }&quot;&gt;X_RN_X_*_&lt;label for=&quot;{ opts.name }_on&quot;&gt;{ opts.yes }&lt;/label&gt;X_RN_X_*_&lt;input type=&quot;radio&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }_off&quot; value=&quot;0&quot; checked={ opts.active != 'true' } disabled=&quot;{ opts.disabled == 'true' }&quot;&gt;X_RN_X_*_&lt;label for=&quot;{ opts.name }_off&quot;&gt;{ opts.no }&lt;/label&gt;X_RN_X_*_&lt;a class=&quot;slide-button btn&quot;&gt;&lt;/a&gt;X_RN_X_*_&lt;/span&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;label class=&quot;t&quot; for=&quot;{ opts.name }_on&quot;&gt;&lt;img src=&quot;../img/admin/enabled.gif&quot; alt=&quot;{ opts.yes }&quot; title=&quot;{ opts.yes }&quot;&gt;&lt;/label&gt;X_RN_X_*_&lt;input type=&quot;radio&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }_on&quot; value=&quot;1&quot; checked={ opts.active == 'true' }&gt;X_RN_X_*_&lt;label class=&quot;t&quot; for=&quot;{ opts.name }_on&quot;&gt; { opts.yes }&lt;/label&gt;X_RN_X_*_&lt;label class=&quot;t&quot; for=&quot;{ opts.name }_off&quot;&gt;&lt;img src=&quot;../img/admin/disabled.gif&quot; alt=&quot;{ opts.no }&quot; title=&quot;{ opts.no }&quot; style=&quot;margin-left: 10px;&quot;&gt;&lt;/label&gt;X_RN_X_*_&lt;input type=&quot;radio&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }_off&quot; value=&quot;0&quot; checked={ opts.active != 'true' }&gt;X_RN_X_*_&lt;label class=&quot;t&quot; for=&quot;{ opts.name }_off&quot;&gt; { opts.no }&lt;/label&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-switch&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-radios&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_X_*_&lt;yield/&gt;X_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-radios&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-radio&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;radio&quot;&gt;X_RN_X_*_&lt;label&gt;&lt;input type=&quot;radio&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }_{ opts.value }&quot; value=&quot;{ opts.value }&quot; checked={ opts.checked == 'true' }&gt;&lt;yield/&gt;&lt;/label&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;input type=&quot;radio&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }_{ opts.value }&quot; value=&quot;{ opts.value }&quot; checked={ opts.checked == 'true' }&gt;X_RN_X_*_&lt;label class=&quot;t&quot; for=&quot;{ opts.name }_{ opts.value }&quot;&gt;&lt;yield/&gt;&lt;/label&gt;X_RN_X_*_&lt;br&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-radio&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-checkboxes&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_X_*_&lt;yield/&gt;X_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-checkboxes&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-checkbox&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;checkbox&quot;&gt;X_RN_X_*_&lt;label for=&quot;{ opts.name }_{ opts.value }&quot;&gt;X_RN_X_*_&lt;input type=&quot;checkbox&quot; name=&quot;{ opts.name }&quot; checked={ opts.checked == 'true' } value=&quot;{ opts.value }&quot;&gt;X_RN_X_*_&lt;yield/&gt;X_RN_X_*_&lt;/label&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;input type=&quot;checkbox&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; checked={ opts.checked == 'true' }&gt;X_RN_X_*_&lt;label class=&quot;t&quot; for=&quot;{ opts.name }_{ opts.value }&quot;&gt;&lt;yield/&gt;&lt;/label&gt;X_RN_X_*_&lt;br&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-checkbox&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-select&gt;X_RN_XX_RN_X_*_&lt;ps-form-group&gt;X_RN_X_*_&lt;div class=&quot;{if $ps_version == '1.6'}input-group{/if} { opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }&quot;&gt;X_RN_X_*_&lt;select name=&quot;{ opts.name }&quot;  multiple=&quot;{ opts.multiple == 'true'?'multiple':'' }&quot;&gt;X_RN_X_*_&lt;yield/&gt;X_RN_X_*_&lt;/select&gt;X_RN_X_*_&lt;/div&gt;X_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_X_*_this.on('mount', function() { X_RN_X_*_// Fix for mColorPickerX_RN_X_*_var options = $(this.root).find('option');X_RN_X_*_if (options.length &gt; 0) { X_RN_X_*_if (options.prop) { X_RN_X_*_options.prop('selected', false);X_RN_X_*_options.each(function(){ X_RN_X_*_var attr = $(this).attr('data-selected');X_RN_X_*_if(typeof attr !== typeof undefined) { X_RN_X_*_$(this).prop('selected', true);X_RN_X_*_}X_RN_X_*_});X_RN_X_*_} else { X_RN_X_*_options.removeAttr('selected');X_RN_X_*_options.each(function(){ X_RN_X_*_var attr = $(this).attr('data-selected');X_RN_X_*_if(typeof attr !== typeof undefined) { X_RN_X_*_$(this).attr('selected', 'selected');X_RN_X_*_}X_RN_X_*_});X_RN_X_*_}X_RN_X_*_}X_RN_X_*_})X_RN_X_*_&lt;/ps-select&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-color-picker&gt;X_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_&lt;div class=&quot;{if $ps_version == '1.6'}input-group{/if} { opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : 'i-lg' }&quot;&gt;X_RN_X_*_&lt;input type=&quot;color&quot; size=&quot;{ opts.size ||&nbsp;20 }&quot; data-hex=&quot;true&quot; class=&quot;color mColorPickerInput mColorPicker&quot; name=&quot;{ opts.name }&quot; id=&quot;{ opts.name }&quot;&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_&lt;style scoped&gt;X_RN_X_*_img { X_RN_X_*_border: 0;X_RN_X_*_margin:0 0 0 3px;X_RN_X_*_}X_RN_XX_RN_X_*_span { X_RN_X_*_cursor: pointer;X_RN_X_*_}X_RN_X_*_&lt;/style&gt;X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_X_*_this.on('mount', function() { X_RN_X_*_// Fix for mColorPickerX_RN_X_*_$(this.root).find('input[type=color]').attr('value', opts.color)X_RN_X_*_})X_RN_XX_RN_XX_RN_X_*_&lt;/ps-color-picker&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-password&gt;X_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;input-group { opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }&quot;&gt;X_RN_X_*_&lt;span class=&quot;input-group-addon&quot;&gt;X_RN_X_*_&lt;i class=&quot;icon-key&quot;&gt;&lt;/i&gt;X_RN_X_*_&lt;/span&gt;X_RN_X_*_&lt;input type=&quot;password&quot; name=&quot;{ opts.name }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot; value=&quot;{ opts.value }&quot;&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;input type=&quot;password&quot; size=&quot;{ opts.size }&quot; name=&quot;{ opts.name }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot; value=&quot;{ opts.value }&quot;&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-password&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;riot/tag&quot;&gt;X_RN_X_*_&lt;ps-date-picker&gt;X_RN_X_*_&lt;ps-form-group&gt;X_RN_XX_RN_X_*_{if $ps_version >= 1.6}X_RN_XX_RN_X_*_&lt;div class=&quot;input-group { opts.fixedWidth ? 'fixed-width-'+opts.fixedWidth : '' }&quot;&gt;X_RN_X_*_&lt;input id=&quot;{ opts.name }&quot; type=&quot;text&quot; data-hex=&quot;true&quot; class=&quot;datepicker&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot; /&gt;X_RN_X_*_&lt;span class=&quot;input-group-addon&quot;&gt;X_RN_X_*_&lt;i class=&quot;icon-calendar-empty&quot;&gt;&lt;/i&gt;X_RN_X_*_&lt;/span&gt;X_RN_X_*_&lt;/div&gt;X_RN_XX_RN_X_*_{else}X_RN_XX_RN_X_*_&lt;input id=&quot;{ opts.name }&quot; type=&quot;text&quot; data-hex=&quot;true&quot; size=&quot;{ opts.size }&quot; class=&quot;datepicker&quot; name=&quot;{ opts.name }&quot; value=&quot;{ opts.value }&quot; required=&quot;{ opts.requiredInput == 'true' }&quot; /&gt;X_RN_XX_RN_X_*_{/if}X_RN_XX_RN_X_*_&lt;/ps-form-group&gt;X_RN_XX_RN_X_*_this.tags['ps-form-group'].opts = optsX_RN_XX_RN_X_*_&lt;/ps-date-picker&gt;X_RN_X&lt;/script&gt;X_RN_XX_RN_X&lt;script type=&quot;text/javascript&quot;&gt;X_RN_X_*_$( document ).ready(function() { X_RN_X_*_if ($(&quot;ps-date-picker .datepicker&quot;).length &gt; 0) { X_RN_X_*_$(&quot;ps-date-picker .datepicker&quot;).datepicker({ X_RN_X_*_prevText: '',X_RN_X_*_nextText: '',X_RN_X_*_dateFormat: 'yy-mm-dd'X_RN_X_*_});X_RN_X_*_}X_RN_X_*_});X_RN_X&lt;/script&gt;X_RN_X