# WebP for Prestashop by Yipi.app
Accept WebP Upload for all Store and convert the current images to webp.

## Minimum requirements
- Prestashop 1.5.0.15 or higher, 1.6.x or 1.7.x REQUIRED
- PHP 5.6 or higher REQUIRED
- PHP GD library compiled for compatibility with WebP images REQUIRED
- PHP FileInfo Library REQUIRED
- Apache server (it is not compatible with litespeed, it is compatible with Nginx if it works dually with Apache) MANDATORY – THERE IS NO MONEY REFUND IF YOU DO NOT VERIFY THIS CONDITION BEFORE PURCHASE..
- If your store works dual Nginx+Apache, remove the jpg and jpeg extensions in cpanel for static files served by nginx or, if you can, you should have access to modify the nginx configuration file to add the following configuration:
In the http block of the config file:
```
map $http_accept $webp_ext {
		default "";
		"~*webp" ".webp";
}
```
En el bloque server del archivo config
```
location ~* ^(/.+)\.(png|jpeg|jpg|gif){
		add_header Vary "Accept";
		add_header Cache-Control "public, no-transform";
		try_files $uri$webp_ext $uri =404;
}
```

- Have the friendly URL option enabled in Prestashop MANDATORY
- Optionally supports: EWWW
- Optionally supports: cwebp (running cwebp binary using an "exec" call), vips (using the PHP Vips extension), imagick (using the PHP Imagick extension), gmagick (using the PHP Gmagick extension), imagemagick (running imagemagick binary using a exec call) ), graphicsmagick (running graphicsmagick binary using an "exec" call), ffmpeg (running ffmpeg binary using an "exec" call)
