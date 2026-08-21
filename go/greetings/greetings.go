package greetings

import (
	"errors"
	"fmt"
	"math/rand"

)

func Hello (name string) (string,error) {
	if name == ""{
		return "" , errors.New("hint: Empty Name")
	}
	


	// message := fmt.Sprintf(FormatRandom(), name)
	message:= fmt.Sprint(FormatRandom())
	return  message,nil
}


func FormatRandom() string {
	formats:=[]string {
		"hello, %v",
		"searching driver %v times",
		"high demand, fewer driver nearby long time wait %v",
	}

	return formats[rand.Intn(len(formats))]
}


func Hellos(names []string) (map[string]string,error) {
	messages:=make(map[string]string)
	for _, name:= range names {
		message,err:=Hello(name)
		if err!=nil {
			return messages, errors.New(err.Error())
		}
		messages[name]=message
	}

	return messages,nil
}