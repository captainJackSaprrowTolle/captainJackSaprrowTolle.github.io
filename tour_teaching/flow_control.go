package tourteaching

import (
	"fmt"
	"time"
	"math"
)

func LoopControl_1() {
	sum := 0
	for i := 0; i < 10; i++ {
		fmt.Printf("i value is :%v \n",i)
		sum += i
	}
	fmt.Printf("sum: %v \n", sum)
}


func LoopControl_2(){
	var sum int =0
	for ;sum<10;{
		sum++
		fmt.Printf("sum value is : %v \n",sum)
	}
}


func LoopControl_3(){
	var sum int =0
	for sum<10 {
		sum++
		fmt.Printf("sum value is : %v \n",sum)
	}
}


func LoopControl_4(){
	times:=0
	var channel_10 <-chan time.Time= time.After(time.Millisecond*1)

	wait_10s:
	for  {
		select {
			case <- channel_10: fmt.Print("150ms结束"); break wait_10s
			default:
				times++
				time.Sleep(time.Second)
				fmt.Printf("infinity loop : %v \n",times)
		}
	
	}
}

func IfStatement_1(i, j, lim float64 ) float64{
	if v:=math.Pow(i,j); v<lim{
		return v
	}else{
		fmt.Printf("%g>=%g \n",v,lim)
	}
	return lim 

}


// challenge
func MakeSqure(z, x float64){
	
	for i:=10;i>=0;i--{
		y:=z
		z -= (z*z - x) / (2*z)
		fmt.Printf("z is : %v \n",z)
		if math.Abs(y-z)<1e-9 {
			fmt.Printf("z == y ?: %v,%v",z,y)
			break
		}
	}
	fmt.Printf("\n compare to math.Squre: %v", math.Sqrt(x))
}