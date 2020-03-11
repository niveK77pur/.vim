#!/usr/bin/env python3

from time import sleep
import vim

def getInput():
    for i in range(5):
        print("note-{}".format(i))
        #  vim.command("normal! onote-{}".format(i))
        sleep(1)

if __name__ == '__main__':
    vim.command("normal! otest")
    getInput()
    print("done")
