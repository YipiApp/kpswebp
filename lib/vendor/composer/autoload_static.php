<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit0eb9af72509a37fc855164165dfaa1c2
{
    public static $prefixLengthsPsr4 = array (
        'W' => 
        array (
            'WebPConvert\\' => 12,
        ),
        'I' => 
        array (
            'ImageMimeTypeGuesser\\' => 21,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'WebPConvert\\' => 
        array (
            0 => __DIR__ . '/..' . '/rosell-dk/webp-convert/src',
        ),
        'ImageMimeTypeGuesser\\' => 
        array (
            0 => __DIR__ . '/..' . '/rosell-dk/image-mime-type-guesser/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit0eb9af72509a37fc855164165dfaa1c2::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit0eb9af72509a37fc855164165dfaa1c2::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
