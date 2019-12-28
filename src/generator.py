from sys import argv, exit

OPTIONS = {
    "-o": [1], # output file name
}

def usage():
    print("Usage: generator.py [OPTIONS]")
    print("")
    print("OPTIONS", "\t", "DESCRIPTION")
    print("-----------------------------")
    print("-o <name>", "\t", "output file name, if not automatically generated")
    exit()

def test(args):
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


# =================================== MAIN =================================== #

test(argv[:])
classify(argv[:])
