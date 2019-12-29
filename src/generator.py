from os.path import isfile
from sys import argv, exit

# ============================================================================ #

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

EXTENSIONS = [
    'a',
    'b',
    # 'c',
    'GUARD'
]

# ============================================================================ #

def error():
    print("[generator]: Error with the arguments.")
    print("[generator]: Please, execute the program with '-h' option for more information")
    exit()

def usage():
    print("Usage: generator.py [OPTIONS]")
    print("")
    print("OPTIONS", "\t", "REQUIRED", "\t\t", "DESCRIPTION")
    print("------------------------------------------------------------------------------------")
    print("-b <num>", "\t", "yes", "\t\t\t\t", "number of books [>= 0]")
    print("-d <opt>", "\t", "yes", "\t\t\t\t", "domain level [b|e1|e2|e3]")
    print("-h",   "\t\t\t", "no",  "\t\t\t\t", "display help information")
    print("-o <str>", "\t", "no",  "\t\t\t\t", "output file name, otherwise automatically generated")
    exit()

def allRequired(args):
    if '-h' in args: usage()
    for req in REQUIRED:
        if req not in args:
            return False
    return True

def test(args):
    if not allRequired(args): error()
    args.pop(0)
    while len(args) > 0:
        arg = args[0]
        if arg not in OPTIONS: error()
        params = OPTIONS[arg][0]
        args.pop(0)
        while params > 0:
            if len(args) == 0: error()
            args.pop(0)
            params -= 1

def initialize(args):
    for i, arg in enumerate(args):
        if arg in OPTIONS:
            params = OPTIONS[arg][0]
            for j in range(params):
                OPTIONS[arg].append(args[i+j+1])
    level = OPTIONS['-d'][1]
    if level != 'b' and level != 'e1' and level != 'e2' and level != 'e3':
        error()
    try:
        books = int(OPTIONS['-b'][1])
        if books < 0: error()
        OPTIONS['-b'][1] = books
    except ValueError:
        error()

# ---------------------------------------------------------------------------- #

def getFileName():
    fileName = "src/"
    if len(OPTIONS['-o']) == 2:
        fileName += OPTIONS['-o'][1]
    else:
        fileName += "problem"
        fileName += OPTIONS['-d'][1].upper()
        for ext in EXTENSIONS:
            if ext == 'GUARD':
                print("[generator]: Write operation aborted, all files already generated.")
                exit()
            if not isfile(fileName+ext):
                fileName += ext
                break
    return fileName

def generateContent():
    text = """(define (problem yes)
    (:domain planner)

    (:objects
        b0 b1 b2 b3 - book
        january february march april may june august september october november december - month
    )

    (:init
        ;; Pages of each book
        (= (bookPages b0) 400)
        (= (bookPages b1) 300)
        (= (bookPages b2) 200)
        (= (bookPages b3) 100)

        ;; Predecessors of each book
        (bookIsPredecessor b0 b1)
        (bookIsPredecessor b2 b3)

        ;; Read books
        (bookRead b0)
    )

    (:goal (forall (?x - book) (not (bookRead ?x)) (bookAssigned ?x)))
)"""
    return text

def writeFile(fileName, text):
    if isfile(fileName):
        while True:
            overwrite = input("[generator]: The file already exists, do you want to overwrite it? [yes|no]: ")
            if overwrite == "no":
                print("[generator]: Write operation aborted!")
                exit()
            if overwrite == "yes": break
    file = open(fileName, "w")
    file.write(text)
    file.close()

def generate():
    print("[generator]: Generating new problem file...")
    file = getFileName()
    content = generateContent()
    writeFile(file, content)

# =================================== MAIN =================================== #

test(argv[:])
initialize(argv[:])
print(OPTIONS)
generate()
