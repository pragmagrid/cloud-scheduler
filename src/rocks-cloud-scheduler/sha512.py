#!/opt/python/bin/python

# Creates a sha512  hash object and returns its hex digest
# Takes an argumetn as a word for which to create the digest. 
# If none is given returns empty string

import sys
import hashlib

if len(sys.argv) == 2:
    password = sys.argv[1]
    hash = hashlib.sha512(password)
    digest = hash.hexdigest()
    print digest
