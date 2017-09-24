import openfl.display.Sprite;

import net.rezmason.utils.workers.QuickBoss;
import net.rezmason.utils.workers.Golem;

typedef TestBoss = QuickBoss<Int, Array<Int>>;

class TestOpenFL extends Sprite
{
    var boss:TestBoss = null;
    var done:Bool = false;

    public function new() {
        super();

        trace('Hello');

        graphics.beginFill(0xFF0000);
        graphics.drawRect(0, 0, 100, 100);
        graphics.endFill();

        boss = new TestBoss(Golem.rise('../hxml/TestWorker.hxml'), onDone, null);
        boss.start();
        boss.send(100);
    }

    function onDone(results:Array<Int>):Void {
        trace(results.join('\n'));

        graphics.beginFill(0x00FF00);
        graphics.drawRect(0, 0, 100, 100);
        graphics.endFill();

        boss.die();
        done = true;
        trace("That'll do boss, that'll do");
    }
}
