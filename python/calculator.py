#Калькулятор
#color text
from colorama import init
from colorama import Fore, Back, Style
init()
print( Fore.BLACK )
print( Back.GREEN )
what = input( "operation (+,-): " )
a = float( input( "first" ))
b = float( input( "second" ))
if what == "+":
    c = a + b
    print("Result" + str(c))
elif what == "-":
    c = a - b  
    print("Result" + str(c))
else:
    print("Wrong operation")  

    #pip install pyinstaller
input()