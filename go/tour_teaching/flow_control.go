package tourteaching

import (
	"fmt"
	"math"
	"runtime"
	"time"
	"os"
	"io"
)

func LoopControl_1() {
	sum := 0
	for i := 0; i < 10; i++ {
		fmt.Printf("i value is :%v \n", i)
		sum += i
	}
	fmt.Printf("sum: %v \n", sum)
}

func LoopControl_2() {
	var sum int = 0
	for sum < 10 {
		sum++
		fmt.Printf("sum value is : %v \n", sum)
	}
}

func LoopControl_3() {
	var sum int = 0
	for sum < 10 {
		sum++
		fmt.Printf("sum value is : %v \n", sum)
	}
}

func LoopControl_4() {
	times := 0
	var channel_10 <-chan time.Time = time.After(time.Millisecond * 1)

wait_10s:
	for {
		select {
		case <-channel_10:
			fmt.Print("150ms结束")
			break wait_10s
		default:
			times++
			time.Sleep(time.Second)
			fmt.Printf("infinity loop : %v \n", times)
		}

	}
}

func IfStatement_1(i, j, lim float64) float64 {
	if v := math.Pow(i, j); v < lim {
		return v
	} else {
		fmt.Printf("%g>=%g \n", v, lim)
	}
	return lim

}

// challenge
func MakeSqure(z, x float64) {

	for i := 10; i >= 0; i-- {
		y := z
		z -= (z*z - x) / (2 * z)
		fmt.Printf("z is : %v \n", z)
		if math.Abs(y-z) < 1e-9 {
			fmt.Printf("z == y ?: %v,%v", z, y)
			break
		}
	}
	fmt.Printf("\n compare to math.Squre: %v", math.Sqrt(x))
}

func SwitchStatement_1() {
	fmt.Print("\n go runs on: \n")
	switch os := runtime.GOOS; os {
	case "linux":
		fmt.Printf("run on :%v", os)
	case "macOS":
		fmt.Printf("run on:%v", os)
	default:
		fmt.Printf("run on : %v", os)
	}
}

func SwtichStatement_2(){
	today:=time.Now().Weekday(); 
	switch time.Saturday {
	case today +0: fmt.Println("today")
	case today + 1 : fmt.Println("tomorrow")
	case today +2 : fmt.Println("day after tomorrow")
	default : fmt.Println("too far away")

	}
}

func SwitchStatement_3(){
	t:=time.Now()
	switch{
	case t.Hour()<12 :
		fmt.Println("good mroning")
	case t.Hour()>12 && t.Hour()<18:
		fmt.Println("good afternoon")
	default: 
		fmt.Println("good night")
	}
}

func DeferEvaluated(){
	defer fmt.Println("hello")
	fmt.Println("world")
}

func DeferStack(){
	fmt.Println("starting")
	for i:=0; i<10;i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}


func DeferStackClosure(){
	fmt.Println("starting")
	for i:=0; i<10;i++{
		defer func ()  {
			fmt.Println(i)
		}()
	}
	fmt.Println("done")
}

func F() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered in f", r)
        }
    }()
    fmt.Println("Calling g.")
    g(0)
    fmt.Println("Returned normally from g.")
}

func g(i int) {
    if i > 3 {
        fmt.Println("Panicking!")
        panic(i)
    }
    defer fmt.Println("Defer in g", i)
    fmt.Println("Printing in g", i)
    g(i + 1)
}



func CopyFile(dstName, srcName string) (written int64, err error) {
    src, err := os.Open(srcName)
	
    if err != nil {
        return
    }
	defer src.Close()

    dst, err := os.Create(dstName)
    if err != nil {
        return
    }
	defer dst.Close()

    written, err = io.Copy(dst, src)
    return
}