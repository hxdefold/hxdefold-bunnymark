package bunnymark.scripts;

import lua.Table;
import Defold.hash;
import defold.types.Hash;
import defold.support.ScriptOnInputAction;
import defold.Label;
import defold.Vmath;
import defold.Go;
import defold.Go.GoMessages;
import defold.Msg;
import defold.support.Script;

class GoAnimate extends Script
{
    override function init()
    {
        Msg.post('.', GoMessages.acquire_input_focus);

        Bunnymark.start();
        spawn(500);

        Table.fromDynamic({
            key: 5,
            name: 'asdf'
        });
    }

    override function final_()
    {
        Bunnymark.stop();
    }

    override function update(dt: Float)
    {
        Bunnymark.update();
        Label.setText('#label', 'Bunnies: ${Bunnymark.getBunnyCount()} FPS: ${Bunnymark.getFps()}. Click to add more');
    }

    override function onInput(actionId: Hash, action: ScriptOnInputAction): Bool
    {
        if ((actionId == hash('touch')) && (action.y < 1030) && action.released)
        {
            spawn(500);
        }

        return false;
    }

    function spawn(amount: Int)
    {
        for (i in 0...amount)
        {
            var bunny: Bunny = Bunnymark.createBunny();
            if (bunny != null)
            {
                animateBunny(bunny);
            }
            else
            {
                Sys.println('Unable to create more bunnies');
                Msg.post('.', GoMessages.release_input_focus);
                Msg.post('multiple:/go', Messages.collection_full);
                break;
            }
        }
    }

    function animateBunny(bunny: Bunny)
    {
        Go.setPosition(Vmath.vector3(Math.random() * 640, 1030, 0), bunny.id);
        Go.animate(bunny.id, GoProperties.positionY, LoopPingPong, 40, InQuad, 2, Math.random());
    }
}
