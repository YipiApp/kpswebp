{*
* Pagina administrativa
*
* @author    Yipi.app
* @copyright 2019 Yipi.app
* @license   GPLv2
*}

<form action="" method="post" class="form-horizontal">
    <ps-panel icon="icon-cogs" header="{$display_name|escape:'htmlall':'UTF-8'}">
        <ps-input-text name="config[quality]"
            label="{l s='Quality' mod='kpswebp'}"
            help="{l s='From 10 (full compression) to 100' mod='kpswebp'}" size="10"
            value="{if isset($config.quality)}{$config.quality|escape:'htmlall':'UTF-8'}{else}80{/if}"
            required-input="true"
            hint="{l s='From 10 (full compression) to 100' mod='kpswebp'}" fixed-width="md"></ps-input-text>

        <ps-input-text name="config[ewww]"
            label="{l s='Ewww Api Key (Optional)' mod='kpswebp'}"
            help="{l s='Only if you need to use this service, empty to use GD Library' mod='kpswebp'}" size="10"
            {if isset($config.ewww)}value="{$config.ewww|escape:'htmlall':'UTF-8'}"{/if}
            hint="{l s='Only if you need to use this service, empty to use GD Library' mod='kpswebp'}"></ps-input-text>

        <ps-input-text name="config[other_path]"
            label="{l s='Convert Others Path (Separate by comma)' mod='kpswebp'}"
            help="{l s='Only for manual converting, not work for automatic convartions' mod='kpswebp'}" size="10"
            {if isset($config.other_path)}value="{$config.other_path|escape:'htmlall':'UTF-8'}"{/if}
            hint="{l s='Only for manual converting, not work for automatic convartions' mod='kpswebp'}"></ps-input-text>

        <ps-input-text name="config[max_convert_by_request]"
            label="{l s='Number of images to process per request' mod='kpswebp'}"
            help="{l s='Adjust this parameter based on your server\'s timeout, processing capacity, and ram memory' mod='kpswebp'}" size="10"
            value="{if isset($config.max_convert_by_request)}{$config.max_convert_by_request|escape:'htmlall':'UTF-8'}{else}50{/if}"
            required-input="true"
            hint="{l s='Adjust this parameter based on your server\'s timeout, processing capacity, and ram memory' mod='kpswebp'}" fixed-width="md"></ps-input-text>

        <ps-input-text name="config[threads]"
            label="{l s='Number of threads [1 to 4]' mod='kpswebp'}"
            help="{l s='Based on the processor cores of your server. For shared hosting it is not recommended to use more than 1 thread.' mod='kpswebp'}" size="10"
            value="{if isset($config.threads)}{$config.threads|escape:'htmlall':'UTF-8'}{else}4{/if}"
            required-input="true"
            hint="{l s='Based on the processor cores of your server. For shared hosting it is not recommended to use more than 1 thread.' mod='kpswebp'}" fixed-width="md"></ps-input-text>

        <ps-switch name="config[htaccess]"
            label="{l s='Regenerate htaccess and display webp images in front-office (enable it only when you have already converted all images)' mod='kpswebp'}"
            yes="{l s='Yes' mod='kpswebp'}" no="{l s='No' mod='kpswebp'}"
            {if isset($config.htaccess) && $config.htaccess}active="true"{/if}
            ></ps-switch>
        <ps-panel-footer>
            <ps-panel-footer-submit title="{l s='Save changes' mod='kpswebp'}" icon="process-icon-save" direction="right" name="submitPanel"></ps-panel-footer-submit>
        </ps-panel-footer>
    </ps-panel>
</form>
<input id="kpswebp_url_controller" type="hidden" value="{$kpswebp_url_controller|escape:'htmlall':'UTF-8'}" />
{foreach from=$dirs item=val}
<form id="{$val.id|escape:'htmlall':'UTF-8'}" action="javascript:void(kpswebpRunConvertion('{$val.path|escape:'htmlall':'UTF-8'}', '#{$val.id|escape:'htmlall':'UTF-8'}', {if isset($config.threads)}{$config.threads|escape:'htmlall':'UTF-8'}{else}1{/if}, false))" method="get" class="form-kpswebp form-horizontal">
    <ps-panel icon="icon-cogs" header="Convert Directory: {$val.name|escape:'htmlall':'UTF-8'} ">
        <ps-label-information>
            <b>{l s='Images in this directory' mod='kpswebp'}</b>: <span class="total_images" data-count="{$val.count.total_images|escape:'htmlall':'UTF-8'}">{$val.count.total_images|escape:'htmlall':'UTF-8'}</span><br />
            <b>{l s='Images already converted to webp' mod='kpswebp'}</b>: <span class="total_webp" data-count="{$val.count.total_webp|escape:'htmlall':'UTF-8'}">{$val.count.total_webp|escape:'htmlall':'UTF-8'}</span><br />
            <b>{l s='Waiting to be converted' mod='kpswebp'}</b>: <span class="total_wait" data-count="{$val.count.total_wait|escape:'htmlall':'UTF-8'}">{$val.count.total_wait|escape:'htmlall':'UTF-8'}</span><br />
            <b>{l s='Errors' mod='kpswebp'}</b>: <span class="total_error">-</span><br /><div class="list_error" style="display:none"></div>
        </ps-label-information>
        <ps-switch name="{$val.id|escape:'htmlall':'UTF-8'}_delete"
            label="{l s='Delete old Webp images and regenerate' mod='kpswebp'}"
            yes="{l s='Yes' mod='kpswebp'}" no="{l s='No' mod='kpswebp'}"></ps-switch>
        <ps-panel-footer>
            <button type="button" onclick="kpswebpRunCalculateTotalImage('{$val.path|escape:'htmlall':'UTF-8'}', this)" class="btn btn-default pull-left">{l s='Calculate total images' mod='kpswebp'}</button>
            <ps-panel-footer-submit title="{l s='Start Convertion (NOT CLOSE THIS WINDOWS)' mod='kpswebp'}" icon="process-icon-save" direction="right" name="convertion"></ps-panel-footer-submit>
        </ps-panel-footer>
    </ps-panel>
</form>
{/foreach}
<style>
.form-kpswebp button[type="submit"]{
    display: none;
}
</style>
<script>
/**
* @author    Yipi.app
* @copyright 2019 Yipi.app
* @license   GPLv2
*/
var kpsweb_running = false;
var kpsweb_result = [];
//debugger;
function reload_js_riot() {
    jQuery('.form-kpswebp button[type="submit"]').hide();
}
function kpswebpRunCalculateTotalImage(path, btn) {
    if (kpsweb_running) {
        alert('Other task is working...');
        return;
    }
    var $ = jQuery;
    var form = jQuery(btn).closest('form');
    var url = $('#kpswebp_url_controller').val();
    $('.total_images', form).html('{l s='Please wait...' mod='kpswebp'}');
    kpsweb_running = true;
    $.ajax({
        url: url.replace('_CMD_', 'countTotal').replace('_PATH_', path),
        type: "POST",
        data: '',
        context: form,
        dataType: 'json',
        success: function(data) {
            kpsweb_running = false;
            console.log(data);
            $('.total_images', this).html(data.total_images);
            $('.total_images', this).attr('data-count', data.total_images);
            $('.total_webp', this).html(data.total_webp);
            $('.total_images', this).attr('data-count', data.total_images);
            $('.total_wait', this).html(data.total_wait);
            $('.total_images', this).attr('data-count', data.total_images);
            $('button[type="submit"]', this).show();
        },
        error: function(data) {
            kpsweb_running = false;
            console.log(data);
            alert('Internal server error...');
        }
    });
}
function kpswebpRunConvertion(path, el, threads, ignore_running) {
    if (!ignore_running && kpsweb_running) {
        alert('Other task is working...');
        return;
    }
    kpsweb_running = true;
    var $ = jQuery;
    var form = $(el);
    var is_delete = $('input[type=radio]:checked', form).val()*1;
    var url = $('#kpswebp_url_controller').val();
    if (!ignore_running && is_delete) {
        $.ajax({
            url: url.replace('_CMD_', 'delete').replace('_PATH_', path),
            type: "POST",
            data: '',
            context: form,
            dataType: 'json',
            success: function(data) {
                console.log(data);
                kpswebpRunConvertion(path, '#'+$(this).attr('id'), threads, true);
            },
            error: function(data) {
                console.log(data);
                alert('Internal server error...');
                kpsweb_running = false;
            }
        });
    } else {
        for(var i = 0; i < threads; ++i) {
            kpsweb_result[i] = {
                running: true,
                last_result: false
            };
            kpswebpRunThreadConvertion(path, el, i);
        }
        var lpswebpWaitEnding = setInterval(function() {
            var is_running = false;
            var file_with_error =  [];
            var total_error = 0;
            var total_webp = 0;
            var with_last = false;
            for(var i = 0; i < threads; ++i) {
                is_running = is_running || kpsweb_result[i].running;
                if (kpsweb_result[i].last_result) {
                    with_last = true;
                    file_with_error.concat(kpsweb_result[i].last_result.file_with_error);
                    total_error += kpsweb_result[i].last_result.total_error;
                    total_webp += kpsweb_result[i].last_result.total_webp;
                }
            }
            if (with_last) {
                var total_wait = $('.total_images', form).attr('data-count')*1 - total_error - total_webp;
                if (total_error > 0) {
                    $('.total_error', form).html(total_error+' - <a href="javascript:void(0)" onclick="jQuery(\'.list_error\', jQuery(this).closest(\'div\')).toggle()">Show/Hidden Errors</a>');
                    $('.list_error', form).html(file_with_error.join("<br />\n"));
                } else {
                    $('.total_error', form).html(total_error);
                }
                $('.total_webp', form).html(total_webp);
                $('.total_wait', form).html(total_wait);
            }
            if (!is_running) {
                clearInterval(lpswebpWaitEnding);
                kpsweb_running = false;
                alert('Conversion finished...');
            }
        }, 15000);
    }
}
function kpswebpRunThreadConvertion(path, el, idx) {
    var $ = jQuery;
    var form = $(el);
    var url = $('#kpswebp_url_controller').val();
    if (!$('.t_'+idx, form).length) {
        $(form).append('<span class="t_'+idx+'" data-path="'+path+'" data-idx="'+idx+'" style="display:none"></span>');
    }
    $.ajax({
        url: url.replace('_IDX_', idx).replace('_CMD_', 'generate').replace('_PATH_', path),
        type: "POST",
        data: '',
        context: $('.t_'+idx, form),
        dataType: 'json',
        fail: function(data) {
            var idx = $(this).attr('data-idx') * 1;
            var path = $(this).attr('data-path');
            var form = $(this).closest('form');
            console.log('Error T'+idx, data);
            $('.total_error', form).html('Internal server error on thread '+idx+'... Trying again...');
            setTimeout('kpswebpRunThreadConvertion("'+path+'", "#'+$(form).attr('id')+'", '+idx+')', 100);
        },
        error: function(data) {
            var idx = $(this).attr('data-idx') * 1;
            var path = $(this).attr('data-path');
            var form = $(this).closest('form');
            console.log('Error T'+idx, data);
            $('.total_error', form).html('Internal server error on thread '+idx+'... Trying again...');
            setTimeout('kpswebpRunThreadConvertion("'+path+'", "#'+$(form).attr('id')+'", '+idx+')', 100);
        }
    }).done(function(data) {
        var idx = $(this).attr('data-idx') * 1;
        var path = $(this).attr('data-path');
        var form = $(this).closest('form');
        console.log('T'+idx, data);
        kpsweb_result[idx].last_result = data;
        if (data.total_wait == 0) {
            kpsweb_result[idx].running = false;
        } else {
            setTimeout('kpswebpRunThreadConvertion("'+path+'", "#'+$(form).attr('id')+'", '+idx+')', 100);
        }
    });
}
</script>