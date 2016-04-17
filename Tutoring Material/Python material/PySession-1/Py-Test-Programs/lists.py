py_list = [2,5,6,7,1,9,0]

print ("The List contents are %s\n" %py_list)

print ("Length of List is %s\n" %len(py_list))

# Add an element to list
py_list.append(15)

print ("The List contents are %s\n" %py_list)

py_list.sort()

print ("The List contents are %s\n" %py_list)

py_list.append(5)
count_of_two = py_list.count(5)

print ("The Occurance of '5' in list is %s times\n" %count_of_two)

py_list.insert(0, 12)

print ("The List contents are %s\n" %py_list)

py_list.reverse()

print ("The List contents are %s\n" %py_list)