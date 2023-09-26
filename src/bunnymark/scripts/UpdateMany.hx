package bunnymark.scripts;


class UpdateMany extends Script
{
    override function init()
    {
        Bunnymark.start();

        for (i in 0...1024)
        {
            Bunnymark.createBunny();
        }
    }

    override function update(dt: Float)
    {
        Bunnymark.update();
        Label.setText('#label', 'Bunnies: ${Bunnymark.getBunnyCount()} FPS: ${Bunnymark.getFps()}. Click to add more');
    }

    override function final_()
    {
        Bunnymark.stop();
    }
}
