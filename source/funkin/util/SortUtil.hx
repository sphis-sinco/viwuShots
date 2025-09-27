package funkin.util;

#if !macro
import flixel.FlxBasic;
import flixel.util.FlxSort;
import sphis.viwushots.Balloon;
#end

/**
 * Utility functions related to sorting.
 *
 * NOTE: `Array.sort()` takes a function `(x, y) -> Int`.
 * If the objects are in the correct order (x before y), return a negative value.
 * If the objects need to be swapped (y before x), return a negative value.
 * If the objects are equal, return 0.
 *
 * NOTE: `Array.sort()` does NOT guarantee that the order of equal elements. `haxe.ds.ArraySort.sort()` does guarantee this.
 * NOTE: `Array.sort()` may not be the most efficient sorting algorithm for all use cases (especially if the array is known to be mostly sorted).
 *    You may consider using one of the functions in `funkin.util.tools.ArraySortTools` instead.
 * NOTE: Both sort functions modify the array in-place. You may consider using `Reflect.copy()` to make a copy of the array before sorting.
 */
@:nullSafety
class SortUtil
{
	/**
	 * You can use this function in FlxTypedGroup.sort() to sort FlxObjects by their z-index values.
	 * The value defaults to 0, but by assigning it you can easily rearrange objects as desired.
	 *
	 * @param order Either `FlxSort.ASCENDING` or `FlxSort.DESCENDING`
	 * @param a The first FlxObject to compare.
	 * @param b The second FlxObject to compare.
	 * @return 1 if `a` has a higher z-index, -1 if `b` has a higher z-index.
	 */
	public static inline function byZIndex(order:Int, a:FlxBasic, b:FlxBasic):Int
	{
		if (a == null || b == null)
			return 0;
		return FlxSort.byValues(order, a.zIndex, b.zIndex);
	}

	public static inline function byZIndexBalloon(order:Int, a:Balloon, b:Balloon):Int
	{
		if (a == null || b == null)
			return 0;
		return FlxSort.byValues(order, a.zIndex, b.zIndex);
	}
}
