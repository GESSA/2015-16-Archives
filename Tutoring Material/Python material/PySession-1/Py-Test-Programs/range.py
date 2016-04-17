# Range has 3 Parameters
#start: Starting number of the sequence.
#stop: Generate numbers up to, but not including this number.
#step: Difference between each number in the sequence.

for i in range(6):
    print(i)

for i in range(1,10,2):
    print(i)


def newFunc(a=0, b=1):
    x=2
    j=4
    return x,j

def test_pass():
    pass

try:
    newFunc()
except Exception:
    pass