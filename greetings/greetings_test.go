package greetings
import "testing"
import "regexp"

func TestHelloName(t *testing.T){
	name:="Tony"
	want:=regexp.MustCompile(`\b`+name+`\b`)
	message,err:=Hello(name)
	if !want.MatchString(message) || err!=nil {
		t.Errorf("Hello(Tony) = %q, %v, want match for %#q, nil", message, err, want)
	}



}


func TestHelloEmpty(t *testing.T){
	msg,err:=Hello("")
	if err==nil || msg!="" {
      t.Errorf(`Hello("")=%q, %v, want "", error`,msg, err)
	}
}