package main
import "fmt"
import "log"
import "rsc.io/quote"
import "example.com/greetings"
import "example.com/tour_teaching"

func main(){
	log.SetPrefix("Greeting:")
	log.SetFlags(0)

	fmt.Println("hello world!")
	fmt.Println(quote.Go())
	fmt.Println(quote.Hello())
	fmt.Println(quote.Opt())
	fmt.Println(quote.Glass())

	fmt.Println(greetings.Hello("周杰伦"))
	// message,err:=greetings.Hello("")
	// if err!=nil{
	// 	log.Fatal(err);
	// }
	// fmt.Println(message);

	fmt.Println(greetings.Hellos([]string{"张学友","刘德华"}))

	fmt.Print("================tour_teaching========================= \n")
	tourteaching.LoopControl_1()
	tourteaching.LoopControl_2()
	tourteaching.LoopControl_3()
	tourteaching.LoopControl_4()

	fmt.Printf("\n 3 pow 2 return %v \n",tourteaching.IfStatement_1(3,2,10))
	
	fmt.Printf("\n 3 pow 3 return %v \n",tourteaching.IfStatement_1(3,3,20))

	tourteaching.MakeSqure(1,10)

	tourteaching.SwitchStatement_1()
	tourteaching.SwtichStatement_2()
	tourteaching.SwitchStatement_3()
	tourteaching.DeferEvaluated()
	tourteaching.DeferStack()
	tourteaching.DeferStackClosure()
	tourteaching.F()
	fmt.Println("Returned normally from f.")
}

