; ============================================================================
; Maze Runner - Multi-Level Edition
; ============================================================================

INCLUDE Irvine32.inc

; ----------------- CONSTANTS -----------------
MAZE_ROWS   EQU 12
MAZE_COLS   EQU 32
ROW_STRIDE  EQU (MAZE_COLS + 1)

; Wall / border characters
WALL_FILL   EQU 'л'
BORDER_H    EQU 'Ф'
BORDER_V    EQU 'Г'
CORNER_TL   EQU 'к'
CORNER_TR   EQU 'П'
CORNER_BL   EQU 'Р'
CORNER_BR   EQU 'й'

PATH_CHAR   EQU ' '
PLAYER_CHAR EQU '@'
EXIT_CHAR   EQU 'E'

MAX_LEVELS  EQU 3

.data

; ----------------- TITLE & INSTRUCTION MESSAGES -----------------
titleLine1  BYTE "кФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФП", 0
titleLine2  BYTE "Г                                                            Г", 0
titleLine3  BYTE "Г         лл   лл   лл   ллллл  ллллл                        Г", 0
titleLine4  BYTE "Г         ллл ллл  лл л     лл  лл                           Г", 0
titleLine5  BYTE "Г         лл л лл лл   л   лл   лллл                         Г", 0
titleLine6  BYTE "Г         лл   лл лллллл  лл    лл                           Г", 0
titleLine7  BYTE "Г         лл   лл лл   л ллллл  ллллл                        Г", 0
titleLine8  BYTE "Г                                                            Г", 0
titleLine9  BYTE "Г         ллллл  лл  лл лл   лл лл   лл ллллл  ллллл         Г", 0
titleLine10 BYTE "Г         лл  лл лл  лл ллл  лл ллл  лл лл     лл  лл        Г", 0
titleLine11 BYTE "Г         ллллл  лл  лл лл л лл лл л лл лллл   ллллл         Г", 0
titleLine12 BYTE "Г         лл лл  лл  лл лл  ллл лл  ллл лл     лл лл         Г", 0
titleLine13 BYTE "Г         лл  лл  лллл  лл   лл лл   лл ллллл  лл  лл        Г", 0
titleLine14 BYTE "Г                                                            Г", 0
titleLine15 BYTE "РФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФй", 0
titlePrompt BYTE "                  Press any key to continue...", 0

instrLine1  BYTE "                    кФФФФ INSTRUCTIONS ФФФФП", 0
instrLine2  BYTE " ", 0
instrLine3  BYTE "                 Г  Use WASD or Arrow Keys  Г", 0
instrLine4  BYTE "                 Г  to move your character  Г", 0
instrLine5  BYTE " ", 0
instrLine6  BYTE "                 Г  @ = You (the player)    Г", 0
instrLine7  BYTE "                 Г  E = Exit (your goal)    Г", 0
instrLine8  BYTE "                 Г  л = Walls (blocked)     Г", 0
instrLine9  BYTE " ", 0
instrLine10 BYTE "                 Г  Navigate through three  Г", 0
instrLine11 BYTE "                 Г  challenging mazes!      Г", 0
instrLine12 BYTE " ", 0
instrLine13 BYTE "                    РФФФФФФФФФФФФФФФФФФФФФй", 0
instrPrompt BYTE "              Press any key to start Level 1...", 0

winMsg         BYTE "Level completed! You reached the exit!", 0
levelClearMsg  BYTE "        кФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФП", 0
levelClearNum  BYTE "        Г     LEVEL ", 0
levelClearNum2 BYTE " CLEARED!          Г", 0
levelClearMsg2 BYTE "        РФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФй", 0
nextLevelPrompt BYTE "     Press 'N' for next level, or 'Q' to quit: ", 0
finalWinLine1  BYTE "        кФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФП", 0
finalWinLine2  BYTE "        Г                                          Г", 0
finalWinLine3  BYTE "        Г    CONGRATULATIONS! YOU WON!             Г", 0
finalWinLine4  BYTE "        Г    All levels completed!                 Г", 0
finalWinLine5  BYTE "        Г                                          Г", 0
finalWinLine6  BYTE "        РФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФй", 0
finalWinPrompt BYTE "              Press any key to exit...", 0

; ----------------- LEVEL DATA -----------------
currentLevel DWORD 1
playerRow    DWORD 0
playerCol    DWORD 0
prevRow      DWORD 0
prevCol      DWORD 0
exitRow      DWORD 0
exitCol      DWORD 0

; Start positions for each level (row, col for @)
levelStartRows DWORD 1, 1, 1
levelStartCols DWORD 2, 2, 2

; Exit positions for each level (row, col for E)
; NOTE: cols adjusted so exits match 'E' in each maze
; Level 1: row 1, col 30
; Level 2: row 10, col 29
; Level 3: row 10, col 29
levelExitRows  DWORD 1, 10, 10
levelExitCols  DWORD 30, 29, 29

; Pointers to maze data for each level
levelMazePointers DWORD OFFSET maze1, OFFSET maze2, OFFSET maze3

; ----------------- MAZE 1 (original single-level maze) -----------------
maze1 BYTE "кФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФП",0
      BYTE "Гл@   л    ллллл    л         EГ",0
      BYTE "Гл л л ллл л     л л л ллл лл лГ",0
      BYTE "Гл л л   л л ллл л л л   л    лГ",0
      BYTE "Гл ллл л л л   л л ллл л л л  лГ",0
      BYTE "Гл     л л л л л л     л л л  лГ",0
      BYTE "Гллллл л л л л л ллллллл л л  лГ",0
      BYTE "Гл     л   л л л         л    лГ",0
      BYTE "Гл ллллл ллл л лллллллллллллл лГ",0
      BYTE "Гл           л                лГ",0
      BYTE "Гллллллллл лллллллллллллллллл лГ",0
      BYTE "РФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФй",0

; ----------------- MAZE 2 (MEDIUM) -----------------
maze2 BYTE "кФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФП",0
      BYTE "Гл@ ллл ллллл ллл  ллллл л    лГ",0
      BYTE "Гл  л   л   л л   л    л л лл лГ",0
      BYTE "Глл л л л л л ллл л   л лл  л лГ",0
      BYTE "Г     л л л л   л л л       л лГ",0
      BYTE "Гллл лл л л ллл л л л л ллл л лГ",0
      BYTE "Гл       л   л л л л л    л л лГ",0
      BYTE "Гл ллллл ллл л л л ллл л  л л лГ",0
      BYTE "Гл л           л л     л  л л лГ",0
      BYTE "Гл л                л л        Г",0
      BYTE "Гл лллллллллллллллллл лллллллEлГ",0
      BYTE "РФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФй",0
     
; ----------------- MAZE 3 (HARD) -----------------
maze3 BYTE "кФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФП",0
      BYTE "Гл@л ллл лллл ллл лл л лл   л лГ",0
      BYTE "Гл л   л    л   л   л     л л лГ",0
      BYTE "Гл ллл ллл л ллл ллл л лл л л лГ",0
      BYTE "Гл   л   л л   л   л    л л   лГ",0
      BYTE "Гллл ллл л ллл ллл ллл л  л л лГ",0
      BYTE "Гл л л л л л л л л л л л  л л лГ",0
      BYTE "Гл л                     л  л лГ",0
      BYTE "Гл ллллллллллллллллллллллл л  лГ",0
      BYTE "Гл   л   л   л   л   л   л    лГ",0
      BYTE "Гллл ллл ллл ллл ллл ллл ллллEлГ",0
      BYTE "РФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФй",0

.code

; =====================================================================
; MAIN
; =====================================================================
main PROC
    ; Show title and instructions GUI screens first
    call ShowTitleScreen
    call ShowInstructionsScreen
    
    ; Start from level 1
    mov currentLevel, 1

LevelLoop:
    call LoadLevel   ; load level data
    call Clrscr      ; clear the title screen
    call DrawMaze    ; draw the whole maze and player's character
    
    ; Initialize previous position
    mov eax, playerRow
    mov prevRow, eax
    mov eax, playerCol
    mov prevCol, eax

GameLoop:
    ; Win check: player position == exit position
    mov eax, playerRow ; if (playerRow == exitRow && playerCol == exitCol)
    cmp eax, exitRow
    jne CheckInput
    mov eax, playerCol
    cmp eax, exitCol
    jne CheckInput

    ; Level completed!
    call ShowLevelClearMessage
    
    ; Check if this was the last level
    mov eax, currentLevel
    cmp eax, MAX_LEVELS
    jge FinalWin
    
    ; Ask to continue to next level
    call WaitForNextLevel
    cmp al, 1       ; 1 = continue, 0 = quit
    je NextLevel
    jmp ExitGame

NextLevel:
    inc currentLevel
    jmp LevelLoop

FinalWin:
    call ShowFinalWinMessage
    jmp ExitGame

CheckInput:
    call ReadKey
    cmp ax, 0
    je NoInput

    call ProcessMovement
    call UpdateDisplay

NoInput:
    mov eax, 30
    call Delay
    jmp GameLoop

ExitGame:
    call WaitMsg
    exit
main ENDP


; =====================================================================
; SHOW TITLE SCREEN
; =====================================================================
ShowTitleScreen PROC
    call Clrscr
    
    mov edx, OFFSET titleLine1
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine2
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine3
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine4
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine5
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine6
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine7
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine8
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine9
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine10
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine11
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine12
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine13
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine14
    call WriteString
    call Crlf
    
    mov edx, OFFSET titleLine15
    call WriteString
    call Crlf
    call Crlf
    
    mov edx, OFFSET titlePrompt
    call WriteString
    
    ; Wait for any key
    call ReadChar
    ret
ShowTitleScreen ENDP


; =====================================================================
; SHOW INSTRUCTIONS SCREEN
; =====================================================================
ShowInstructionsScreen PROC
    call Clrscr
    
    mov edx, OFFSET instrLine1
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine2
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine3
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine4
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine5
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine6
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine7
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine8
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine9
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine10
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine11
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine12
    call WriteString
    call Crlf
    
    mov edx, OFFSET instrLine13
    call WriteString
    call Crlf
    call Crlf
    
    mov edx, OFFSET instrPrompt
    call WriteString
    
    ; Wait for any key
    call ReadChar
    ret
ShowInstructionsScreen ENDP


; =====================================================================
; LOAD LEVEL (sets player and exit positions)
; =====================================================================
LoadLevel PROC
    ; Get current level index (0-based)
    mov eax, currentLevel
    dec eax                     ; make it 0-based
    
    ; Load start position
    mov ebx, 4                  ; DWORD size
    mul ebx
    mov ebx, eax
    
    mov eax, levelStartRows[ebx]
    mov playerRow, eax
    mov eax, levelStartCols[ebx]
    mov playerCol, eax
    
    ; Load exit position
    mov eax, levelExitRows[ebx]
    mov exitRow, eax
    mov eax, levelExitCols[ebx]
    mov exitCol, eax
    
    ret
LoadLevel ENDP


; =====================================================================
; DRAW MAZE (uses current level's maze data)
; =====================================================================
DrawMaze PROC
    LOCAL row:DWORD
    LOCAL rowAddr:DWORD
    LOCAL mazePtr:DWORD

    ; Get pointer to current maze
    mov eax, currentLevel
    dec eax
    mov ebx, 4
    mul ebx
    mov ebx, eax
    mov eax, levelMazePointers[ebx]
    mov mazePtr, eax

    mov row, 0

DrawRow:
    cmp row, MAZE_ROWS
    jge DrawPlayer

    mov dh, BYTE PTR row
    mov dl, 0
    call Gotoxy

    ; rowAddr = mazePtr + row * ROW_STRIDE
    mov eax, row
    mov ebx, ROW_STRIDE
    mul ebx
    add eax, mazePtr
    mov rowAddr, eax

    mov edx, rowAddr
    call WriteString

    inc row
    jmp DrawRow

DrawPlayer:
    ; Draw player over the maze
    mov dh, BYTE PTR playerRow
    mov dl, BYTE PTR playerCol
    call Gotoxy
    mov al, PLAYER_CHAR
    call WriteChar

    ret
DrawMaze ENDP


; =====================================================================
; UPDATE DISPLAY (erase old @, draw new @)
; =====================================================================
UpdateDisplay PROC
    ; Erase previous position
    mov dh, BYTE PTR prevRow
    mov dl, BYTE PTR prevCol
    call Gotoxy
    mov al, PATH_CHAR
    call WriteChar

    ; Draw player at new position
    mov dh, BYTE PTR playerRow
    mov dl, BYTE PTR playerCol
    call Gotoxy
    mov al, PLAYER_CHAR
    call WriteChar

    ; Update previous position
    mov eax, playerRow
    mov prevRow, eax
    mov eax, playerCol
    mov prevCol, eax

    ret
UpdateDisplay ENDP


; =====================================================================
; MOVEMENT + COLLISION
; =====================================================================
ProcessMovement PROC
    LOCAL newRow:DWORD, newCol:DWORD
    LOCAL keyASCII:BYTE, keyScan:BYTE
    LOCAL mazePtr:DWORD

    ; Save key info
    mov keyASCII, al
    mov keyScan, ah

    mov eax, playerRow
    mov newRow, eax
    mov eax, playerCol
    mov newCol, eax

    ; Get current maze pointer
    mov eax, currentLevel
    dec eax
    mov ebx, 4
    mul ebx
    mov ebx, eax
    mov eax, levelMazePointers[ebx]
    mov mazePtr, eax

    ; Check ASCII keys (WASD)
    mov al, keyASCII
    cmp al, 0
    je CheckArrowKeys
    cmp al, 224
    je CheckArrowKeys

    cmp al, 'w'
    je MoveUp
    cmp al, 'W'
    je MoveUp
    cmp al, 's'
    je MoveDown
    cmp al, 'S'
    je MoveDown
    cmp al, 'a'
    je MoveLeft
    cmp al, 'A'
    je MoveLeft
    cmp al, 'd'
    je MoveRight
    cmp al, 'D'
    je MoveRight

    jmp InvalidMove

CheckArrowKeys:
    mov ah, keyScan
    cmp ah, 72
    je MoveUp
    cmp ah, 80
    je MoveDown
    cmp ah, 75
    je MoveLeft
    cmp ah, 77
    je MoveRight
    jmp InvalidMove

MoveUp:
    dec newRow
    jmp CheckCollision
MoveDown:
    inc newRow
    jmp CheckCollision
MoveLeft:
    dec newCol
    jmp CheckCollision
MoveRight:
    inc newCol
    jmp CheckCollision

CheckCollision:
    ; Bounds check
    cmp newRow, 0
    jl InvalidMove
    cmp newRow, MAZE_ROWS-1
    jg InvalidMove
    cmp newCol, 0
    jl InvalidMove
    cmp newCol, MAZE_COLS-1
    jg InvalidMove

    ; Get character at (newRow, newCol)
    mov eax, newRow
    mov ebx, ROW_STRIDE
    mul ebx
    add eax, mazePtr
    add eax, newCol
    mov bl, BYTE PTR [eax]

    ; Check if wall
    cmp bl, WALL_FILL
    je InvalidMove
    cmp bl, BORDER_V
    je InvalidMove
    cmp bl, BORDER_H
    je InvalidMove
    cmp bl, CORNER_TL
    je InvalidMove
    cmp bl, CORNER_TR
    je InvalidMove
    cmp bl, CORNER_BL
    je InvalidMove
    cmp bl, CORNER_BR
    je InvalidMove

ValidMove:
    mov eax, newRow
    mov playerRow, eax
    mov eax, newCol
    mov playerCol, eax

InvalidMove:
    ret
ProcessMovement ENDP


; =====================================================================
; SHOW LEVEL CLEAR MESSAGE
; =====================================================================
ShowLevelClearMessage PROC
    mov dh, MAZE_ROWS + 2
    mov dl, 0
    call Gotoxy
    
    mov edx, OFFSET levelClearMsg
    call WriteString
    call Crlf
    
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET levelClearNum
    call WriteString
    
    mov eax, currentLevel
    call WriteDec
    
    mov edx, OFFSET levelClearNum2
    call WriteString
    call Crlf
    
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET levelClearMsg2
    call WriteString
    call Crlf
    call Crlf
    
    ret
ShowLevelClearMessage ENDP


; =====================================================================
; WAIT FOR NEXT LEVEL (returns 1 in AL if continue, 0 if quit)
; =====================================================================
WaitForNextLevel PROC
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET nextLevelPrompt
    call WriteString

WaitLoop:
    call ReadKey
    cmp al, 'N'
    je Continue
    cmp al, 'n'
    je Continue
    cmp al, 'Q'
    je Quit
    cmp al, 'q'
    je Quit
    jmp WaitLoop

Continue:
    mov al, 1
    ret

Quit:
    mov al, 0
    ret
WaitForNextLevel ENDP


; =====================================================================
; SHOW FINAL WIN MESSAGE
; =====================================================================
ShowFinalWinMessage PROC
    call Clrscr
    
    mov edx, OFFSET finalWinLine1
    call WriteString
    call Crlf
    
    mov edx, OFFSET finalWinLine2
    call WriteString
    call Crlf
    
    mov edx, OFFSET finalWinLine3
    call WriteString
    call Crlf
    
    mov edx, OFFSET finalWinLine4
    call WriteString
    call Crlf
    
    mov edx, OFFSET finalWinLine5
    call WriteString
    call Crlf
    
    mov edx, OFFSET finalWinLine6
    call WriteString
    call Crlf
    call Crlf
    
    mov edx, OFFSET finalWinPrompt
    call WriteString
    
    ; Wait for key so console doesn't close immediately
    call ReadKey
    ret
ShowFinalWinMessage ENDP

END main
