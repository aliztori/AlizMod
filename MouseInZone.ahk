;No dependencies

class MouseInZone {

    __New(Margin := 50) {

        this.Margin := Margin
        this.Montor := Mouse.InMon()
        this.Mouse  := Mouse.GetPos("X", "Y", "Monitor")
    }

    Top        	=> this.Mouse.Y <= this.Margin
    Left       	=> this.Mouse.X <= this.Margin
    Bottom     	=> this.Mouse.Y >= this.Montor.H - this.Margin
    Right      	=> this.Mouse.X >= this.Montor.W - this.Margin

	TopLeft    	=> this.Top     && this.Left
	TopRight   	=> this.Top     && this.Right
	BottomLeft 	=> this.Bottom  && this.Left
	BottomRight => this.Bottom  && this.Right

    All(Except*) {

        IsIn := (this.Top || this.Bottom || this.Left || this.Right)

        for Edge, Edge in Except
            try IsIn &= !this.%Edge%

        catch Any
        {
            Msgbox("Invalid Edges")
            return false
        }
        
        return IsIn
    }	   

    Edges(Edges*) {
        
        if Edges.Length = 0
            return (this.Top || this.Bottom || this.Left || this.Right) 
        
		for Edge, Edge in Edges
          try IsIn &= this.%Edge%

        catch Any 
            return false

        return IsIn
    }

    Corners(Corners*) {
    
        if Corners.Length = 0
            return (this.TopLeft || this.TopRight || this.BottomLeft || this.BottomRight) 
        
        IsIn := false

        for Edge, Corner in Corners
          try IsIn |= this.%Corner%

        catch Any
            return false
        
        return IsIn
    } 
	
	NotCorner(Edges*) {
	
		if (Edges.Length != 2)
		{
			Msgbox("You Only Need to Enter Two Parameters")
			return false
		}

		IsIn := false

		for Edge, EdgeName in Edges
			try IsIn ^= this.%Edge%

        catch Any
            return false

		return IsIn
	}
}