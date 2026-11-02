const ENA="run file \"numfoot.prg\" func \"Enable\""
const DIS="run file \"numfoot.prg\" func \"Disable\""

; RENUMBER FOOTNOTES
FUNC f()
int i

if isglobal("_stop") then close _stop
if GetSystemMetrics("lang") then
dialog "dlog_renum" visible template "dlog ti='š…˜’„ ˜…”‘' box=110 heb \
it st=p al=r box=40 col=2 la='—„ „‚ƒ˜…š|run file \"numfoot.prg\" func 5','’†˜„|run file \"numfoot.prg\" func 3',f "+"\
it st=c,r box=60,8 la='‘”˜‰ ’˜‰š|run file \"numfoot.prg\" func \"FixChecks0\"',19 "+"\
it st=c,r col=2 box=40,8 la='˜’=’˜|run file \"numfoot.prg\" func \"FixChecks1\"',20,"+"\
'’ \"|run file \"numfoot.prg\" func \"FixChecks2\"',21,\
'€ ’ƒ š|run file \"numfoot.prg\" func \"FixChecks3\"',22,"+"\
'0001 = €\\'|run file \"numfoot.prg\" func \"FixChecks4\"',23 "+"\
it st=r,r box=90,9 la='„š€ „’˜…š Œ‘‰…‰ —‰™…˜|"+DIS+"',8,\
'‘”˜ —‰™…˜‰ ‡ƒ™ ‚ ‹|"+DIS+"',9, "+"\
'„š‡Œ -1 ‹Œ ”˜— ‚ ‹|"+ENA+"',10, \
'„š‡Œ -1 ‹Œ ’…ƒ|"+DIS+"',11, \
'‹…‹‰…š —… ‘”˜‰|"+DIS+"',12 "+"\
it ca='ƒŒ‚ € –€ €‡˜‰ „—‰™…˜:' st=c,r col=3 box=28 la='‹…‹‰š',25,'˜……‡',26,'—…ƒ',27 \
it st=c,r,d box=85 la='‘”…˜ ™‰Š Œ”‰ „ƒ‰Œ…‚',28 \
it st=r,r,d co=3 box=25,8 la='1 HC',100,'A HC',101,'B HC',102,'C HC',103, '€‡˜:',104 "+"\
it st=e,d al=a box=12,9 la='',105 it st=t,d al=a box=9 la='' \
it ca='^!^.' st=c,r box=90 la='‘”…˜ ‘‰…‰ —‰™…˜ Œƒ|run file \"numfoot.prg\" func \"FixChecks5\"',18 \
it st=r,r,d box=90,8 la='„š€ ‘‰…‰ —‰™…˜ Œ„’˜…š|"+DIS+"',13, \
'‘”˜ —‰™…˜‰ -1 ‹Œ ”˜—|"+ENA+"',14 \
it ca='^!^.' st=e fi=admps col=2 bo=20,10 la='‰‡…‘',6,'„š‡Œ -',7 "+"\
it st=c,r box=70 la='„š‡Œ š‡‰Œš „—…•',29 \
it st=p bo=35 co=2 la='€‰™…˜|run file \"numfoot.prg\" func 1',1, \
'–€|run file \"numfoot.prg\" func 2',2 \
it st=e,d bo=30,10 la='„š—ƒ…š',5 al=c"
else
dialog "dlog_renum" visible template "dlog ti='Number footnotes' \
it st=p al=L box=40 col=2 la='Clear options|run file \"numfoot.prg\" func 5','Help|run file \"numfoot.prg\" func 4',f \
it st=c bo=60,8 la='Numbers in Hebrew|run file \"numfoot.prg\" func \"FixChecks0\"',19 "+"\
it st=c col=2 bo=40,8 la='’˜=˜’|run file \"numfoot.prg\" func \"FixChecks1\"',20,"+"\
'with \"|run file \"numfoot.prg\" func \"FixChecks2\"',21,\
'€ to š|run file \"numfoot.prg\" func \"FixChecks3\"',22, "+"\
'1000 = \\'€|run file \"numfoot.prg\" func \"FixChecks4\"',23 "+"\
it st=r,m box=85,9 la='Match footnotes to markers|"+DIS+"',8,'Also renumber markers|"+DIS+"',9, "+"\
'Also start from 1 every chapter|"+ENA+"',10,\
'Start from 1 each page|"+DIS+"',11, \
'Asterisks instead of numbers|"+DIS+"',12 \
it ca='Skip if after link there is:' st=c col=3 box=28 la='Asterisk',25,'Space',26,'Code',27 "+"\
it st=c,d box=90 la='Cont. numbering from before skip',28 \
it st=r,d co=3 box=25,8 la='CH 1',100,'CH A',101,'CH B',102,'CH C',103,'Other:',104 "+"\
it st=e,d al=a box=12,9 la='',105 it st=t,d al=a box=9 la='' \
it ca='^!^.' st=c box=90 la='Just renumber markers|run file \"numfoot.prg\" func \"FixChecks5\"',18 \
it st=r,d box=90,8 la='Match markers to footnotes|"+DIS+"', 13, \
'Markers from 1 every chapter|"+ENA+"',14 \
it ca='^!^.' st=e fi=admps col=2 bo=25,10 la='Reference',6,'Start from:',7 "+"\
it st=c box=70 la='Start from beginning of file',29 \
it st=p bo=35 co=2 la='OK|run file \"numfoot.prg\" func 1',1, \
'Exit|run file \"numfoot.prg\" func 2',2 \
it st=e,d bo=25,10 la='Progress',5 al=c"
end if
for i:=25 to 27 do SetDlgScript(dlog_renum, i, "run file \"numfoot.prg\" func \"FixContNumbering\"")
if isglobal("numfoot_sav") then
	for i:=7 to 12 do SetCheck(dlog_renum, i+11, numfoot_sav[i]="1")
	for i:=13 to 16 do SetCheck(dlog_renum, i+12, numfoot_sav[i]="1")
	if GetCheck(dlog_renum, 18) then
		FixChecks5()
		for i:=5 to 6 do if numfoot_sav[i]="1" then SetCheck(dlog_renum, i+8)
		if GetCheck(dlog_renum, 14) then
			Enable()
			for i:=17 to 21 do if numfoot_sav[i]="1" then SetCheck(dlog_renum, i+83)
			SetDlgText(dlog_renum, 105, numfoot_sav[22])
		end if
	else
		for i:=0 to 4 do if numfoot_sav[i]="1" then SetCheck(dlog_renum, i+8)
		if GetCheck(dlog_renum, 10) then
			Enable()
			for i:=17 to 21 do if numfoot_sav[i]="1" then SetCheck(dlog_renum, i+83)
			SetDlgText(dlog_renum, 105, numfoot_sav[22])
		else
			Disable()
		end if
	end if
	SetDlgText(dlog_renum, 6, numfoot_sav[23])
	SetCheck(dlog_renum, 29, numfoot_sav[24]="1")
end if
FixChecks0()
END FUNC

FUNC go() ; func 1
boolean hebrew, renum, from1, link_from1, first, each_page, asterisks, match_links, \
	quotes, ad_tav, hebMenus, OnlyNumberLinks, skip_asterisk, skip_space, skip_code, \
	from_before_skip, select_all
int i, k, m, n, pos, pos0, endpos, diff, count, table, prev_pos, first_index, mask, \
	modulus, maxIndex, chptr, n_skipped
select sel, found
string s, t
pointer p

hebMenus := GetSystemMetrics("lang")
if not (p := addr activetext()) then
    if hebMenus then
        msg heb "€‰ ˆ—‘ˆ ”’‰Œ"
    else
        msg "No active text."
    end if
	return
end if
global string "numfoot_sav" dim 25
for i:=0 to 6 do numfoot_sav[i] := GetCheck(dlog_renum, i+8)
for i:=7 to 12 do numfoot_sav[i] := GetCheck(dlog_renum, i+11)
for i:=13 to 16 do numfoot_sav[i] := GetCheck(dlog_renum, i+12)
for i:=17 to 21 do numfoot_sav[i] := GetCheck(dlog_renum, i+83)
numfoot_sav[22] := GetDlgText(dlog_renum, 105)
numfoot_sav[23] := GetDlgText(dlog_renum, 6)
numfoot_sav[24] := select_all := GetCheck(dlog_renum, 29)
hebrew := GetCheck(dlog_renum, 19)
mask := 2*GetCheck(dlog_renum, 20) + 1 ;mask for lashon naki, 1000='€
if not GetCheck(dlog_renum, 23) then mask += 8
quotes := GetCheck(dlog_renum, 21)
ad_tav := GetCheck(dlog_renum, 22)
table := GetDlgText(dlog_renum, 6)
modulus := GetNoteModulus(table, p^)
first_index := GetDlgText(dlog_renum, 7)
if first_index > 0 then
	first_index *= modulus
else
	first_index := 0 ; not used
end if
OnlyNumberLinks := GetCheck(dlog_renum, 18)
renum := GetCheck(dlog_renum, 9) and not OnlyNumberLinks
from1 := GetCheck(dlog_renum, 10) and not OnlyNumberLinks
link_from1 := GetCheck(dlog_renum, 14) and OnlyNumberLinks
each_page := GetCheck(dlog_renum, 11)
asterisks := GetCheck(dlog_renum, 12)
if asterisks then each_page := true
match_links := GetCheck(dlog_renum, 13) and OnlyNumberLinks
skip_asterisk := GetCheck(dlog_renum, 25) and not match_links
skip_space := GetCheck(dlog_renum, 26) and not match_links
skip_code := GetCheck(dlog_renum, 27) and not match_links
from_before_skip := GetCheck(dlog_renum, 28) and (renum or from1 or each_page)
if select_all then ; select all
	sel := p^
else
	sel := getsel()
end if
pos := start sel, endpos := end sel
if pos = endpos then endpos := len(p^)
global boolean "_stop"
SetDlgText(dlog_renum, 5, "")
if renum or from1 or link_from1 then
	pos0 := pos, first := true
	SetDlgText(dlog_renum, 5, "...š„")
loop:
	if not isglobal("dlog_renum") then goto finished
	if _stop then
		SetDlgText(dlog_renum, 5, "")
		goto finished
	end if
	sel := range(pos0, endpos, p^)
	if from1 or link_from1 then
		if GetCheck(dlog_renum, 100) then chptr:=0
		if GetCheck(dlog_renum, 101) then chptr:=65
		if GetCheck(dlog_renum, 102) then chptr:=66
		if GetCheck(dlog_renum, 103) then chptr:=67
		if GetCheck(dlog_renum, 104) then
			found := find("<<~ >>", "*", s:=GetDlgText(dlog_renum, 105))
			if found then chptr:=asc(s:=found^) else chptr := -1
		end if
        while found := FindTag("ch", -1, chptr, range(pos0, endpos, p^)) do
            if GetProp("active", found) then
                sel := range(start sel, end found, p^)
                break
            end if
            pos0 := end found
        end while
	end if
	n := modulus
	if first then
		if first_index > 0 then
			n := first_index
		else
			if found := FindTag("no", -1, table, sel) then n := GetTagIndex(found)
		end if
		first := false
	end if
	ReplaceTag("no", 65536*table+n, modulus, 3, sel)
	if from1 or link_from1 then
		pos0 := end sel
		if pos0 < endpos then goto loop
	end if
end if
if each_page then pos := toppage(pos, p^)
count := 0
if not isglobal("dlog_renum") then goto finished
SetDlgText(dlog_renum, 5, "")
if link_from1 then goto finished
prev_pos := n := 0; for "each_page"
if match_links then maxIndex := 65536 div modulus
n_skipped := 0
setsel(1,0,p^)
while found := findtag("no", -1, table, range(pos, endpos, p^)) do
	if _stop then break
	pos := start found
	if each_page then
		if TopPage(pos, p^) = TopPage(prev_pos, p^) then n += 1 else n := 1
		prev_pos := pos
	else
		n := GetTagIndex(found) div modulus
	end if
	if n=1 then n_skipped := 0
	pos += 1
	if skip_code then if FindTag("code", -1, -1, range(pos, pos+1, p^)) then
		if from_before_skip then n_skipped += 1
		goto next
	end if
	if skip_space then
		if pos=(end p^) then goto next
		if find("[ \r\x0c]", "*", range(pos, pos+1, p^)) then
			if from_before_skip then n_skipped += 1
			goto next
		end if
	end if
	found := find("[€-ša-z0-9*]<'\"€-ša-z0-9*>", "t*", range(pos, pos+11, p^))
	if found then ; check for space between link and number -- probably an error
		if find("[ \r\x0c]", "*", range(pos, start found, p^)) then
			if skip_space then
				if from_before_skip then n_skipped += 1
				goto next
			end if
			found := range(1,0,p^)
		else
			if skip_asterisk then if find("*", 0, found) then
				if from_before_skip then n_skipped += 1
				goto next
			end if
		end if
	end if
	if not found then
		s := n
        if hebMenus then
            reverse s
            msg heb "Œ€ …–€ ‘”˜ ™Œ „’˜„ " + s
        else
            msg "Cannot find number of footnote " + s
        end if
		setsel(pos, pos, p^)
		show p^ position pos
		close _stop
		return
	end if
	i := len(found)
	if (s := tail(i-1, found)) = "\"" then found := range(0, i-1, found)
	if match_links then
		n := asc(s := found)
		if n >= 48 and n <= 57 then
			if GetAttr("lang", found) then reverse s
			n := s
		else
			n := gematria(s)
		end if
		if n <= 0 or n >= maxIndex then continue
		insert TAG "note" INDEX modulus*n TABLE table range(pos-1,pos,p^)
		goto next
	end if
	if asterisks then
		k := n - n_skipped
		s := "*"
		for i:=2 to k do s += "*"
	else
		if hebrew then
			if ad_tav then
				m := (n-n_skipped-1) mod 22
				if m < 0 then
					s := "0"
				else
					s := "€‚ƒ„…†‡ˆ‰‹Œ‘’”–—˜™š"
					s := chr(asc(range(m,m+1,s)) + 96)
				end if
			else
				s := NumToHeb(n-n_skipped, mask)
				k := len(s)
				if k then if quotes then if k>1 then \
					s:=(t:=range(0,k-1,s)) + "\"" + (t:=tail(k-1,s)) else s += "'"
			end if
		else
			if ad_tav then ; a - z
				m := (n-n_skipped-1) mod 26
				if m < 0 then
					s := "0"
				else
					s := chr(m + 97)
				end if
			else
				s := n - n_skipped
			end if
			if GetAttr("lang", found) then reverse s
		end if
	end if
	if not s then s := "0"
	diff := len(s) - len(found)
	endpos += diff
	found^ := s
next:
	count += 1
    s := count
    if count <> n then s += " (" + (t:=n) + ")"
	if not isglobal("dlog_renum") then break
    SetDlgText(dlog_renum, 5, s)
end while

finished:
setsel(getsel(p^))
close _stop
END FUNC

FUNC bitul() ; func 2
if isglobal("_stop") then _stop:=1 else close dlog_renum
END FUNC

FUNC helpH() ; func 3
dialog "_dhelp" template "dlog heb ti='š…˜’„ ˜…”‘ --- „˜†’' tab=3 bo=180 cl=2 \
it st=p ca='^V^Rš…‹‰š †… ‰‹…Œ„ Œ’™…š 3 ƒ˜‰:\R"+"\
^!1.^!^&Œ‘”˜ ‡ƒ™ ‘”˜‰ „–€‰ ˆ—‘ˆ, ‘…‹‰ Œ‘‰…‰ —‰™…˜ )†.€. €‡˜‰ „—‰™…˜(, \
€…” ™„‘”˜ ‰…š€ Œ‘”˜ „…”‰’ š…Š „—‰™…˜.\R"+"\
^!2.^!^&…‘“ Œ‘”…˜ ™Œ ‘”˜‰ ‘…‹‰ Œ—‰™…˜‰, Œ‘”˜ ‚ €š „—‰™…˜‰ ’–.\R\
^!3.^!^&Œ‘”˜ €š „—‰™…˜‰ Œƒ, Œˆ˜…š ‘…‰‰…š.\R"+"\
„‘”…˜ ‡Œ ’Œ „š‡… „‡˜ ˆ—‘ˆ, €… „‘ ’ƒ ‘…“ „—…•.\R\R"+"\
^!‘”˜‰ ’˜‰š^!. ™‰‰Š Œ€˜’ €”™˜…‰…š \\'„š€ „’˜…š...\\' ’ƒ \\'„š‡Œ -1 ‹Œ ’…ƒ\\'. \
€ ™–š †… ‘…š, „‘”˜‰ ‰„‰… ‹”‰ ‘”…˜ „’˜‰.\R\
^&^_˜’=’˜^_^&^&Œ™… —‰‰„. Œƒ…‚„, 072 ‰„‰„ ^_’˜\^_\R"+"\
^&^_’ \\'\\'^_^&^&‹‰‘ ‚˜™ €… ‚˜™‰‰. Œƒ…‚„:  ‚\\',   ˆ\\'\\'†\R\
^&^_c ,b ,a^&^_^&1 ‰„‰„  a,  2 ‰„‰„  b, …™… 72 ‰„‰„  a\R"+"\
^&^_€ ’ƒ š^&^_^&11 ‰„‰„ ^_‹^_,  21 ‰„‰„ ^_Œ^_ ...\R"+"\
^&^_0001 = €\\'^&^_€Œ“ Œ€ ‰„‰„ ^_šš˜^_, €Œ€ ^_€\\'^_\R\
^!„š€ „’˜…š Œ‘‰…‰ —‰™…˜^!. „‘”˜‰ „‘…‹‰ Œ‘‰…‰ —‰™…˜ ‰…‡Œ”… ‹”‰ „‘”˜ „…”‰’ š…Š „—‰™…˜. \
„—‰™…˜‰ ’– ‰‰™€˜… ‹”‰ ™„‰….\R"+"\
^!‘”˜ —‰™…˜‰ ‡ƒ™ ‚ ‹^!. „š…‹‰š š‘”˜ €š „—‰™…˜‰ Œ”‰ ‘ƒ˜ ’…Œ„, …„‘”˜ „…‹‡‰ š…Š „—‰™…˜ „˜€™… "+"\
š‡… „‡˜ ‰—’ €š š‡‰Œš „‘‰ƒ˜„. )‹ƒ‰ Œ€Œ• €š „‘”…˜ Œ„š‡‰Œ ‘”˜ ™…„ „—‰™…˜ „˜€™…, „™š™ ™ƒ„ \
^_„š‡Œ -^_.( „‘”˜‰ „‘…‹‰ Œ—‰™…˜‰ ‰…š€… Œ‘”˜ €™˜ š…Š „—‰™…˜.\R"+"\
^!„š‡Œ -1 ‹Œ ”˜— ‚ ‹^!. „š…‹‰š š‘”˜ €š „—‰™…˜‰ …‚ €š „‘”˜‰ „‘…‹‰ Œ„, …€‡˜‰ ‹Œ ‘‰… ”˜—, "+"\
„‘”…˜ ‰š‡‰Œ ™… -1. €”™˜ Œ‡…˜ €š ‘…‚ ‘‰… „”˜— ™‰‚˜… Œ‹Š.\R"+"\
^!„š‡Œ -1 ‹Œ ’…ƒ^!. €”™˜…š †… ™‰…™‰š ˜— Œ€‡˜ ‡Œ…—š „ˆ—‘ˆ Œ’…ƒ‰. „š…‹‰š š‘”˜ €š „‘”˜‰ „‘…‹‰ \
Œ—‰™…˜‰, €Œ „—‰™…˜‰ ’– ‰‰™€˜… ‹”‰ ™„‰….\R"+"\
^!‹…‹‰…š —… ‘”˜‰^!. €”™˜…š †… ™‰…™‰š ˜— Œ€‡˜ ‡Œ…—š „ˆ—‘ˆ Œ’…ƒ‰. „š…‹‰š š‡Œ‰“ €š „‘”˜ „˜€™… ’…ƒ \
„‘…Š Œ—‰™…˜ ‹…‹‰š )*( €‡š, „‘”˜ „™‰ ™š‰ ‹…‹‰…š, …‹…\\'. „—‰™…˜‰ ’– ‰‰™€˜… ‹”‰ ™„‰…."+"\R\
^!ƒŒ‚ € –€ €‡˜‰ „—‰™…˜:^! \R\
^_‹…‹‰š^_.  „š…‹‰š Œ€ š‡Œ‰“ €š „‹…‹‰š ‘”˜. ‚ Œ€ š‡Œ‰“ –‰˜…“ ‘”˜ …‹…‹‰š, ‹… 2* €… *.\R"+"\
^_˜……‡^_.  Œ€ š„‰„ „…ƒ’„ ™Œ€ –€ ‘”˜ „’˜„.\R"+"\
^_—…ƒ^_.  € ‰™ —…ƒ ‹Œ™„… ‰ƒ €‡˜‰ „—‰™…˜, „š…‹‰š Œ€ š™„ €š ‘”˜ „„’˜„.\R\
^_‘”…˜ ™‰Š Œ”‰ „ƒ‰Œ…‚^_.  ‘”˜ „„’˜„ „€ €‡˜‰ ƒ‰Œ…‚ ‰„‰„ €‡ƒ ‰…š˜ „‘”˜ €™˜ Œ”‰ „ƒ‰Œ…‚. "+"\
€”™˜…š †… Œ€ ’…ƒš € ‘… \\'\\'„š€ „’˜…š Œ‘‰…‰ —‰™…˜\\'\\'.\R"+"\
^!‰‡…‘^!. €‰ –…˜Š ŒŒ€…š €š „™ƒ„ „†€š €€\"‹ ‘‰…‰ „—‰™…˜ ‹‰Œ‰ ™‰ ‘”˜‰: \
„™€Œ‰ š‰‡‘ Œˆ—‘ˆ ‘…‰‰, …„‰‰ „…€ ‘”˜ „„’˜„.\R"+"\
^!„š‡Œ -^!. ™‰‰Š Œ€”™˜…‰…š \\'\\'‘”˜ —‰™…˜‰ ‡ƒ™ ‚ ‹\\'\\', \\'\\'„š‡Œ -1 ‹Œ ”˜— ‚ ‹\\'\\', \
\\'\\'‘”˜ —‰™…˜‰ -1 ‹Œ ”˜—\\'\\'' \
bo=0,0 la='|run file \"numfoot.prg\" func \"CloseHelp\"',f,2 "
SideBySide(dlog_renum, _dhelp)
END FUNC

FUNC helpE() ; func 4
dialog "_dhelp" visible template "dlog ti='Help for Number footnotes' bo=180 tab=3 cl=1 \
it st=p ca='^V^LThis program can do 3 things:\R\
^!1.^!^&Renumber numbers which are in the text, adjacent to link markers (i.e. after the link), "+"\
so that the number will match the one appearing inside the link.\R"+"\
^!2.^!^&In addition to renumbering the numbers adjacent to the link markers, also renumber the links themselves.\R\
^!3.^!^&Only renumber the link markers, for certain objectives.\R"+"\
The renumbering applies to the selected region, or from the cursor to the end of the file.\R\R"+"\
^!Numbers in Hebrew^!. Pertains to the four options \\'Match footnotes...\\' to \\'Start from 1 each page\\'. \
If this box is checked, the numbers will be according to Hebrew numeration.\R"+"\
^&^_’˜=˜’^_^&^&Euphemistic, e.g., 720 will be ^_˜’^_\R"+"\
^&^_with \\'\\'^_^&^&Insert quote or double quotes. E.g.:  \\'‚,   †\\'\\'ˆ\R\
^&^_a, b, c^&^_^&1 will be ^_a^_, 2 will be ^_b^_, and 27 will again be ^_a^_\R"+"\
^&^_€ to š^&^_^&11 will be ^_‹^_,  12 will be ^_Œ^_ ...\R"+"\
^&^_1000 = \\'€^&^_A thousand will not be ^_˜šš^_ but rather  ^_\\'€^_\R\
^!Match footnotes to markers^!. The numbers adjacent to link markers will be replaced according to the "+"\
number which appears inside the marker. The markers themselves remain unchanged.\R"+"\
^!Also renumber markers^!. The program will number the link markers in increasing order, and the current \
number in the first link in the selected region will determine the start of the sequence. "+"\
(In order to force the numbering to start from a number other than the first link marker, use the field \
^_Start from^_.) The numbers adjacent to link markers will be made to match the number inside the marker.\R"+"\
^!Also start from 1 every chapter^!. The program will renumber the link markers and also the numbers adjacent "+"\
to them, and after each chapter marker, the numbering will start again from 1. It is possible to choose the type \
of chapter marker which will effect this.\R"+"\
^!Start from 1 each page^!. This option can be used only after the text has been paginated. \
The program will renumber the numbers adjacent to link markers, but the markers themselves remain unchanged.\R"+"\
^!Asterisks instead of numbers^!. This option can be used only after the text has been paginated. \
The first number on the page (adjacent to a link marker) will be replaced with one asterisk (*), the second number "+"\
by two asterisks, etc. The markers themselves remain unchanged."+"\R\
^!Skip if after link there is:^! \R\
^_Asterisk^_.  The program won\\'t replace the asterisk with a number. It also won\\'t replace a combination "+"\
of number and asterisk, like 2*.\R"+"\
^_Space^_.  There won\\'t be a message that a footnote number was not found.\R"+"\
^_Code^_.  If there is any code after the link marker, the program won\\'t change the footnote number.\R\
^_Cont. numbering from before skip^_.  The next footnote number after a skip will be one more than the number "+"\
before the skip. This option doesn\\'t work with the choice \\'\\'Match footnotes to markers\\'\\'.\R"+"\
^!Reference^!. There is no need to fill in this field unless the links contain two numbers: \
the left one refers to a certain text, and the right one is the number of the footnote.\R"+"\
^!Start from^!. Pertains to the options \\'\\'Also renumber markers\\'\\',\R\\'\\'Also start from 1 every chapter\\'\\', \
\\'\\'Markers from 1 every chapter\\'\\'' \
bo=0,0 la='|run file \"numfoot.prg\" func \"CloseHelp\"',f,2 "
SideBySide(dlog_renum, _dhelp)
END FUNC

FUNC Clear() ; func 5
int i

SetCheck(dlog_renum, 18, 0)
FixChecks5()
if not GetCheck(dlog_renum, 100) then
	SetCheck(dlog_renum, 10)
	Enable()
	SetCheck(dlog_renum, 100)
end if
for i:=19 to 23 do SetCheck(dlog_renum, i, 0)
SetCheck(dlog_renum, 29, 0)
SetCheck(dlog_renum, 8)
Disable()
for i:=25 to 28 do SetCheck(dlog_renum, i, 0)
SetDlgText(dlog_renum, 105, "")
SetDlgText(dlog_renum, 6, "")
SetDlgText(dlog_renum, 7, "")
END FUNC

FUNC CloseHelp()
close _dhelp
if isglobal("dlog_renum") then show dlog_renum
END FUNC

FUNC gematria(s)
int total, L, i, c
string t, g
select found

g := "\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xeb\xec\xee\xf0\xf1\xf2\xf4\xf6\xf7\xf8\xf9\xfa"
total := 0
L := len(s) - 1
for i:=0 to L do
	t := range(i, i+1, s)
	found := find(t, 0, g)
	if not found then
		if t="'" then if i<L then total *= 1000
		continue
	end if
	c := end found
	if c <= 10 then
		total += c
		continue
	end if
	if c <= 19 then
		total += 10*(c - 9)
		continue
	end if
	total += 100*(c - 18)
end for
return total
END FUNC

FUNC FixChecks0()
if GetCheck(dlog_renum, 19) then
	if GetSystemMetrics("lang") then SetDlgText(dlog_renum, 22, "š ƒ’ €") else \
		SetDlgText(dlog_renum, 22, "€ to š")
else
	SetDlgText(dlog_renum, 22, "a, b, c . . .")
	SetCheck(dlog_renum, 20, 0)
	SetCheck(dlog_renum, 21, 0)
;	SetCheck(dlog_renum, 22, 0)
	SetCheck(dlog_renum, 23, 0)
end if
END FUNC

FUNC FixChecks1()
if GetCheck(dlog_renum, 20) then SetCheck(dlog_renum, 22, 0)
END FUNC

FUNC FixChecks2()
if GetCheck(dlog_renum, 21) then
	SetCheck(dlog_renum, 22, 0)
	SetCheck(dlog_renum, 23, 0)
end if
END FUNC

FUNC FixChecks3()
if GetCheck(dlog_renum, 22) then
	SetCheck(dlog_renum, 20, 0)
	SetCheck(dlog_renum, 21, 0)
	SetCheck(dlog_renum, 23, 0)
end if
END FUNC

FUNC FixChecks4()
if GetCheck(dlog_renum, 23) then
	SetCheck(dlog_renum, 21, 0)
	SetCheck(dlog_renum, 22, 0)
end if
END FUNC

FUNC FixChecks5()
int i, k

k := GetCheck(dlog_renum, 18)
if k then
	if GetCheck(dlog_renum, 13) then Disable() else Enable()
else
	if GetCheck(dlog_renum, 10) then Enable() else Disable()
end if
for i:=13 to 14 do DlgEnable(dlog_renum, i, k)
k := not k
for i:=8 to 12 do DlgEnable(dlog_renum, i, k)
for i:=19 to 23 do DlgEnable(dlog_renum, i, k)
for i:=25 to 27 do DlgEnable(dlog_renum, i, k)
END FUNC

FUNC Enable()
DlgEnable(dlog_renum,100,1),DlgEnable(dlog_renum,101,1),DlgEnable(dlog_renum,102,1)
DlgEnable(dlog_renum,103,1),DlgEnable(dlog_renum,104,1),DlgEnable(dlog_renum,105,1)
FixContNumbering()
END FUNC

FUNC Disable()
DlgEnable(dlog_renum,100,0),DlgEnable(dlog_renum,101,0),DlgEnable(dlog_renum,102,0)
DlgEnable(dlog_renum,103,0),DlgEnable(dlog_renum,104,0),DlgEnable(dlog_renum,105,0)
FixContNumbering()
END FUNC

FUNC SideBySide(a, b)
int aLeft, aTop, aWidth, bLeft, bTop, bWidth, x2

GetWindowPos(a, aLeft, aTop, aWidth)
x2 := GetSystemMetrics("xMDI")/2
if (aLeft+aWidth/2) < x2 then
	show b at -6
	GetWindowPos(b, bLeft, bTop, bWidth)
	show b at aLeft+aWidth,aTop
else
	show b at -4
	GetWindowPos(b, bLeft, bTop, bWidth)
	show b at aLeft-bWidth,aTop
end if
END FUNC

FUNC FixContNumbering()
int i
DlgEnable(dlog_renum, 28, 0)
if GetCheck(dlog_renum, 18) then return
if GetCheck(dlog_renum, 8) then return
for i:=25 to 27 do if GetCheck(dlog_renum, i) then break
DlgEnable(dlog_renum, 28, i<=27)
END FUNC
