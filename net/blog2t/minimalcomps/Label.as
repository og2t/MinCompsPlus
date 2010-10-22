/**
 * Label.as
 * Keith Peters
 * 
 * A Label component for displaying a single line of text.
 * 
 * Copyright (c) 2010 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package net.blog2t.minimalcomps
{
	import net.blog2t.minimalcomps.Style;
	import com.bit101.components.Label;
	import flash.display.DisplayObjectContainer;
	
	public class Label extends com.bit101.components.Label
	{
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Label.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param text The string to use as the initial text in this component.
		 */
		public function Label(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
			super(parent, xpos, ypos, text);
		}
				
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			_tf.backgroundColor = Style.LABEL_BACKGROUND;
		}
		
		/**
		 * Gets / sets the background color of this Label.
		 */
		public function set background(value:Boolean):void
		{
			_tf.background = value;
		}
		
		public function get background():Boolean
		{
			return _tf.background;
		}
	}
}