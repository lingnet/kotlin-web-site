---
type: doc
layout: reference
category: "Classes and Objects"
title: "Inline classes"
---

# Inline classes

> Inline classes are *experimental* in Kotlin 1.3+. See details [below](#experimental-status-of-inline-classes)
{:.note}

Sometimes it is necessary for business logic to create a wrapper around some type. However, it introduces runtime overhead due to additional heap allocations. Moreover, if wrapped type was primitive, performance hit is terrible, because primitive types usually are heavily optimized by runtime, while their wrappers don't get any special treatment. 

To solve such kind of issues, Kotlin introduces special kind of classes called `inline classes`, which are introduced by placing modifier `inline` before the name of the class:

<div class="sample" markdown="1" theme="idea" data-highlight-only>

```kotlin
inline class Password(val value: String)
```  
</div>

Inline class must have a single property initialized in the primary constructor. At runtime, instances of the inline class will be represented using this single property (see details about runtime representation [below](#representation)):

<div class="sample" markdown="1" theme="idea" data-highlight-only>

```kotlin
// No actual instantiation of class 'Password' happens
// At runtime 'securePassword' contains just 'String'
val securePassword = Password("Don't try this in production") 
```  
</div>

This is the primary property of inline classes, which inspired name "inline": data of the class is "inlined" into its usages (similar to how content of [inline functions](inline-functions.html) is inlined to call sites)

Another option is to view inline classes as a [typealiases](type-aliases.html) which are not assignment-compatible.


## Members

Inline classes support some functionality of usual classes. In particular, they are allowed to declare members and methods:

<div class="sample" markdown="1" theme="idea">

```kotlin
inline class Name(val s: String) {
    val length: Int
        get() = s.length

    fun greet() {
        println("Hello, $s")
    }
}    

fun main() {
    val name = Name("Kotlin")
    name.greet() // method `greet` is called as a static method
    println(name.length) // property getter is called as a static method
}
```  
</div>

However, there are some restrictions for inline classes members:
* inline class cannot have *init*{: .keyword } block
* inline class cannot have *inner*{: .keyword } classes
* inline class field cannot have [backing fields](properties.html#backing-fields)
    * it follows that inline class can have only simple computable properties (no lateinit/delegated properties)


## Inheritance

Inline classes are allowed to inherit interfaces:

<div class="sample" markdown="1" theme="idea">

```kotlin
interface Printable {
    fun prettyPrint(): String
}

inline class Name(val s: String) : Printable {
    override fun prettyPrint(): String = "Let's $s!"
}    

fun main() {
    val name = Name("Kotlin")
    println(name.prettyPrint()) // Still called as a static method
}
```  
</div>

It is forbidden for inline classes to participate in classes hierarchy, so inline class can not extend other classes and itself must be *final*{: .keyword }. 

## Representation

In the generated code Kotlin compiler keeps a *wrapper* for each inline class. This wrapper is used for process which is similar to the process of primitive types [boxing](basic-types.html#representation): similar to how primitive `int` can be boxed to `Integer`, underlying value of inline classes can be boxed to it's wrapper. 

Kotlin compiler will try to eliminate as much boxing as possible to produce most performant and optimized code, but sometimes it is neccesary to keep wrappers around. Rule of thumb: inline class is boxed whenever it is used as another type.

<div class="sample" markdown="1" theme="idea">

```kotlin
interface I

inline class Foo(val i: Int) : I

fun asInline(f: Foo) {}
fun <T> asGeneric(x: T) {}
fun asInterface(i: I) {}
fun asNullable(i: Foo?) {}

fun <T> id(x: T): T = x

fun main() {
    val f = Foo(42) 
    
    asInline(f)    // unboxed: used as Foo itself
    asGeneric(f)   // boxed: used as generic type T
    asInterface(f) // boxed: used as type I
    asNullable(f)  // boxed: used as Foo?, which is different from Foo
    
    // below, 'f' first is boxed (while passing to 'id') and then unboxed (when returned from 'id') 
    // In the end, 'c' contains unboxed representation (just '42'), as 'f' 
    val c = id(f)  
}
```  
</div>

Because inline classes maybe represented both as underlying value and as a wrapper, [referential equality](equality.html#referential-equality) is pointless for them and thus prohibited.  

## Experimental status of inline classes

The design of unsigned types is experimental, meaning that this feature is [*moving fast*](components-stability.html#moving-fast) and no compatibility guarantees are given. When using inline classes in Kotlin 1.3+, warning will be reported, indicating that this feature is experimental. 

To remove warning, you have to opt into usage of experimental feature by passing argument `-XXLanguage:+InlineClasses` to the `kotlinc`.

In Gradle:
<div class="sample" markdown="1" theme="idea" data-highlight-only>

``` groovy

compileKotlin {
    kotlinOptions.freeCompilerArgs += ["-XXLanguage:+InlineClasses"]
}
```
</div>

In Maven:
<div class="sample" markdown="1" theme="idea" data-highlight-only>

```xml
<configuration>
    <args>
        <arg>-XXLanguage:+InlineClasses</arg> 
    </args>
</configuration>
``` 
</div>