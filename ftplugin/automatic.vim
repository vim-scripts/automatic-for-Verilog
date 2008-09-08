" Vim Plugin for Verilog Code Automactic Generation
" Language:     Verilog
" Maintainer:   Gavin Ge <arrowroothover@hotmail.com>
" Version:      1.00
" Last Update:  Mon Sept 8 2008
" For version 7.x or above

if version < 700
   finish
endif
if exists("b:vlog_plugin")
   finish
endif
let b:vlog_plugin = 1

iabbrev <= <= #FFD

amenu &Verilog.&Header          :call AddHeader()<CR>
amenu &Verilog.&Comment         :call AddComment()<CR>
amenu &Verilog.Auto&Argument    :call AutoArg()<CR>
amenu &Verilog.Auto&Instance    :call AutoInst()<CR>
amenu &Verilog.Auto&Define      :call AutoDef()<CR>
amenu &Verilog.&KillAuto        :call AutoKillAuto()<CR>
amenu &Verilog.KillAutoArg      :call KillAutoArg()<CR>
amenu &Verilog.KillAutoInst     :call KillAutoInst()<CR>
amenu &Verilog.KillAutoDef      :call KillAutoDef()<CR>
amenu &Verilog.Always\ with\ posedge\ clock\ and\ posedge\ reset :call AddAlways("posedge", "posedge")<CR>
amenu &Verilog.Always\ with\ posedge\ clock\ and\ negedge\ reset :call AddAlways("posedge", "negedge")<CR>
amenu &Verilog.Always\ with\ negedge\ clock\ and\ posedge\ reset :call AddAlways("negedge", "posedge")<CR>
amenu &Verilog.Always\ with\ negedge\ clock\ and\ negedge\ reset :call AddAlways("negedge", "negedge")<CR>
amenu &Verilog.Always\ with\ posedge\ clock :call AddAlways("posedge", "")<CR>
amenu &Verilog.Always\ with\ negedge\ clock :call AddAlways("negedge", "")<CR>
amenu &Verilog.Combinational\ Always :call AddAlways("", "")<CR>

command Alpp :call AddAlways("posedge", "posedge")
command Alpn :call AddAlways("posedge", "negedge")
command Alnp :call AddAlways("negedge", "posedge")
command Alnn :call AddAlways("negedge", "negedge")
command Alp :call AddAlways("posedge", "")
command Aln :call AddAlways("negedge", "")
command Al :call AddAlways("", "")

"===============================================================
"        Add File Header
"===============================================================
function AddHeader()
  call append(0,  "//")
  call append(1,  "// Created by         :Marvell(Shanghai)Ltd.")
  call append(2,  "// Filename           :".expand("%"))
  call append(3,  "// Author             :".$USER."(RDC)")
  call append(4,  "// Created On         :".strftime("%Y-%m-%d %H:%M"))
  call append(5,  "// Last Modified      : ")
  call append(6,  "// Update Count       :".strftime("%Y-%m-%d %H:%M"))
  call append(7,  "// Description        :")
  call append(8,  "//                     ")
  call append(9,  "//                     ")
  call append(10, "//=======================================================================")
endfunction

"===============================================================
"        Add Comment Lines
"===============================================================
function AddComment()
   let curr_line = line(".")
   call append(curr_line,  "//===========================================")
   call append(curr_line+1,"//       ")
   call append(curr_line+2,"//===========================================")
endfunction

"===============================================================
"        Add an always statement
"===============================================================
function AddAlways(clk_edge, rst_edge)
   for line in getline(1, line("$"))
      if line =~ '^\s*\<input\>.*//\s*\<clock\>\s*$'
         let line = substitute(line, '^\s*\<input\>\s*', "", "")
         let clk = substitute(line, '\s*;.*$', "", "")
      elseif line =~ '^\s*\<input\>.*//\s*\<reset\>\s*$'
         let line = substitute(line, '^\s*\<\input\>\s*', "", "")
         let rst = substitute(line, '\s*;.*$', "", "")
      endif
   endfor
   let curr_line = line(".")
   if a:clk_edge == "posedge" && a:rst_edge == "posedge"
      call append(curr_line,   "always @(posedge ".clk." or posedge ".rst.") begin")
      call append(curr_line+1, "    if (".rst.") begin")
      call append(curr_line+2, "    end")
      call append(curr_line+3, "    else begin")
      call append(curr_line+4, "    end")
      call append(curr_line+5, "end")
   elseif a:clk_edge == "negedge" && a:rst_edge == "posedge"
      call append(curr_line,   "always @(negedge ".clk." or posedge ".rst.") begin")
      call append(curr_line+1, "    if (".rst.") begin")
      call append(curr_line+2, "    end")
      call append(curr_line+3, "    else begin")
      call append(curr_line+4, "    end")
      call append(curr_line+5, "end")
   elseif a:clk_edge == "posedge" && a:rst_edge == "negedge"
      call append(curr_line,   "always @(posedge ".clk." or negedge ".rst.") begin")
      call append(curr_line+1, "    if (!".rst.") begin")
      call append(curr_line+2, "    end")
      call append(curr_line+3, "    else begin")
      call append(curr_line+4, "    end")
      call append(curr_line+5, "end")
   elseif a:clk_edge == "negedge" && a:rst_edge == "negedge"
      call append(curr_line,   "always @(negedge ".clk." or negedge ".rst.") begin")
      call append(curr_line+1, "    if (!".rst.") begin")
      call append(curr_line+2, "    end")
      call append(curr_line+3, "    else begin")
      call append(curr_line+4, "    end")
      call append(curr_line+5, "end")
   elseif a:clk_edge == "posedge" && a:rst_edge == ""
      call append(curr_line,   "always @(posedge ".clk.") begin")
      call append(curr_line+1, "end")
   elseif a:clk_edge == "negedge" && a:rst_edge == ""
      call append(curr_line,   "always @(negedge ".clk.") begin")
      call append(curr_line+1, "end")
   else
      call append(curr_line,   "always @(*) begin")
      call append(curr_line+1, "end")
   endif
endfunction

"===============================================================
"        Automatic Argument Generation
"===============================================================
function KillAutoArg()
   let aft_kill = []
   let line_index = 1
   while line_index <= line("$")
      let line = getline(line_index)
      if line =~ '^\s*\<module\>' && line=~ '\<\(autoarg\|AUTOARG\)\>\*/\s*$'
         call add(aft_kill, line.");")
         let line_index = line_index + 1
         while line !~ ');\s*$'
            let line_index = line_index + 1
            let line = getline(line_index)
         endwhile
         let line_index = line_index + 1
      else
         call add(aft_kill, line)
         let line_index = line_index + 1
      endif
   endwhile
   if len(aft_kill) < line("$")
      for line_index in range(line("$"))
         if line_index > len(aft_kill)
            call setline(line_index, "")
         else
            call setline(line_index, aft_kill[line_index-1]
         endif
      endfor
   else
      for line_index in range(1, len(aft_kill), 1)
         call setline(line_index, aft_kill[line_index-1])
      endfor
   endif
endfunction

function AutoArg()
   let total_line = line("$")
   let inputs = []
   let outputs = []
   let line_index = 1
   call KillAutoArg()
   for line in getline(1, total_line)
      if line =~ '^\s*\<input\>'
         let line = substitute(line, '^\s*\<input\>\s*\(\[.*:.*\]\)*\s*', "", "")
         let line = substitute(line, ';.*$', "", "")
         call add(inputs, line)
      elseif line =~ '^\s*\<output\>'
         let line = substitute(line, '^\s*\<output\>\s*\(\[.*:.*\]\)*\s*', "", "")
         let line = substitute(line, ';.*$', "", "")
         call add(outputs, line)
      endif
   endfor
   let line_index = 1
   for line in getline(1, total_line)
       if line =~ '/\*.*\<\(autoarg\|AUTOARG\)\>.*'
          let line = substitute(line, ').*', "", "")
          call setline(line_index, line)
          call append(line_index, "    //Inputs")
          let line_index = line_index + 1
          let input_col = 3
          let signal_line = "    "
          if (winwidth(0) < 70)
              let max_col = 50
          else
              let max_col = winwidth(0) - 35
          endif
          for signal_index in range(len(inputs))
             if input_col > max_col
                call append(line_index, signal_line)
                let line_index = line_index + 1
                let signal_line = "    " . inputs[signal_index] . ", "
                let input_col = 3 + strlen(inputs[signal_index])
             else
                let signal_line = signal_line . inputs[signal_index] . ", "
                let input_col = input_col + strlen(inputs[signal_index])
             endif
          endfor
          call append(line_index, signal_line)
          let line_index = line_index + 1
          call append(line_index, "    //Outputs")
          let line_index = line_index + 1
          let output_col = 3
          let signal_line = "    "
          for signal_index in range(len(outputs)-1)
             if output_col > max_col
                call append(line_index, signal_line)
                let line_index = line_index + 1
                let signal_line = "    " . outputs[signal_index] . ", "
                let output_col = 3 + strlen(outputs[signal_index])
             else
                let signal_line = signal_line . outputs[signal_index] . ", "
                let output_col = output_col + strlen(outputs[signal_index])
             endif
          endfor
          let signal_line = signal_line . outputs[len(outputs)-1] . ");"
          call append(line_index, signal_line)
          return 1
       else
          let line_index = line_index + 1
       endif
     endfor
endfunction

"===============================================================
"        Automatic Instance Generation
"===============================================================
function CalMargin(max_len, cur_len)
   let margin = ""
   for i in range(a:max_len-a:cur_len+1)
      let margin = margin." "
   endfor
   return margin
endfunction

function KillAutoInst()
   let line_index = 1
   let aft_kill = []
   while line_index <= line("$")
      let line = getline(line_index)
      if line =~ '/\*\<autoinst\>\*/\s*$'
         let line = line . ");"
         call add(aft_kill, line)
         let line_index = line_index + 1
         let line = getline(line_index)
         while line !~ ');$'
            let line_index = line_index + 1
            let line = getline(line_index)
         endwhile
         let line_index = line_index + 1
      else
         call add(aft_kill, line)
         let line_index = line_index + 1
      endif
   endwhile
   if len(aft_kill) < line("$")
      for line_index in range(1, line("$"), 1)
         if line_index > len(aft_kill)
            call setline(line_index, "")
         else
            call setline(line_index, aft_kill[line_index-1])
         endif
      endfor
   else
      for line_index in range(1, len(aft_kill), 1)
         call setline(line_index, aft_kill[line_index-1])
      endfor
   endif
endfunction

function AutoInst()
   let aft_inst = []
   let insts = []
   let inst_file = ""
   let line_inst= ""
   call KillAutoInst()
   let vc_file = substitute(expand("%"), '\.\(v\|sv\)$', ".vc", "")
   for line in getline(1, line("$"))
      if line =~ '(/\*\<\(autoinst\|AUTOINST\)\>\s*\*/)\s*;.*$'
         let insts = split(line)
         let inst_name = insts[0]
         let vc_file = findfile(vc_file)
         if vc_file == ""
            let inst_file = inst_name . ".v"
         else
            for insts in readfile(vc_file)
               let tmp = substitute(insts, '.*/', "", "g")
               if tmp == (inst_name . ".v")
                  let inst_file = insts
               endif
            endfor
         endif
         if inst_file == ""
            let inst_file = inst_name . ".v"
         endif
         let inst_input = {}
         let inst_output = {}
         let max_len = 0
         for line_inst in readfile(inst_file)
            if line_inst =~ '^\s*\<input\>\s*\['
               let line_inst = substitute(line_inst, '^\s*\<input\>\s*', "", "")
               let line_inst = substitute(line_inst, ';\.*$', "", "")
               let port = split(line_inst)
               if max_len < len(port[1])
                  let max_len = len(port[1])
               endif
               call extend(inst_input, {port[1] : port[0]}, "force")
            elseif line_inst =~ '^\s*\<input\>'
               let line_inst = substitute(line_inst, '^\s*\<input\>\s*', "", "")
               let port_name = substitute(line_inst, ';\.*$', "", "")
               if max_len < len(port_name)
                  let max_len = len(port_name)
               endif
               call extend(inst_input, {port_name : ''}, "force")
            elseif line_inst =~ '^\s*\<output\>\s*\['
               let line_inst = substitute(line_inst, '^\s*\<output\>\s*', "", "")
               let line_inst = substitute(line_inst, ';\s*$', "", "")
               let port = split(line_inst)
               if max_len < len(port[1])
                  let max_len0 = len(port[1])
               endif
               call extend(inst_output, {port[1] : port[0]}, "force")
            elseif line_inst =~ '^\s*\<output\>'
               let line_inst = substitute(line_inst, '^\s*\<output\>\s*', "", "")
               let port_name = substitute(line_inst, ';\.*$', "", "")
               if max_len < len(port_name)
                  let max_len = len(port_name)
               endif
               call extend(inst_output, {port_name : ''}, "force")
            endif
         endfor
         let line = substitute(line, ');\s*', "", "")
         call add(aft_inst, line)
         call add(aft_inst, "        //Inputs")
         for ports in keys(inst_input)
            let margin = CalMargin(max_len, len(ports))
            call add(aft_inst, "        .".ports.margin."(".ports.inst_input[ports]."),")
         endfor
         call add(aft_inst, "        //Outputs")
         for ports in keys(inst_output)
            let margin = CalMargin(max_len, len(ports))
            call add(aft_inst, "        .".ports.margin."(".ports.inst_output[ports]."),")
         endfor
         let line = remove(aft_inst, -1)
         let line = substitute(line, "),", "));", "")
         call add(aft_inst, line)
      else
         call add(aft_inst, line)
      endif
   endfor
   for line_index in range(1, len(aft_inst), 1)
      call setline(line_index, aft_inst[line_index-1])
   endfor
endfunction
"===============================================================
"        Automatic Signal Definition Generation
"===============================================================
function PushSignal(signals, signal_name, signal_msb, signal_width, max_len)
   " Signal width comes from the right part of the assignmnet
   if a:signal_msb == ""
      if has_key(a:signals, a:signal_name) == 1
         if a:signals[a:signal_name] =~ '\d\+'
            if str2nr(a:signals[a:signal_name], 10) < (a:signal_width-1)
               call extend(a:signals, {a:signal_name : a:signal_width-1}, "force")
            endif
         endif
      else
         call extend(a:signals, {a:signal_name : a:signal_width-1}, "force")
      endif
   " Signal width comes from the left part of the assignment
   " if MSB is a parameter then update value with it
   elseif a:signal_msb !~ '^\d\+$'
      call extend(a:signals, {a:signal_name : a:signal_msb}, "force")
   elseif has_key(a:signals, a:signal_name) != 1
      call extend(a:signals, {a:signal_name : a:signal_msb}, "force")
   " if the Old value is a parameter do not update
   elseif a:signals[a:signal_name] !~ '^[a-zA-z].*'
      if a:signal_msb == 0
         call extend(a:signals, {a:signal_name : 0}, "force")
      elseif str2nr(a:signals[a:signal_name], 10) < a:signal_msb
         call extend(a:signals, {a:signal_name : a:signal_msb}, "force")
      endif
   endif
   if a:max_len < (len(a:signal_msb) + 4)
      return len(a:signal_msb) + 4
   elseif a:max_len < (len(a:signal_width) + 4)
      return len(a:signal_width) + 4
   else
      return a:max_len
endfunction

function KillAutoDef()
   let aft_kill = []
   let line_index = 1
   while line_index <= line("$")
      let line = getline(line_index)
      if line == "// Define flip-flop registers here"
         let line_index = line_index + 1
         let line = getline(line_index)
         while line != "// End of automatic define"
            let line_index = line_index + 1
            let line = getline(line_index)
         endwhile
         let line_index = line_index + 1
      else
         call add(aft_kill, line)
         let line_index = line_index + 1
      endif
   endwhile
   if len(aft_kill) < line("$")
      for line_index in range(1, line("$"))
         if line_index > len(aft_kill)
            call setline(line_index, "")
         else
            call setline(line_index, aft_kill[line_index-1])
         endif
      endfor
   else
      for line_index in range(1, len(aft_kill), 1)
         call setline(line_index, aft_kill[line_index-1])
      endfor
   endif
endfunction

function AutoDef()
   let ff_reg = {}
   let comb_reg = {}
   let inst_wire = {}
   let wire = {}
   let aft_def = []
   let max_len = 0
   let line_index = 1
   let signal_name = ""
   let signal_msb = ""
   let signal_width = ""
   call KillAutoDef()
   " Get Flip-flop Reg Signals
   while line_index <= line("$")
      let line = getline(line_index)
      if line =~ '^\s*\<always\>\s*@\s*(\s*\<\(posedge\|negedge\)\>'
         let line_index = line_index + 1
         let line = getline(line_index)
         while line !~ '^\s*\<always\>' && line !~ '^\s*\<assign\>' && line !~ '^\s*\<function\>'
            " Remove if(...)
            let line = substitute(line, '\<if\>\s*(.*)', " ", "")
            " Remove ... ?
            let line = substitute(line, '\s\+\w\+\s\+?', " ", "g")
            " Remove (...)?
            let line = substitute(line, '([^()]*)\s*?', " ", "g")
            " Remove )
            let line = substitute(line, ")", "", "g")
            if line =~ '.*<=.*'
               let line = matchstr(line, '\s\+\w\+\(\[.*\]\)*\s*<=.*\(;\|:\)')
               let line = substitute(line, '^\s*', "", "")
               let line = substitute(line, '\(;\|:\)$', "", "")
               let signal_name = substitute(line, '\s*<=.*', "", "")
               " Match signal[M:N]
               if signal_name =~ ':.*\]$'
                  let signal_msb = substitute(signal_name, '\s*:.*$', "", "")
                  let signal_msb = substitute(signal_msb, '^.*\[\s*', "", "")
                  let signal_name = substitute(signal_name, '\[.*$', "", "")
                  let max_len = PushSignal(ff_reg, signal_name, signal_msb, "", max_len)
               " Match signal <= M'hN or #1 M'dN or # `RD M'bN;
               elseif line =~ "^\\s*\\w\\+\\s*<=\\s*\\(#\\s*'*\\w*\\)*\\s\\+\\d\\+'\\(b\\|h\\|d\\).*"
                  let signal_width = substitute(line, "^\\s*\\w\\+\\s*<=\\s*#\\s*'*\\w*\\s\\+", "", "")
                  let signal_width = substitute(signal_width, "'\\(b\\|h\\|d\\).*", "", "")
                  " delete [N]
                  let signal_name = substitute(signal_name, '\[.*$', "", "")
                  let max_len = PushSignal(ff_reg, signal_name, "", signal_width, max_len)
               " Match signal[N]
               elseif signal_name =~ '\[\w\+\]$'
                  let signal_msb = substitute(signal_name, '\]$', "", "")
                  let signal_msb = substitute(signal_msb, '^.*\[', "", "")
                  let signal_name = substitute(signal_name, '\[.*$', "", "")
                  let max_len = PushSignal(ff_reg, signal_name, signal_msb, "", max_len)
               else
                  let max_len = PushSignal(ff_reg, signal_name, "", 1, max_len)
               endif
            endif
            let line_index = line_index + 1
            let line = getline(line_index)
         endwhile
         let line_index = line_index - 1
      " Get Combinational Reg Signals
      elseif line =~ '^\s*\<always\>'
         let line_index = line_index + 1
         let line = getline(line_index)
         while line !~ '^\s*\<always\>' && line !~ '^\s*\<assign\>' && line !~ '^\s*\<function\>'
             " Remove if(...)
            let line = substitute(line, '\<if\>\s*(.*)', " ", "")
            " Remove ... ?
            let line = substitute(line, '\s\+[^()\s]\+\s*?', " ", "g")
            " Remove (...)?
            let line = substitute(line, '([^()]*)\s*?', " ", "g")
            " Remove )
            let line = substitute(line, ")", "", "g")
            if line =~ '.*=.*'
               let line = matchstr(line, '\s\+\w\+\(\[.*\]\)*\s*=.*\(;\|:\)')
               let line = substitute(line, '^\s*', "", "")
               let line = substitute(line, '\(;\|:\)$', "", "")
               let signal_name = substitute(line, '\s*=.*', "", "")
               " Match signal[M:N]
               if signal_name =~ ':.*\]$'
                  let signal_msb = substitute(signal_name, '\s*:.*$', "", "")
                  let signal_msb = substitute(signal_msb, '^.*\[\s*', "", "")
                  let signal_name = substitute(signal_name, '\[.*$', "", "")
                  let max_len = PushSignal(comb_reg, signal_name, signal_msb, "", max_len)
               " Match signal = M'hN;
               elseif line =~ "^\\s*\\w\\+\\s*=\\s*\\d\\+'\\\(b\\|h\\|d\\).*"
                  let signal_width = substitute(line, '^\s*\w\+\s*=\s*', "", "")
                  let signal_width = substitute(signal_width, "'\\(b\\|h\\|d\\).*", "", "")
                  let signal_name = substitute(signal_name, '\[.*$', "", "")
                  let max_len = PushSignal(comb_reg, signal_name, "", signal_width, max_len)
               " Match signal[N]
               elseif signal_name =~ '\[\w\+\]$'
                  let signal_msb = substitute(signal_name, '\]$', "", "")
                  let signal_msb = substitute(signal_msb, '^.*\[', "", "")
                  let signal_name = substitute(signal_name, '\[.*$', "", "")
                  let max_len = PushSignal(comb_reg, signal_name, signal_msb, "", max_len)
               else
                  let max_len = PushSignal(comb_reg, signal_name, "", 1, max_len)
               endif
            endif
            let line_index = line_index + 1
            let line = getline(line_index)
         endwhile
         let line_index = line_index - 1
      " Get Wires
      elseif line =~ '^\s*\<assign\>'
         let line = substitute(line, '\s\+\[^()\s]\+\s*?', " ", "g")
         let line = substitute(line, '(.*)\s*?', " ", "g")
         let signal_name = substitute(line, '^\s*\<assign\>\s*', "", "")
         let signal_name = substitute(signal_name, '\s*=.*', "", "g")
         "Match: signal[M:N]
         if signal_name =~ ']\s*$'
            let signal_msb = substitute(signal_name, '\s*:.*$', "", "")
            let signal_msb = substitute(signal_msb, '^.*[\s*', "", "")
            let signal_name = substitute(signal_name, '[.*$', "", "")
            let max_len = PushSignal(wire, signal_name, signal_msb, "", max_len)
         " Match: signal = M'hN;
         elseif line =~ "^\\s*\\<assign\\>\\s*\\w\\+\\s*=\\s*\\d\\+'\\(b\\|h\\|d\\).*"
            let signal_width = substitute(line, '^\s*\<assign\>\s\+\w\+\s*=\s*', "", "")
            let signal_width = substitute(signal_width, "'\\(b\\|h\\|d\\).*", "", "")
            let signal_name = substitute(signal_name, '[.*$', "", "")
            let max_len = PushSignal(wire, signal_name, "", signal_width, max_len)
         elseif signal_name =~ '\[\w\+\]$'
            let signal_msb = substitute(signal_name, '\]$', "", "")
            let signal_msb = substitute(signal_msb, '^.*\[', "", "")
            let signal_name = substitute(signal_name, '\[.*$', "", "")
            let max_len = PushSignal(comb_reg, signal_name, signal_msb, "", max_len)
         else
            let max_len = PushSignal(wire, signal_name, "", 1, max_len)
         endif
         let line_index = line_index + 1
      " Get Instance Ouputs
      elseif line =~ '/\*\s*\<\(autoinst\|AUTOINST\)\>\s*\*/\s*$'
         let line_index = line_index + 1
         let line = getline(line_index)
         while line !~ ');\s*$'
            if line =~ '^\s*//\s*\<Outputs\>'
               let line_index = line_index + 1
               let line = getline(line_index)
               while line =~ '^\s*\.'
                  let line = substitute(line, '^.*(\s*', "", "")
                  let line = substitute(line, '\s*).*$', "", "")
                  if line =~ '\]$'
                     let signal_name = substitute(line, '\[.*$', "", "")
                     let signal_msb = substitute(line, '^.*\[', "", "")
                     let signal_msb = substitute(signal_msb, '\s*:.*$', "", "")
                     let max_len = PushSignal(inst_wire, signal_name, signal_msb, "", max_len)
                  else
                     let signal_name = line
                     let max_len = PushSignal(inst_wire, signal_name, "", 1, max_len)
                  endif
                  let line_index = line_index + 1
                  let line = getline(line_index)
               endwhile
               let line_index = line_index - 1
               let line = getline(line_index)
            else
               let line_index = line_index + 1
               let line = getline(line_index)
            endif
         endwhile
         let line_index = line_index + 1
      else
         let line_index = line_index + 1
         let line = getline(line_index)
      endif
   endwhile
   for line in getline(1, line("$"))
      if line =~ '^\s*/\*\<\(autodefine\|AUTODEFINE\)\>\*/'
         call add(aft_def, line)
         call add(aft_def, "// Define flip-flop registers here")
         for regs in sort(keys(ff_reg))
            let margin = CalMargin(max_len, len(ff_reg[regs]))
            if ff_reg[regs] == "0"
               call add(aft_def, "reg       ".margin.regs.";    //")
            else
               call add(aft_def, "reg  [".ff_reg[regs].":0]".margin.regs.";    //")
            endif
         endfor
         call add(aft_def, "// Define combination registers here")
         for regs in sort(keys(comb_reg))
            let margin = CalMargin(max_len, len(comb_reg[regs]))
            if comb_reg[regs] == "0"
               call add(aft_def, "reg       ".margin.regs.";    //")
            else
               call add(aft_def, "reg  [".comb_reg[regs].":0]".margin.regs.";    //")
            endif
         endfor
         call add(aft_def, "// Define wires here")
         for wires in sort(keys(wire))
            let margin = CalMargin(max_len, len(wire[wires]))
            if wire[wires] == "0"
               call add(aft_def, "wire      ".margin.wires.";    //")
            else
               call add(aft_def, "wire [".wire[wires].":0]".margin.wires.";    //")
            endif
         endfor
         call add(aft_def, "// Define instances' ouput wires here")
         for wires in sort(keys(inst_wire))
            let margin = CalMargin(max_len, len(inst_wire[wires]))
            if inst_wire[wires] == "0"
               call add(aft_def, "wire      ".margin.wires.";    //")
            else
               call add(aft_def, "wire [".inst_wire[wires].":0]".margin.wires.";    //")
            endif
         endfor
         call add(aft_def, "// End of automatic define")
      else
         call add(aft_def, line)
      endif
   endfor
   for line_index in range(1, len(aft_def), 1)
      call setline(line_index, aft_def[line_index-1])
   endfor
endfunction
