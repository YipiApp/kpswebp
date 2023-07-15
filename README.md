# Requisitos mínimos
- Prestashop 1.5.0.15 o superior, 1.6.x, 1.7.x o 8.x
-  PHP 5.6 o superior OBLIGATORIO
-  Librería de PHP GD compilado para compatibilidad con imágenes WebP OBLIGATORIO
-   Librería de PHP FileInfo OBLIGATORIO
-    Servidor Apache (no es compatible con litespeed, es compatible con Nginx si trabaja de forma dual con Apache) OBLIGATORIO – NO HAY DEVOLUCIÓN DE DINERO SI NO VERIFICA ESTA CONDICIÓN ANTES DE LA COMPRA..
-   Si tu tienda trabaja de forma dual Nginx+Apache, elimine las extensiones jpg y jpeg en el cpanel para los archivos estáticos servidos por nginx o, si puede, debe tener acceso para modificar el archivo de configuración de nginx para agregar la siguiente configuración:
En el bloque http del archivo config:
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

- Tener la opción de URL amigable habilitada en Prestashop OBLIGATORIO
Opcionalmente, admite: EWWW
Opcionalmente admite: cwebp (ejecutando cwebp binary usando una llamada «exec»), vips (usando la extensión PHP Vips), imagick (usando la extensión PHP Imagick), gmagick (usando la extensión PHP Gmagick), imagemagick (ejecutando imagemagick binary usando una llamada «exec») ), graphicsmagick (ejecutando graphicsmagick binary usando una llamada «exec»), ffmpeg (ejecutando ffmpeg binary usando una llamada «exec»)

# Sobre WebP
WebP es un formato gráfico en forma de contenedor, que sustenta tanto compresión con pérdida como sin ella. Lo está desarrollando Google, basándose en tecnología adquirida con la compra de On2 Technologies.​ Como derivado del formato de vídeo VP8, es un proyecto hermano del formato WebM,​ y está liberado bajo la licencia BSD.

## Tecnología
El algoritmo de compresión de WebP está basado en la codificación intra-frame del formato VP8 y RIFF como formato contenedor.​ Este formato de archivo está basado en la predicción de bloques. Cada bloque se predice a través de los tres bloques superiores y un bloque de la izquierda. Hay cuatro modos básicos de predicción de bloques: horizontal, vertical, DC (para un solo color) y True Motion. Los bloques impredecibles se comprimen en subpíxeles de 4×4 usando la transformada de coseno discreta o la transformación de Hadamard. Ambas transformaciones se llevan a cabo con operaciones aritméticas de punto fijo para evitar errores de redondeo. La salida de la imagen es comprimida con codificación entrópica

## Utilización
El formato pretende ser un nuevo estándar abierto para gráficos en color verdadero con compresión con pérdida, y por tanto siendo presentado como competidor directo del esquema JPEG, frente al que se espera superar en la producción de archivos de menor tamaño con una calidad de imagen comparable.

Chrome 9 fue el primer navegador en sustentar WebP de forma nativa. Posteriormente, también estuvo disponible nativamente en Opera 11.10, y es usado actualmente en dicho navegador para comprimir las imágenes cuando se activa la función turbo del mismo. A principios de 2019, el formato ya estaba disponible en una gran variedad de navegadores como Edge, Firefox, Opera Mobile y Mini, Android Browser, Baidu Browser, etc. excepto Safari.

El formato también está disponible en cualquier navegador compatible con WebM vía JavaScript.

El método propuesto ha sido analizado por diferentes autores, en los cuales WebP muestra un mejor rendimiento que JPEG, en especial al utilizar una razón (ratio, en latín) elevada de compresión​ y un efecto de imagen borrosa para ratios bajos.
