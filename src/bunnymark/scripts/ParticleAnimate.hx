package bunnymark.scripts;

import defold.Particlefx;


class ParticleAnimate extends Script
{
    override function init()
    {
        Particlefx.play('#bunnies');

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
}
