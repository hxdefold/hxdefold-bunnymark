package bunnymark;

import Defold.hash;
import defold.types.Hash;


class BunnyImages
{
    static var images: Array<Hash> = [
        hash('rabbitv3_batman'),
        hash('rabbitv3_bb8'),
        hash('rabbitv3'),
        hash('rabbitv3_ash'),
        hash('rabbitv3_frankenstein'),
        hash('rabbitv3_neo'),
        hash('rabbitv3_sonic'),
        hash('rabbitv3_spidey'),
        hash('rabbitv3_stormtrooper'),
        hash('rabbitv3_superman'),
        hash('rabbitv3_tron'),
        hash('rabbitv3_wolverine')
    ];


    public static inline function getRandom(): Hash
    {
        return images[Math.floor(Math.random() * images.length)];
    }
}
