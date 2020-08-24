#!/usr/bin/env bash

# 📌 notes() - add a note to the file .notes in the current folder
# Usage: notes <command options> | notes <description>
# --------------------------------------------------------------------------------------------
alias .n='.notes '     # create a shortcut alias
notes() {
  _date=$(echo "$(dts day)");
  [[ -z ${1} ]] && { shift; cat .notes; return; }
  [[ "${1}" == "-"  ]] && { shift; echo "${_date} $*" >> .notes; return;  }
  [[ "${1}" == "-l" ]] || [[ "${1}" == "list"     ]] && { less .notes; return; }
  [[ "${1}" == "-e" ]] || [[ "${1}" == "edit"     ]] && { edit .notes; return; }
  [[ "${1}" == "-?" ]] || [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "?" ]] && {
    echo -e "
    PURPOSE: View project notes in current folder (file: .notes)

    ${FUNCNAME[0]} | ${FUNCNAME[0]} <note> | ${FUNCNAME[0]} <command options>

    OPTIONS:
     <none>          List current notes
     <note string>   Add <note string> (w/date stamp) to the file .notes
                     in the current folder
     -l | list       Show the .notes list in the current folder
     -e | edit       Edit the .notes list in the current folder
     -? | -h | help  This help
    "
    [[ $( alias | grep "alias .n=" ) ]] && {
         echo -e "    Defined \c"
         alias .n
         echo;
    }
    return;
    }
    [[ "${1}" != ""   ]] && { echo " ${_date} $* " >> .notes; return; }
    # Based on the below aliases:
    # alias notes='echo "  "$(date +%A,\ %B\ %d\ %l\:%M\ %p\:) $* >> .notes'  # add a dated note to ".notes" file for each project
    # alias notess='grep -h "$1" .notes'                                    # show multiline notes in ".notes" file (changed ~/.notes to .notes)
}
