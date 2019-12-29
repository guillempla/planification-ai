from sys import argv, exit

OPTIONS = {
    '-b': [1], # number of books
    '-d': [1], # domain level
    '-h': [0], # help (usage) information
    '-o': [1], # output file
}

REQUIRED = [
    '-b',
    '-d',
]

def usage():
    print("Usage: generator.py [OPTIONS]")
    print("")
    print("OPTIONS", "\t", "REQUIRED", "\t\t", "DESCRIPTION")
    print("---------------------------------------------------------------------------------")
    print("-b <num>", "\t", "yes", "\t\t\t\t", "number of books [>= 0]")
    print("-d <opt>", "\t", "yes", "\t\t\t\t", "domain level [b|e1|e2|e3]")
    print("-h",   "\t\t\t", "no",  "\t\t\t\t", "display help information")
    print("-o <str>", "\t", "no",  "\t\t\t\t", "output file name, if not automatically generated")
    exit()

def allRequired(args):
    if '-h' in args: usage()
    for req in REQUIRED:
        if req not in args:
            return False
    return True

def test(args):
    if not allRequired(args): usage()
    args.pop(0)
    while len(args) > 0:
        arg = args[0]
        if arg not in OPTIONS: usage()
        params = OPTIONS[arg][0]
        args.pop(0)
        while params > 0:
            if len(args) == 0: usage()
            args.pop(0)
            params -= 1

def classify(args):
    for i, arg in enumerate(args):
        if arg in OPTIONS:
            params = OPTIONS[arg][0]
            for j in range(params):
                OPTIONS[arg].append(args[i+j+1])
    level = OPTIONS['-d'][1]
    if level != 'b' and level != 'e1' and level != 'e2' and level != 'e3':
        usage()
    books = int(OPTIONS['-b'][1])
    if books < 0: usage()
    OPTIONS['-b'][1] = books

# =================================== MAIN =================================== #

test(argv[:])
classify(argv[:])
print(OPTIONS)
