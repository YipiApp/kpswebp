{*
* Template para MercadoPago
*
* @author    Yipi.app
* @copyright 2019 Yipi.app
* @license   GPLv2
*}
<script type="text/javascript" src="{$riot_compiler_url}"></script>
<script type="text/javascript">
    var result = $("<div />").html($("#b64_riot").html()).text();
    result = result.replace(/X_RN_X/g, "\n");
    result = result.replace(/_\*_/g, "\t");
    console.log(result);
    $("#b64_riot").html(result);
    $("#b64_riot").show(0);
    riot.compile(function() {
      var tags = riot.mount("*");
      reload_js_riot();
    });
</script>