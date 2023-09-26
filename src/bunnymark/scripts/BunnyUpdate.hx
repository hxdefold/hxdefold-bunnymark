package bunnymark.scripts;

import defold.types.Vector3;


class BunnyUpdate extends Script
{
    var velocity: Float;

    override function init()
    {
        velocity = -100 * Math.random();
        Go.setPosition(Vmath.vector3(640 * Math.random(), 1000 + 100 * Math.random(), 0));
    }

    override function update(dt:Float)
    {
        velocity -= 1200 * dt;

        var pos: Vector3 = Go.getPosition();
        pos.y += velocity * dt;
        if (pos.y < 60)
        {
            velocity = -velocity;
            pos.y = 60;
        }

        Go.setPosition(pos);
    }
}
