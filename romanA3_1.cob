
identification division.
program-id. romanA3_1.
environment division.
input-output section.

*> Setup standard input and output variables
file-control.
    select standard-input assign to keyboard.
    select standard-output assign to display.

data division.

*> Setup standard input and output interface
file section.
    fd standard-input.
        01 stdin-record picture x(80).
    fd standard-output.
        01 stdout-record picture x(80).

*> Declaration of variables and messages to work within this file
working-storage section.
    77 inputStr pic x(20) value spaces.
    77 temp pic 9(4) value 0.
    77 ret pic 9 value 0.
    77 len pic 99.
    77 numSpaces pic 99.
    01 title-line.
        02 pic x(25) value spaces.
        02 pic x(24) value 'Roman Number Equivalents'.
    01 exitProgram-line.
        02 pic x(20) value spaces.
        02 pic x(37) value '*Enter Q or quit to exit the program*'.
    01 underline-1.
        02 pic x(45) value ' --------------------------------------------'.
    01 col-heads.
        02 pic x(9) value spaces.
        02 pic x(12) value 'Roman Number'.
        02 pic x(13) value spaces.
        02 pic x(11) value 'Dec. Equiv.'.
        01 underline-2.
        02 pic x(45) value ' ------------------------------   -----------'.
    01 print-line.
        02 pic x value space.
        02 out-r pic x(30).
        02 pic x(3) value spaces.
        02 out-eq pic z(9).

procedure division.
open input standard-input, output standard-output.

    *> Display the program introduction and simple instructions for the user
    display " "
    display title-line.
    display exitProgram-line.
    display "*Enter a roman numeral (upper or lower case) to convert to its decimal equivalent*".
    display " "
    display underline-1.
    display col-heads.
    display underline-2.

    *> Read the keyboard input from the user
    read standard-input into inputStr.

    *> Run the program loop until the user decides to quit
    perform the-loop
        until inputStr is equal to "Q" or "quit".

    the-loop.
        if inputStr is equal to "Q" or "quit"
            stop run.

        *> Calculate the number of spaces and calculate the length of the roman numeral entered
        inspect function reverse(inputStr) tallying numSpaces for leading spaces
        compute len = length of inputStr - numSpaces.

        *> Call the conv fuction and pass variables needed
        call "conv" using inputStr, len, ret, temp.

        if ret is not equal to 1
            move temp to out-eq
            move inputStr to out-r
            display print-line
        end-if.

        *> Reset variables for the next roman numeral conversion
        move 0 to temp.
        move 0 to len.
        move 0 to ret.
        move 0 to numSpaces.
        read standard-input into inputStr.
