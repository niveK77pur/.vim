from time import sleep

def hello():
    for i in range(5):
        print("note-{}".format(i))
        sleep(1)

if __name__ == '__main__':
    hello()
