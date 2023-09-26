package bunnymark.scripts;

import defold.support.Script;


class GoAnimateCollection extends GoAnimate
{
    @property var min_x: Float = 0;
    @property var max_x: Float = 640;


    override function animateBunny(bunny: Bunny)
    {
        var posX: Float = min_x + Math.random() * (max_x - min_x);
        Go.setPosition(Vmath.vector3(posX, 1030, 0), bunny.id);
        Go.animate(bunny.id, GoProperties.positionY, LoopPingPong, 40, InQuad, 2, Math.random());
    }

    override function update(dt: Float)
    {

    }
}
