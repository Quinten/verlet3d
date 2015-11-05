package flat.verlet3d 
{
	/**
	 * @author Quinten Clause
	 */
	public class Verlet3dPoint 
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		private var _oldX:Number = 0;
		private var _oldY:Number = 0;
		private var _oldZ:Number = 0;
		
		private var _tempX:Number = 0;
		private var _tempY:Number = 0;
		private var _tempZ:Number = 0;
		
		public function Verlet3dPoint(x_:Number = 0, y_:Number = 0, z_:Number = 0) 
		{
			setPosition(x_, y_, z_);
		}
		
		public function update():void
		{
			_tempX = x;
			_tempY = y;
			_tempZ = z;
			x += vX;
			y += vY;
			z += vZ;
			_oldX = _tempX;
			_oldY = _tempY;
			_oldZ = _tempZ;
		}
		
		public function setPosition(x_:Number = 0, y_:Number = 0, z_:Number = 0):void
		{
			x = _oldX = x_;
			y = _oldY = y_;
			z = _oldZ = z_;
		}
		
		public function constrainBounds(left_:Number, right_:Number, bottom_:Number, top_:Number, back_:Number, front_:Number):void
		{
			x = Math.max(left_, Math.min(right_, x));
			y = Math.max(bottom_, Math.min(top_, y));
			z = Math.max(back_, Math.min(front_, z));
		}
		
		public function set vX(value:Number):void
		{
			_oldX = x - value;
		}
		
		public function set vY(value:Number):void
		{
			_oldY = y - value;
		}
		
		public function set vZ(value:Number):void
		{
			_oldZ = z - value;
		}
		
		public function get vX():Number
		{
			return x - _oldX; 
		}
		
		public function get vY():Number
		{
			return y - _oldY; 
		}
		
		public function get vZ():Number
		{
			return z - _oldZ; 
		}
	}
}