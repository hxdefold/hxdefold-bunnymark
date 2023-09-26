package bunnymark.scripts;

import defold.Factory;


class GuiAnimate extends Script
{
    override function init()
    {
        Msg.post('.', GoMessages.acquire_input_focus);

        Bunnymark.start();
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
            Factory.create('#factory');
        }

        return false;
    }
}
