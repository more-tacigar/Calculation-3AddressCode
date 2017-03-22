# Calculator-3AddressCode - A Simple 3 Address Code Example - #

計算。

```
b = 4;
c = b * 2;
d = c - 2;
a = b * c + b * d
```

will be translated into

```
__tmp1 = 4
b = __tmp1
__tmp2 = b
__tmp3 = 2
__tmp4 = __tmp2 * __tmp3
c = __tmp4
__tmp5 = c
__tmp6 = 2
__tmp7 = __tmp5 - __tmp6
d = __tmp7
__tmp8 = b
__tmp9 = c
__tmp10 = __tmp8 * __tmp9
__tmp11 = b
__tmp12 = d
__tmp13 = __tmp11 * __tmp12
__tmp14 = __tmp10 + __tmp13
a = __tmp14
```
