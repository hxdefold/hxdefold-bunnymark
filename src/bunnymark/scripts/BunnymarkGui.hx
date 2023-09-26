package bunnymark.scripts;

import defold.CollectionProxy.CollectionProxyMessages;
import defold.types.Message;
import defold.types.Url;
import defold.Sys;
import defold.Gui;
import defold.Gui.GuiNode;
import defold.Render.RenderMessages;
import defold.support.GuiScript;


class BunnymarkGui extends GuiScript
{
    var currentProxy: Url;
    var menuEnabled: Bool = true;
    var testRootNode: GuiNode = Gui.getNode('test_root');
    var toggleProfilerNode: GuiNode = Gui.getNode('toggle_profiler');
    var backNode: GuiNode = Gui.getNode('back');

    var menuRootNode: GuiNode = Gui.getNode('menu_root');
    var goAnimateNode: GuiNode = Gui.getNode('go_animate');
    var goAnimateMultipleNode: GuiNode = Gui.getNode('go_animate_multiple');
    var updateSingleNode: GuiNode = Gui.getNode('update_single');
    var updateManyNode: GuiNode = Gui.getNode('update_many');
    var particleFxNode: GuiNode = Gui.getNode('particlefx');
    var guiAnimateNode: GuiNode = Gui.getNode('gui_animate');


    override function init()
    {
        Msg.post('.', GoMessages.acquire_input_focus);
        Msg.post('@render:', RenderMessages.clear_color, {
            color: Vmath.vector4(0.4, 0.5, 0.8, 1.0)
        });

        Gui.setEnabled(testRootNode, false);
        Gui.setText(Gui.getNode('version'), Sys.getEngineInfo().version);
    }

    override function onMessage<TMessage>(messageId: Message<TMessage>, message: TMessage, sender: Url)
    {
        switch messageId
        {
            case CollectionProxyMessages.proxy_loaded:
            {
                Msg.post(sender, CollectionProxyMessages.enable);
                menuEnabled = false;

                Gui.setEnabled(testRootNode, true);
                Gui.setEnabled(menuRootNode, false);
            }

            case CollectionProxyMessages.proxy_unloaded:
            {
                menuEnabled = true;
                Gui.setEnabled(testRootNode, false);
                Gui.setEnabled(menuRootNode, true);
            }
        }
    }

    override function onInput(actionId: Hash, action: ScriptOnInputAction): Bool
    {
        if ((actionId == hash('touch')) && action.released)
        {
            if (menuEnabled)
            {
                if (Gui.pickNode(goAnimateNode, action.x, action.y))
                {
                    load('#go_animate_proxy');
                }
                else if (Gui.pickNode(updateSingleNode, action.x, action.y))
                {
                    load('#update_single_proxy');
                }
                else if (Gui.pickNode(updateManyNode, action.x, action.y))
                {
                    load('#update_many_proxy');
                }
                else if (Gui.pickNode(particleFxNode, action.x, action.y))
                {
                    load('#particlefx_proxy');
                }
                else if (Gui.pickNode(goAnimateMultipleNode, action.x, action.y))
                {
                    load('#go_animate_multiple_proxy');
                }
                else if (Gui.pickNode(guiAnimateNode, action.x, action.y))
                {
                    load('#gui_animate_proxy');
                }
            }
            else
            {
                if (Gui.pickNode(backNode, action.x, action.y))
                {
                    Msg.post(currentProxy, CollectionProxyMessages.unload);
                }
                else if (Gui.pickNode(toggleProfilerNode, action.x, action.y))
                {
                    Msg.post('@system:', SysMessages.toggle_profile);
                }
            }
        }

        return false;
    }

    function load(proxyUrl: String)
    {
        currentProxy = Msg.url(proxyUrl);
        Msg.post(currentProxy, CollectionProxyMessages.load);
    }
}
