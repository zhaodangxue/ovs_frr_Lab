import os
import argparse
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    os.system("./pull_and_start_container.sh")
if __name__ == "__main__":
    main()