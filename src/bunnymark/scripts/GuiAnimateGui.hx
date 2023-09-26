package bunnymark.scripts;

import defold.Gui;
import defold.support.GuiScript;


class GuiAnimateGui extends GuiScript
{
    override function init()
    {
        spawn(512);
    }

    function animateBunny(bunny: Bunny)
    {
        Gui.setPosition(bunny.node, Vmath.vector3(Math.random() * 640, 1030, 0));
        Gui.animate(bunny.node, 'position.y', 40, InQuad, 2, Math.random());
    }

    function spawn(amount: Int)
    {
        for (i in 0...amount)
        {
            var bunny: Bunny = Bunnymark.createGuiBunny();
            if (bunny != null)
            {
                animateBunny(bunny);
            }
            else
            {
                Sys.println('Unable to create more bunnies');
                break;
            }
        }
    }
}
