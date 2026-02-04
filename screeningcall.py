name = "abcba"
new_name = list(name)
n = len(new_name)
print(type(new_name))
def check_pallindrome(new_name,n):
    temp = new_name[::-1]
    print(type(temp))
    if new_name == temp:
        return print("pallindrome")
    else:
        return print("not a pallindrome")


check_pallindrome(new_name,n)
