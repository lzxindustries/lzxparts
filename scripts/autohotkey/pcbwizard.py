import os
import sys
import fileinput

#print ("Text to search for:")
textToSearch = sys.argv[1]

#print ("Text to replace it with:")
textToReplace = sys.argv[2]

#print ("File to perform Search-Replace on:")
fileToSearch = sys.argv[3]

tempFile = open( fileToSearch, 'r+' )
matches = 0
print('Replacing ' + str(sys.argv[1]) + ' with ' + str(sys.argv[2]) + ' in ' + str(sys.argv[3]))
for line in fileinput.input( fileToSearch ):
    if textToSearch in line :
        print('Match Found')
        matches = matches + 1
    #else:
        #print('Match Not Found!!')
    tempFile.write( line.replace( textToSearch, textToReplace ) )
tempFile.close()
print('Replaced ' + str(matches) + ' matches.')