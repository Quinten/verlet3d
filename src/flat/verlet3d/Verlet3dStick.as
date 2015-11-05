package flat.verlet3d 
{
	/**
	 * @author Quinten Clause
	 */
	public class Verlet3dStick 
	{
		private var _pointA:Verlet3dPoint;
		private var _pointB:Verlet3dPoint;
		
		private var _length:Number = 0;
		
		private var _distance:Number = 0;
		private var _difference:Number = 0;
		private var _offsetX:Number = 0;
		private var _offsetY:Number = 0;
		private var _offsetZ:Number = 0;
		
		public function Verlet3dStick(pointA_:Verlet3dPoint, pointB_:Verlet3dPoint) 
		{
			_pointA = pointA_;
			_pointB = pointB_;
			_length = Math.sqrt(Math.pow(_pointB.x - _pointA.x, 2) + Math.pow(_pointB.y - _pointA.y, 2) + Math.pow(_pointB.z - _pointA.z, 2));
		}
		
		public function update():void
		{
			_distance = Math.sqrt(Math.pow(_pointB.x - _pointA.x, 2) + Math.pow(_pointB.y - _pointA.y, 2) + Math.pow(_pointB.z - _pointA.z, 2));
			_difference = _length - _distance;
			_offsetX = (_difference * (_pointB.x - _pointA.x) / _distance) / 2;
			_offsetY = (_difference * (_pointB.y - _pointA.y) / _distance) / 2;
			_offsetZ = (_difference * (_pointB.z - _pointA.z) / _distance) / 2;
			_pointA.x -= _offsetX; 
			_pointA.y -= _offsetY;
			_pointA.z -= _offsetZ;
			_pointB.x += _offsetX; 
			_pointB.y += _offsetY;
			_pointB.z += _offsetZ;
		}
		
	}
}