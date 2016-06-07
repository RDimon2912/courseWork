a = raw_input()
a = raw_input().split(' ')

a = [int(elem) for elem in a if elem != ' ' and elem != '']
print ' '.join(map(str, sorted(a)))