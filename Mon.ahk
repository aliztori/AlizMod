;No Dependencies

class Mon {
	
	static Call(N) {

		MonitorGet(N, &Left, &Top, &Right, &Bottom)
		return {Left: Left, Top: Top, Right: Right, Bottom: Bottom}
	}

	static WorkArea(N) {
		
		MonitorGetWorkArea(N, &Left, &Top, &Right, &Bottom)
		return {Left: Left, Top: Top, Right: Right, Bottom: Bottom}
	}
	
	static Name(N)	  => MonitorGetName(N)
	static Primary	  => MonitorGetPrimary()
	static Count 	  => MonitorGetCount()
	static Virtual	  => {
							 X: SysGet(76),
							 Y: SysGet(77), 
							 Width: SysGet(78), 
							 Height: SysGet(79)
						 }
}