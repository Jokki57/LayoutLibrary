/**
 * Created by Jokki on 2/16/2015.
 */
package fi.jokki {
	import fi.jokki.constants.ContainerEvent;
	import fi.jokki.constants.HorizontalAlign;
	import fi.jokki.constants.LayoutMode;
	import fi.jokki.constants.LayoutType;
	import fi.jokki.constants.VerticalAlign;
	import fi.jokki.namespaces.container_namespace;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class BaseContainer extends Sprite {
		private const LAYOUT_TYPE_COUNT:int = 2;
		private const ALIGNMENT_COUNT:int = 3;
		private const LAYOUT_MODE_COUNT:int = 3;

		protected var children:Vector.<BaseContainer>;

		private var _layoutType:int = 0;
		private var _layoutMode:int = 0;
		private var _horizontalAlign:int = 0;
		private var _verticalAlign:int = 0;

		private var _marginTop:int;
		private var _marginBottom:int;
		private var _marginLeft:int;
		private var _marginRight:int;

		public function BaseContainer() {
			children = new Vector.<BaseContainer>();
		}

		//PRIVATE FUNCTIONS
		private function rebuildLayout():void {
			if (_layoutType == LayoutType.ABSOLUTE_LAYOUT && _layoutMode == LayoutMode.OVERLAY) {
				return;
			}
			var i:int;
			var length:int = children.length;
			var prevItem:BaseContainer;
			var currentItem:BaseContainer;
			switch (_layoutMode) {
				case LayoutMode.HORIZONTAL:
					for (i = 0; i < length; i++) {
						currentItem = children[i];
						if (i != 0) {
							prevItem = children[i-1];
							children[i].x = prevItem.x + prevItem.width + prevItem.marginRight + currentItem.marginLeft;
						} else {
							currentItem.x = currentItem.marginLeft;
						}
						switch (currentItem.verticalAlign) {
							case VerticalAlign.TOP:
								currentItem.y = currentItem.marginTop;
								break;
							case VerticalAlign.MIDDLE:
								currentItem.y = (this.height - currentItem.height) / 2 + currentItem.marginTop - currentItem.marginBottom;
								break;
							case VerticalAlign.BOTTOM:
								currentItem.y = this.height - currentItem.height - currentItem.marginBottom;
						}

					}
					break;
				case LayoutMode.VERTICAL:
					for (i = 0; i < length; i++) {
						currentItem = children[i];
						if (i != 0) {
							prevItem = children[i-1];
							children[i].y = prevItem.y + prevItem.height + prevItem.marginBottom + currentItem.marginTop;
						} else {
							currentItem.y = currentItem.marginTop;
						}
						switch (currentItem.horizontalAlign) {
							case HorizontalAlign.LEFT:
								currentItem.x = currentItem.marginLeft;
								break;
							case HorizontalAlign.CENTER:
								currentItem.x = (this.width - currentItem.width) / 2 + currentItem.marginLeft - currentItem.marginRight;
								break;
							case HorizontalAlign.RIGHT:
								currentItem.x = this.width - currentItem.width - currentItem.marginRight;
						}
					}
					break;
			}


		}

		//PROTECTED FUNCTION



		//OVERRIDES
		override public function addChild(child:DisplayObject):DisplayObject {
			if (children.indexOf(child) == -1) {
				children.push(child);
			}
			return super.addChild(child);
		}

		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (children.indexOf(child) == -1) {
				children.splice(index, 0, child);
			}
			return super.addChildAt(child, index);
		}

		override public function removeChildAt(index:int):DisplayObject {
			if (index <= children.length - 1) {
				children.splice(index, 1);
			}
			return super.removeChildAt(index);
		}

		override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void {
			var count:int = endIndex - beginIndex;
			if (beginIndex <= children.length - 1 && count > 0 && count <= children.length ) {
				children.splice(beginIndex, endIndex - beginIndex);
			}
			super.removeChildren(beginIndex, endIndex);
		}

		override public function removeChild(child:DisplayObject):DisplayObject {
			var index:int = children.indexOf(child);
			if (index != -1) {
				children.splice(index, 1);
			}
			return super.removeChild(child);
		}


		//PROPERTIES

		public function get layoutType():int {
			return _layoutType;
		}
		public function set layoutType(value:int):void {
			if (value >= 0 && value < LAYOUT_TYPE_COUNT) {
				_layoutType = value;
				this.dispatchEvent(new ContainerEvent(ContainerEvent.LAYOUT_TYPE_CHANGED));
			}
		}

		public function get layoutMode():int {
			return _layoutMode;
		}
		public function set layoutMode(value:int):void {
			if (value >= 0 && value < LAYOUT_MODE_COUNT) {
				_layoutMode = value;
				this.dispatchEvent(new ContainerEvent(ContainerEvent.LAYOUT_MODE_CHANGED));
			}
		}

		public function get horizontalAlign():int {
			return _horizontalAlign;
		}
		public function set horizontalAlign(value:int):void {
			if (value >= 0 && value < ALIGNMENT_COUNT) {
				_horizontalAlign = value;
				this.dispatchEvent(new ContainerEvent(ContainerEvent.HORIZONTAL_ALIGN_CHANGED));
			}
		}

		public function get verticalAlign():int {
			return _verticalAlign;
		}
		public function set verticalAlign(value:int):void {
			if (value >= 0 && value < ALIGNMENT_COUNT) {
				_verticalAlign = value;
				this.dispatchEvent(new ContainerEvent(ContainerEvent.VERTICAL_ALIGN_CHANGED));
			}
		}

		public function get marginTop():int {
			return _marginTop;
		}

		public function set marginTop(value:int):void {
			_marginTop = value;
		}
		public function get marginBottom():int {
			return _marginBottom;
		}
		public function set marginBottom(value:int):void {
			_marginBottom = value;
		}

		public function get marginLeft():int {
			return _marginLeft;
		}
		public function set marginLeft(value:int):void {
			_marginLeft = value;
		}

		public function get marginRight():int {
			return _marginRight;
		}
		public function set marginRight(value:int):void {
			_marginRight = value;
		}
	}
}
