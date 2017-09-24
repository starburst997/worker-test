import openfl.display.Sprite;
import openfl.events.Event;

import net.rezmason.utils.workers.QuickBoss;
import net.rezmason.utils.workers.Golem;

typedef TestBoss = QuickBoss<Int, Array<Int>>;

class TestOpenFL extends Sprite
{
    var boss:TestBoss = null;
    var done:Bool = false;

    var ball:Sprite;

    public function new() {
        super();

        trace('Hello');

        ball = new Sprite();
        ball.graphics.beginFill(0x0000FF);
        ball.graphics.drawCircle(0, 0, 50);
        ball.graphics.endFill();
        addChild(ball);

        graphics.beginFill(0xFF0000);
        graphics.drawRect(0, 0, 100, 100);
        graphics.endFill();

        boss = new TestBoss(Golem.rise('../hxml/TestWorker.hxml'), onDone, null);
        boss.start();

        #if mobile
        boss.send(1000000);
        #else
        boss.send(10000000);
        #end

        var xs = 1, ys = 1;
        addEventListener(Event.ENTER_FRAME, (_) -> {
            ball.x += xs;
            ball.y += ys;

            if (ball.x > 200 || ball.x < 0) xs *= -1;
            if (ball.y > 200 || ball.y < 0) ys *= -1;
        });
    }

    function onDone(results:Array<Int>):Void {
        //trace(results.join('\n'));

        graphics.beginFill(0x00FF00);
        graphics.drawRect(0, 0, 100, 100);
        graphics.endFill();

        boss.die();
        done = true;
        trace("That'll do boss, that'll do");
    }
}
