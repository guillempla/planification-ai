import random as rand
import string

from os.path import isfile
from sys import argv, exit

# ============================================================================ #

OPTIONS = {
    '-b': [1], # number of books
    '-d': [1], # domain level
    '-h': [0], # help (usage) information
    '-m': [1], # number of months
    '-o': [1], # output file
}

REQUIRED = [
    '-b',
    '-d',
    '-m',
]

EXTENSIONS = list(string.ascii_lowercase) + ['GUARD']

# ---------------------------------------------------------------------------- #

PROB_BOOK_READ = 0.15
PROB_BOOK_CAND = 0.50
PROB_BOOK_PRED = 0.35

# ============================================================================ #

def error():
    print("[generator]: Error with the arguments.")
    print("[generator]: Please, execute the program with '-h' option for more information")
    exit()

def usage():
    print("Usage: generator.py [OPTIONS] (execute it from the project folder root)")
    print("")
    print("OPTIONS", "\t", "REQUIRED", "\t", "DESCRIPTION")
    print("------------------------------------------------------------------------------------")
    print("-b <num>", "\t", "yes", "\t\t", "number of books [> 0]")
    print("-d <opt>", "\t", "yes", "\t\t", "domain level [b|e1|e2|e3]")
    print("-h",     "\t\t", "no",  "\t\t", "display help information")
    print("-m",     "\t\t", "yes", "\t\t", "number of months [> 0]")
    print("-o <str>", "\t", "no",  "\t\t", "output file name, otherwise automatically generated")
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
        if books < 1: error()
        OPTIONS['-b'][1] = books
        months = int(OPTIONS['-m'][1])
        if months < 1: error()
        OPTIONS['-m'][1] = months
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
            if not isfile(fileName+ext+".pddl"):
                fileName += ext
                break
    return fileName + ".pddl"

def randomizeBookRead(numBooks):
    ls = [i for i in range(numBooks)]
    ls = ['b' + str(i) for i in ls if rand.random() <= PROB_BOOK_READ]
    ls = ['(bookRead ' + i + ')\n\t\t' for i in ls]
    txt = ''.join(ls)
    return txt

def randomizeBookCandidate(numBooks, booksRead):
    read = booksRead.split('\n\t\t')
    read = read[:-1]
    read = [i.split(' ')[1][:-1] for i in read]
    ls = [i for i in range(numBooks)]
    ls = ['b' + str(i) for i in ls if rand.random() <= PROB_BOOK_CAND]
    ls = [i for i in ls if i not in read]
    ls = ['(bookCandidate ' + i + ')\n\t\t' for i in ls]
    txt = ''.join(ls)
    return txt

def randomizeBookIsPredecessor(numBooks):
    txt = 'HOLA'
    return txt

def generateContent(fileName, numBooks, numMonths):
    fileName = fileName[4:]
    fileName = fileName[:-5]
    if fileName[:7] == "problem":
        fileName = fileName[7:]
        if len(fileName) == 0:
            fileName = '0'
    books = ""
    for i in range(numBooks):
        books += "b" + str(i) + " "
    months = ""
    for i in range(numMonths):
        months += "m" + str(i) + " "

    booksRead = randomizeBookRead(numBooks)
    booksCandidate = randomizeBookCandidate(numBooks, booksRead[:])
    booksPredecessors = randomizeBookIsPredecessor(numBooks)

    text = """(define (problem """+fileName+""")
    (:domain planner)

    (:objects
        """+books+"""- book
        """+months+"""- month
    )

    (:init
        ; Read books
        """+booksRead+"""
        ; Candidate books
        """+booksCandidate+"""
        ; Predecessor books
        """+booksPredecessors+"""
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
    fileName = getFileName()
    content = generateContent(fileName[:], OPTIONS['-b'][1], OPTIONS['-m'][1])
    writeFile(fileName, content)
    print("[generator]: Problem generated successfully!")

# =================================== MAIN =================================== #

test(argv[:])
initialize(argv[:])
generate()
