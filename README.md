# CSE3120-Contest-1-Typing-Game
By Madison Sujanani and Thomas Do

## Description
Programmers type all day. What better way to gain typing and literacy skills than a typing game? Or to show off your skills? 
'Escape the CPU' is an x86 MASM typing game built using the Irvine32 library. 
This assembly game lets players show off their typing speed by typing phrases under a timer, measuring their accuracy and speed. 
Players select a 30- or 60-second round and type randomly selected phrases. The game features real-time green/red character feedback, Backspace correction, nonrepeating prompts, staged AI-themed dialogue, scoring, WPM calculation, and replay.

## Requirements

-> Windows with Visual Studio 2022 and MASM support

-> Win32/x86 build configuration

-> Kip Irvine's Irvine32 library and its include files

## How to Play
# Requirements

Windows with Visual Studio 2022 and MASM support

Win32/x86 build configuration

Kip Irvine's Irvine32 library and its include files

Compilation and execution

Open a Win32 MASM project in Visual Studio 2022.

Configure the project to use the Irvine32 include and library files.

Add typinggame.asm as the assembly source.

Keep all .inc files in the assembler's accessible include path.

Select Debug | Win32 and build the project.

Run the generated executable or press Ctrl + F5.

# Controls
1 or 2: Select 30 or 60 seconds

Space: Start the game

Backspace: Delete the previous typed character

Enter: Submit the current phrase

R: Replay after the round

Any other key at the replay prompt: Exit

# Scoring
Correct phrases are counted after the complete string comparison. WPM is calculated from the total characters in correctly submitted phrases, using five characters per word and the actual elapsed session time.

## Implementation

The project demonstrates MASM procedures, arrays, pointers, random selection, conditional jumps, string operations, nonblocking keyboard input, console colors, and timer arithmetic.

# Limitation

The WPM statistic measures fully correct submitted phrases rather than raw typing speed. The application requires a compatible Windows console and Irvine32 build environment.