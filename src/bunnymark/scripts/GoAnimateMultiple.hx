package bunnymark.scripts;

import defold.types.Message;
import defold.CollectionProxy.CollectionProxyMessages;
import defold.types.Url;


class GoAnimateMultiple extends Script
{
    var currentCollection: Int = 0;


    override function init()
    {
        Msg.post('.', GoMessages.acquire_input_focus);

        Bunnymark.start();

        loadNextCollection();
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

    override function onMessage<TMessage>(messageId: Message<TMessage>, message: TMessage, sender: Url)
    {
        switch messageId
        {
            case CollectionProxyMessages.proxy_loaded:
            {
                Msg.post(sender, GoMessages.enable);
            }

            case Messages.collection_full:
            {
                loadNextCollection();
            }
        }
    }

    function loadNextCollection()
    {
        var collections: Array<Url> = [
            Msg.url('multiple:/go#proxy_one'),
            Msg.url('multiple:/go#proxy_two'),
            Msg.url('multiple:/go#proxy_three')
        ];

        if (currentCollection < collections.length)
        {
            Msg.post(collections[currentCollection], CollectionProxyMessages.async_load);
            currentCollection++;
        }
        else
        {
            Sys.print('No more collections to load!');
        }
    }
}
