def add(
    number1: int,  number2=2, debug : bool=False,) -> str:
    """
    Test
    """
    if(True):
        a=1
    a = number1  + number2

    return a



a = 2
b = 3
print( add( a , b, options={"debug": True,},),
)        # Output: 5
