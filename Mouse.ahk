
#Include <Mon>

class Mouse {
    
    static Call(Param?, Coord?, Flag?) {

        CoordMode("Mouse", Coord ?? "Screen")

        if IsSet(Param)
            try return (Param = "Ctrl") ? (this.Ctrl[Flag?]) : (this.%Param%)
        
            catch Error as e
            {
                MsgBox(e.Message, "Error")
                return false
            }

        MouseGetPos(&X, &Y, &Win, &Ctrl, Flag?)
        return {X: X, Y: Y, Win: Win, Ctrl: Ctrl}
    }

    static X           => (MouseGetPos( &X), X)
    static Y           => (MouseGetPos(, &Y), Y)
    static Win         => (MouseGetPos(,, &Win), Win)
    static Ctrl[Flag?] => (MouseGetPos(,,, &Ctrl,Flag?), Ctrl)

	static IsOverCtrl(ID, Mode?) => (ID = this.Ctrl[Mode?])
	static IsOverWin(ID) 		 => (ID = this.Win)

    static GetPos(X := "X", Y := "Y", Coord := "Screen") {
    
        (Coord = "Monitor") 
        ? CoordMode("Mouse", "Screen") 
        : CoordMode("Mouse", Coord)

        MouseGetPos(&XX, &YY)

        if (Coord = "Monitor")
        {
            XX -= this.InMon().X
            YY -= this.InMon().Y
        }

        return {%X%: XX, %Y%:YY}
    }

    static GetID(Win := "Win", Ctrl := "Ctrl", Flag?) {

        MouseGetPos(,, &WinID, &CtrlID, Flag?)
        return {%Win%: WinID, %Ctrl%: CtrlID}

    }

    static SavePos() {

        CoordMouse :=  A_CoordModeMouse
        CoordMode("Mouse", "Screen")

        MouseGetPos(&X, &Y)
        this.SavedX := X
        this.SavedY := Y

        CoordMode("Mouse", CoordMouse)
    }

    static RestorePos() {

        CoordMouse := A_CoordModeMouse
        CoordMode("Mouse", "Screen")

        MouseMove(this.SavedX, this.SavedY, 0)

        CoordMode("Mouse", CoordMouse)
    }

    static InWhichMon {

        Get {

            Coord := A_CoordModeMouse
            CoordMode("Mouse", "Screen")
            MouseGetPos(&X, &Y)

            loop Mon.Count
            {
                Monitor := Mon(A_Index)
        
                Top := Monitor.Top
                Left := Monitor.Left
                Right := Monitor.Right
                Bottom := Monitor.Bottom
        
                if (X >= Left && Y >= Top && X <= Right && Y <= Bottom)
                {
                    CoordMode("Mouse", Coord)
                    return A_Index
                }

                if (A_Index >= Mon.Count)
                {
                    Tippy("Failed to Get the Monitor That the Mouse is Within")
                    return false
                }
            }
        }
    }

    static Monitor(N := this.InWhichMon) {

        Monitor := Mon(N)
        return {
                    X: Monitor.Left,
                    Y: Monitor.Top,
                    W: Monitor.Right - Monitor.Left,
                    H: Monitor.Bottom - Monitor.Top
               }
    }

    static InMon() {

        Coord := A_CoordModeMouse
        CoordMode("Mouse", "Screen")
        
        MouseGetPos(&X, &Y)
    
        loop Mon.Count
        {
            Monitor := Mon(A_Index)
    
            Top := Monitor.Top
            Left := Monitor.Left
            Right := Monitor.Right
            Bottom := Monitor.Bottom
    
            if (X >= Left && Y >= Top && X <= Right && Y <= Bottom)
            {
                CoordMode("Mouse", Coord)
                return {
                            Monitor: A_Index,
                            X: Left,
                            Y: Top, 
                            W: Right - Left, 
                            H: Bottom - Top
                       }
            }

            if (A_Index >= Mon.Count)
            {
                Tippy("Failed to Get the Monitor That the Mouse is Within")
                Exit()
            }
        }
    }


}
