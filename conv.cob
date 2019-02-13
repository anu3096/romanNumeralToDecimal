
identification division.
program-id. conv.
environment division.
input-output section.

*> Setup standard output variable
file-control.
    select standard-output assign to display.

data division.

*> Setup standard output interface
file section.
fd standard-output.
    01 stdout-record picture x(80).

*> Declaration of variables and messages to work within this file
working-storage section.
    77 cnt pic 99 value 0.
    77 prev pic 9999 value 0.
    77 d pic 9999 value 0.
    77 curChar pic x value space.
    01 error-mess.
        02 pic x(22) value ' illegal roman numeral'.

*> Declare variables for the parameters being passed by another program
linkage section.
    77 inputStr pic x(30) value spaces.
    77 sum1 pic 9(4) value 0.
    77 len pic 9(2) value 0.
    77 err pic 9 value 0.

procedure division using inputStr, len, err, sum1.
    move 1001 to prev.
    move 1 to cnt.

    *> Run the program loop until the loop reaches the last character of the roman numeral
    perform loop
        until cnt is greater than len.

    *> if the program runs into an error when reading the input then give feedback to the user and go back to the caller program
    if err is equal to 1
        display error-mess. goback.

    *> Loop through the user input and add the neccessary values together to create the decimal equivalent of the roman numeral
    loop.
        move inputStr(cnt:1) to curChar.
        if curChar is equal to 'I' or 'i'
            move 1 to d
        else if curChar is equal to 'V' or 'v'
            move 5 to d
        else if curChar is equal to 'X' or 'x'
            move 10 to d
        else if curChar is equal to 'L' or 'l'
            move 50 to d
        else if curChar is equal to 'C' or 'c'
            move 100 to d
        else if curChar is equal to 'D' or 'd'
            move 500 to d
        else if curChar is equal to 'M' or 'm'
            move 1000 to d
        else
            move 1 to err.

        if err is not equal to 1
            add d to sum1
            if d is greater than prev
                compute sum1 = sum1 - 2 * prev.

        move d to prev.
        add 1 to cnt.
