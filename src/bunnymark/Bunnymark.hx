package bunnymark;

import defold.Vmath;
import defold.Gui;
import defold.Gui.GuiNode;
import Defold.hash;
import defold.Sprite.SpriteMessages;
import defold.Msg;
import defold.Factory;
import defold.types.Url;
import defold.types.Hash;
import lua.lib.luasocket.Socket;
using StringTools;


class Bunnymark
{
    public static var bunnies(default, null): Array<Bunny>;
    static var frames: Array<Float>;


    public static function start()
    {
        bunnies = [];
        frames = [ 0 ];
    }

    public static function stop()
    {
        // do nothing, bunnies will get deleted with the collection when it is unloaded
    }

    public static inline function update()
    {
        frames.push(Socket.gettime());
    }

    public static inline function getBunnyCount(): Int
    {
        return bunnies.length;
    }

    public static function getFps(): String
    {
        var fps: Float = 0;
        while (frames.length >= 61)
        {
            frames.shift();
        }

        fps = 1 / ((frames[frames.length - 1] - frames[0]) / (frames.length - 1));

        // round to 2 decimals
        var fpsRounded: Float = Math.round(fps * 100) / 100;

        return Std.string(fpsRounded).rpad('0', 5);
    }

    public static function createBunny(): Bunny
    {
        var id: Hash = Factory.create('#factory');
        var bunny: Bunny = null;

        if ((id != null) && (id != hash('')))
        {
            var spriteUrl: Url = Msg.url(null, id, 'sprite');
            var anim: Hash = BunnyImages.getRandom();
            Msg.post(
                spriteUrl,
                SpriteMessages.play_animation,
                { id: anim }
            );

            bunny = {
                id: Msg.url(null, id, null)
            };
            bunnies.push(bunny);
        }

        return bunny;
    }

    public static function createGuiBunny(): Bunny
    {
        var box: GuiNode = Gui.newBoxNode(Vmath.vector3(), Vmath.vector3());
        var bunny: Bunny = null;

        if (box != null)
        {
            Gui.setSizeMode(box, Auto);
            Gui.setTexture(box, 'bunnymark');
            Gui.playFlipbook(box, BunnyImages.getRandom());

            bunny = {
                node: box
            };
            bunnies.push(bunny);
        }

        return bunny;
    }
}
