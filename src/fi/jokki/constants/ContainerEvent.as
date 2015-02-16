/**
 * Created by Jokki on 2/16/2015.
 */
package fi.jokki.constants {
	import fi.jokki.namespaces.container_namespace;

	import flash.events.Event;

	public class ContainerEvent extends Event {
		public static const WIDTH_CHANGED:String = "widthChanged";
		public static const HEIGHT_CHANGED:String = "heightChanged";
		public static const LAYOUT_TYPE_CHANGED:String = "layoutTypeChanged";
		public static const LAYOUT_MODE_CHANGED:String = "layoutModeChanged";
		public static const HORIZONTAL_ALIGN_CHANGED:String = "horizontalAlignChanged";
		public static const VERTICAL_ALIGN_CHANGED:String = "verticalAlignChanged";

		private var _oldWidth:Number;
		private var _oldHeight:Number;
		private var _newWidth:Number;
		private var _newHeight:Number;

		public function ContainerEvent(type:String) {
			super(type);
		}

		public function get oldWidth():Number {
			return _oldWidth;
		}

		public function get oldHeight():Number {
			return _oldHeight;
		}

		public function get newWidth():Number {
			return _newWidth;
		}

		public function get newHeight():Number {
			return _newHeight;
		}

		container_namespace function set oldWidth(value:Number):void {
			_oldWidth = value;
		}

		container_namespace function set oldHeight(value:Number):void {
			_oldHeight = value;
		}

		container_namespace function set newWidth(value:Number):void {
			_newWidth = value;
		}
	}
}
