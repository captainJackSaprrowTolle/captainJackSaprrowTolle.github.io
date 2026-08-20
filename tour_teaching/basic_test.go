package tourteaching

import (
"fmt"
"testing"
"math/cmplx"
)

var c, python, java = true, true, "Java"

var (
	ToBe bool = false
	MaxIntige uint64 = 1<<64-1
	cmp_z complex128 = cmplx.Sqrt(-5 + 128i)
	
)

const (
	big = 1<<100
	small =1>>99
)


func TestLesson_1(t *testing.T){
	var i bool
	k,v := "str", 1
	fmt.Print(i, python, c, java,k,v)
	
	fmt.Printf("\n Type: %T, value: %v",ToBe,ToBe)
	fmt.Printf("\n Type: %T, value: %v", MaxIntige, MaxIntige)
	fmt.Printf("\n Type: %T, value: %v", cmp_z, cmp_z)


	m:=42.00+5i
	fmt.Printf("\n Type: %T, value::%v",m,m)
	
	fmt.Printf("\n small type :%T, value :%v",small,small)
}