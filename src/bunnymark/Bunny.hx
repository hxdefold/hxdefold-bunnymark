package bunnymark;

import defold.types.Vector3;
import defold.Gui.GuiNode;
import defold.types.Url;


typedef Bunny =
{
    var ?id: Url;
    var ?node: GuiNode;
    var ?position: Vector3;
    var ?velocity: Float;
};
