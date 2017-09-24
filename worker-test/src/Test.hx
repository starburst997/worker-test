import net.rezmason.utils.workers.QuickBoss;
import net.rezmason.utils.workers.Golem;

typedef TestBoss = QuickBoss<Int, Array<Int>>;

class Test
{
    static var boss:TestBoss = null;
    static var done:Bool = false;

    static function main():Void {
        boss = new TestBoss(Golem.rise('../hxml/TestWorker.hxml'), onDone, null);
        boss.start();
        boss.send(100);

        #if (neko || cpp) while (!done) {} #end
    }

    static function onDone(results:Array<Int>):Void {
        trace(results.join('\n'));
        boss.die();
        done = true;
        trace("That'll do boss, that'll do");
    }
}
