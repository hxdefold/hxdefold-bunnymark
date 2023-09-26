package bunnymark.scripts;

import defold.types.Vector3;


class UpdateSingle extends Script
{
    override function init()
    {
        Msg.post('.', GoMessages.acquire_input_focus);

        Bunnymark.start();
        spawn(500);
    }

    override function onInput(actionId: Hash, action: ScriptOnInputAction): Bool
    {
        if ((actionId == hash('touch')) && (action.y < 1030) && action.released)
        {
            spawn(500);
        }

        return false;
    }

    override function update(dt:Float)
    {
        Bunnymark.update();

        for (bunny in Bunnymark.bunnies)
        {
            bunny.velocity -= 1200 * dt;

            bunny.position.y += bunny.velocity * dt;
            if (bunny.position.y < 50)
            {
                bunny.position.y = 50;
                bunny.velocity = -bunny.velocity;
            }

            Go.setPosition(bunny.position, bunny.id);
        }

        Label.setText('#label', 'Bunnies: ${Bunnymark.getBunnyCount()} FPS: ${Bunnymark.getFps()}. Click to add more');
    }

    function spawn(amount: Int)
    {
        for (i in 0...amount)
        {
            var bunny: Bunny = Bunnymark.createBunny();
            if (bunny != null)
            {
                initBunny(bunny);
            }
            else
            {
                Sys.println('Unable to create more bunnies');
                break;
            }
        }
    }

    function initBunny(bunny: Bunny)
    {
        bunny.position = Vmath.vector3(640 * Math.random(), 930 + 100 * Math.random(), 0);
        bunny.velocity = -200 * Math.random();
    }
}
