package main
import "fmt"
import "log"
import "rsc.io/quote"
import "example.com/greetings"

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
}

