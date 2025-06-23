#!/bin/bash

mpv --loop=inf Scripts/tetris.mp3 > /dev/null 2>&1 & echo $! > /tmp/mpv_pid.txt

QUIT=0
RIGHT=1
LEFT=2
ROTATE=3
DOWN=4
DROP=5
TOGGLE_HELP=6
TOGGLE_NEXT=7
TOGGLE_COLOR=8

DELAY=1 
DELAY_FACTOR=0.8

RED=1
GREEN=2
YELLOW=3
BLUE=4
FUCHSIA=5
CYAN=6
WHITE=7

PLAYFIELD_W=10
PLAYFIELD_H=20
PLAYFIELD_X=30
PLAYFIELD_Y=1
BORDER_COLOR=$YELLOW

SCORE_X=1
SCORE_Y=2
SCORE_COLOR=$GREEN

HELP_X=58
HELP_Y=1
HELP_COLOR=$CYAN

NEXT_X=14
NEXT_Y=11

GAMEOVER_X=1
GAMEOVER_Y=$((PLAYFIELD_H + 3))

LEVEL_UP=20

colors=($RED $GREEN $YELLOW $BLUE $FUCHSIA $CYAN $WHITE)

no_color=true
showtime=true 
empty_cell=" ."
filled_cell="[]"

score=0        
level=1         
lines_completed=0

puts() {
    screen_buffer+=${1}
}

xyprint() {
    puts "\033[${2};${1}H${3}"
}

show_cursor() {
    echo -ne "\033[?25h"
}

hide_cursor() {
    echo -ne "\033[?25l"
}


set_fg() {
    $no_color && return
    puts "\033[3${1}m"
}

set_bg() {
    $no_color && return
    puts "\033[4${1}m"
}

reset_colors() {
    puts "\033[0m"
}

set_bold() {
    puts "\033[1m"
}

redraw_playfield() {
    local j i x y xp yp

    ((xp = PLAYFIELD_X))
    for ((y = 0; y < PLAYFIELD_H; y++)) {
        ((yp = y + PLAYFIELD_Y))
        ((i = y * PLAYFIELD_W))
        xyprint $xp $yp ""
        for ((x = 0; x < PLAYFIELD_W; x++)) {
            ((j = i + x))
            if ((${play_field[$j]} == -1)) ; then
                puts "$empty_cell"
            else
                set_fg ${play_field[$j]}
                set_bg ${play_field[$j]}
                puts "$filled_cell"
                reset_colors
            fi
        }
    }
}

update_score() {
    ((lines_completed += $1))
    ((score += ($1 * $1)))
    if (( score > LEVEL_UP * level)) ; then 
        ((level++))                        
        pkill -SIGUSR1 -f "/bin/bash $0" 
    fi
    set_bold
    set_fg $SCORE_COLOR
    xyprint $SCORE_X $SCORE_Y         "Lineas completadas: $lines_completed"
    xyprint $SCORE_X $((SCORE_Y + 1)) "Nivel:              $level"
    xyprint $SCORE_X $((SCORE_Y + 2)) "Puntaje:            $score"
    reset_colors
}

help=(
"  Usa las flechas"
"       o sino"
"      s: Arriba"
"a: Izquierda,  d: Derecha"
"    space: caer"
"      q: salir"
"  c: cambiar color"
"n: mostrar siguiente"
"h: mostrar ayuda"
)

help_on=-1

toggle_help() {
    local i s

    set_bold
    set_fg $HELP_COLOR
    for ((i = 0; i < ${#help[@]}; i++ )) {
        ((help_on == 1)) && s="${help[i]}" || s="${help[i]//?/ }"
        xyprint $HELP_X $((HELP_Y + i)) "$s"
    }
    ((help_on = -help_on))
    reset_colors
}

piece=(
"00011011"                         
"0212223210111213"                 
"0001111201101120"                 
"0102101100101121"                 
"01021121101112220111202100101112" 
"01112122101112200001112102101112" 
"01111221101112210110112101101112" 
)

draw_piece() {
    local i x y

    for ((i = 0; i < 8; i += 2)) {
        ((x = $1 + ${piece[$3]:$((i + $4 * 8 + 1)):1} * 2))
        ((y = $2 + ${piece[$3]:$((i + $4 * 8)):1}))
        xyprint $x $y "$5"
    }
}

next_piece=0
next_piece_rotation=0
next_piece_color=0

next_on=1

draw_next() {
    ((next_on == -1)) && return
    draw_piece $NEXT_X $NEXT_Y $next_piece $next_piece_rotation "$1"
}

clear_next() {
    draw_next "${filled_cell//?/ }"
}

show_next() {
    set_fg $next_piece_color
    set_bg $next_piece_color
    draw_next "${filled_cell}"
    reset_colors
}

toggle_next() {
    case $next_on in
        1) clear_next; next_on=-1 ;;
        -1) next_on=1; show_next ;;
    esac
}

draw_current() {
    draw_piece $((current_piece_x * 2 + PLAYFIELD_X)) $((current_piece_y + PLAYFIELD_Y)) $current_piece $current_piece_rotation "$1"
}

show_current() {
    set_fg $current_piece_color
    set_bg $current_piece_color
    draw_current "${filled_cell}"
    reset_colors
}

clear_current() {
    draw_current "${empty_cell}"
}

new_piece_location_ok() {
    local j i x y x_test=$1 y_test=$2

    for ((j = 0, i = 1; j < 8; j += 2, i = j + 1)) {
        ((y = ${piece[$current_piece]:$((j + current_piece_rotation * 8)):1} + y_test))
        ((x = ${piece[$current_piece]:$((i + current_piece_rotation * 8)):1} + x_test)) 
        ((y < 0 || y >= PLAYFIELD_H || x < 0 || x >= PLAYFIELD_W )) && return 1         
        ((${play_field[y * PLAYFIELD_W + x]} != -1 )) && return 1                       
    }
    return 0
}

get_random_next() {
    current_piece=$next_piece
    current_piece_rotation=$next_piece_rotation
    current_piece_color=$next_piece_color
    ((current_piece_x = (PLAYFIELD_W - 4) / 2))
    ((current_piece_y = 0))
    new_piece_location_ok $current_piece_x $current_piece_y || cmd_quit
    show_current

    clear_next
    ((next_piece = RANDOM % ${#piece[@]}))
    ((next_piece_rotation = RANDOM % (${#piece[$next_piece]} / 8)))
    ((next_piece_color = RANDOM % ${#colors[@]}))
    show_next
}

draw_border() {
    local i x1 x2 y

    set_bold
    set_fg $BORDER_COLOR
    ((x1 = PLAYFIELD_X - 2))               
    ((x2 = PLAYFIELD_X + PLAYFIELD_W * 2)) 
    for ((i = 0; i < PLAYFIELD_H + 1; i++)) {
        ((y = i + PLAYFIELD_Y))
        xyprint $x1 $y "<|"
        xyprint $x2 $y "|>"
    }

    ((y = PLAYFIELD_Y + PLAYFIELD_H))
    for ((i = 0; i < PLAYFIELD_W; i++)) {
        ((x1 = i * 2 + PLAYFIELD_X)) 
        xyprint $x1 $y '=='
        xyprint $x1 $((y + 1)) "\/"
    }
    reset_colors
}

toggle_color() {
    $no_color && no_color=false || no_color=true
    show_next
    update_score 0
    toggle_help
    toggle_help
    draw_border
    redraw_playfield
    show_current
}

init() {
    local i x1 x2 y

    for ((i = 0; i < PLAYFIELD_H * PLAYFIELD_W; i++)) {
        play_field[$i]=-1
    }

    clear
    hide_cursor
    get_random_next
    get_random_next
    toggle_color
}

ticker() {
    trap exit SIGUSR2
    trap 'DELAY=$(awk "BEGIN {print $DELAY * $DELAY_FACTOR}")' SIGUSR1

    while true ; do echo -n $DOWN; sleep $DELAY; done
}

reader() {
    trap exit SIGUSR2 
    trap '' SIGUSR1   
    local -u key a='' b='' cmd esc_ch=$'\x1b'
    declare -A commands=([A]=$ROTATE [C]=$RIGHT [D]=$LEFT
        [_S]=$ROTATE [_A]=$LEFT [_D]=$RIGHT
        [_]=$DROP [_Q]=$QUIT [_H]=$TOGGLE_HELP [_N]=$TOGGLE_NEXT [_C]=$TOGGLE_COLOR)

    while read -s -n 1 key ; do
        case "$a$b$key" in
            "${esc_ch}["[ACD]) cmd=${commands[$key]} ;; 
            *${esc_ch}${esc_ch}) cmd=$QUIT ;;           
            *) cmd=${commands[_$key]:-} ;;              
        esac
        a=$b   
        b=$key
        [ -n "$cmd" ] && echo -n "$cmd"
    done
}

flatten_playfield() {
    local i j k x y
    for ((i = 0, j = 1; i < 8; i += 2, j += 2)) {
        ((y = ${piece[$current_piece]:$((i + current_piece_rotation * 8)):1} + current_piece_y))
        ((x = ${piece[$current_piece]:$((j + current_piece_rotation * 8)):1} + current_piece_x))
        ((k = y * PLAYFIELD_W + x))
        play_field[$k]=$current_piece_color
    }
}

process_complete_lines() {
    local j i complete_lines
    ((complete_lines = 0))
    for ((j = 0; j < PLAYFIELD_W * PLAYFIELD_H; j += PLAYFIELD_W)) {
        for ((i = j + PLAYFIELD_W - 1; i >= j; i--)) {
            ((${play_field[$i]} == -1)) && break
        }
        ((i >= j)) && continue 
        ((complete_lines++))
        
        for ((i = j - 1; i >= 0; i--)) {
            play_field[$((i + PLAYFIELD_W))]=${play_field[$i]}
        }
        
        for ((i = 0; i < PLAYFIELD_W; i++)) {
            play_field[$i]=-1
        }
    }
    return $complete_lines
}

process_fallen_piece() {
    flatten_playfield
    process_complete_lines && return
    update_score $?
    redraw_playfield
}

move_piece() {
    if new_piece_location_ok $1 $2 ; then 
        clear_current                     
        current_piece_x=$1                
        current_piece_y=$2                
        show_current                      
        return 0                          
    fi                                    
    (($2 == current_piece_y)) && return 0 
    process_fallen_piece                  
    get_random_next                       
    return 1
}

cmd_right() {
    move_piece $((current_piece_x + 1)) $current_piece_y
}

cmd_left() {
    move_piece $((current_piece_x - 1)) $current_piece_y
}

cmd_rotate() {
    local available_rotations old_rotation new_rotation

    available_rotations=$((${#piece[$current_piece]} / 8))            
    old_rotation=$current_piece_rotation                              
    new_rotation=$(((old_rotation + 1) % available_rotations))        
    current_piece_rotation=$new_rotation                              
    if new_piece_location_ok $current_piece_x $current_piece_y ; then
        current_piece_rotation=$old_rotation                        
        clear_current                                                 
        current_piece_rotation=$new_rotation                          
        show_current                                               
    else                                                              
        current_piece_rotation=$old_rotation                          
    fi
}

cmd_down() {
    move_piece $current_piece_x $((current_piece_y + 1))
}

cmd_drop() {
    while move_piece $current_piece_x $((current_piece_y + 1)) ; do : ; done
}

cmd_quit() {
    showtime=false                               
    pkill -SIGUSR2 -f "/bin/bash $0" 
    xyprint $GAMEOVER_X $GAMEOVER_Y "Juego terminado, Presiona Q para salir"
    kill $(cat /tmp/mpv_pid.txt)
    echo -e "$screen_buffer"
}

controller() {
    trap '' SIGUSR1 SIGUSR2
    local cmd commands

    commands[$QUIT]=cmd_quit
    commands[$RIGHT]=cmd_right
    commands[$LEFT]=cmd_left
    commands[$ROTATE]=cmd_rotate
    commands[$DOWN]=cmd_down
    commands[$DROP]=cmd_drop
    commands[$TOGGLE_HELP]=toggle_help
    commands[$TOGGLE_NEXT]=toggle_next
    commands[$TOGGLE_COLOR]=toggle_color

    init

    while $showtime; do           
        echo -ne "$screen_buffer" 
        screen_buffer=""          
        read -s -n 1 cmd          
        ${commands[$cmd]}         
    done
}

stty_g=`stty -g`

(
    ticker & 
    reader
)|(
    controller
)

show_cursor
stty $stty_g 

