---
title: "用牛顿迭代法实现 Sqrt"
date: 2026-08-20
draft: false
tags: ["go", "tour-of-go", "算法"]
categories: ["go"]
---

Go Tour "Exercise: Loops and Functions" 练习：用牛顿迭代法实现平方根函数。

## 踩的坑

1. **用 `int` 而不是 `float64`**：整数除法会把小数部分直接截断，导致每次调整量经常变成 0，根本没法正确收敛。
```go
// 错误：整数除法直接截断小数
func MakeSqure(z, x int) { ... }


// 正确：用 float64 保留精度
func MakeSqure(z, x float64) { ... }

```
2. **收敛判断的比较对象错了**：一开始把"上一轮的猜测值"放在循环外面只赋值一次，导致比较的其实是"当前值 vs 最初的猜测"，不是"当前值 vs 上一轮"。
```go
//错误做法
func MakeSqure(z, x float64){
    y:=z
    for i:=10;i>=0;i--{
            ...
    }
}

//正确做法
func MakeSqure(z, x float64){
    for i:=10;i>=0;i--{
            y:=z
            ...
    }
}
```

3. **浮点数不能用 `==` 判断是否收敛**：改成 `float64` 之后，两次几乎相等的浮点数因为舍入误差永远精确匹配不上，得用 `math.Abs(a-b) < 1e-9` 这种阈值判断。
```go
//错误做法
if y==z {...}

///正确做法
if math.Abs(y-z)<1e-9 {...}
```

## 最终效果

跟标准库 `math.Sqrt` 对比，5~7 轮就能收敛到几乎一致的结果，比固定跑 10 轮更快也更准。
```go
///call
func main(){
    tourteaching.MakeSqure(1,10)
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
```
```shell
z is : 5.5 
z is : 3.659090909090909 
z is : 3.196005081874647 
z is : 3.1624556228038903 
z is : 3.162277665175675 
z is : 3.1622776601683795 
z is : 3.162277660168379 
z == y ?: 3.162277660168379,3.1622776601683795
    compare to math.Squre: 3.1622776601683795
```