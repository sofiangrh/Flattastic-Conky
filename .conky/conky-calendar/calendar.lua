
--lua calendar script by mrpeachy version 3, 03/04/2011
require 'cairo'
require 'imlib2'
--------------------------------------------------------------------------------
function conky_draw_fig()
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
cr = cairo_create(cs)
local updates=tonumber(conky_parse('${updates}'))
--####################################################################################################
if updates>5 then -- starts the display
--####################################################################################################
--title text color
tred,tgreen,tblue,talpha=0.6,0.8,0.4,1
--title text font
tfont="Roboto"
--title text size
tfontsize=11
--###################################################
--main body text color
bred,bgreen,bblue,balpha=0.6,0.6,0.6,1
--main body text font
mfont="Roboto"
--main body text size
mfontsize=10
--###################################################
--highlight text color
hred,hgreen,hblue,halpha=0.6,0.6,0.6,1
--highlight font
hfont="Roboto"
--highlight size
hfontsize=10
--###################################################
--surrounding numbers 1=om, 0=off
surround=1
--surrounding dates text color
sred,sgreen,sblue,salpha=0.6,0.6,0.6,0.4
--surrounding font
sfont="Roboto"
--surounding size
sfontsize=10
--###################################################
--indicator box enter 1 for box or 0 for no box
box=1
--use the following 2 numbers to adjust box position
xadjust=-6
yadjust=-3
--set the box dimensions
width=11
height=11
--box color
xred,xgreen,xblue,xalpha=0.3,0.8,0.9,1
--###################################################
--calendar this month ###############################
--###################################################
--position
across=15
down=160
--rotate - this will require repositioning above
rotate=0
--###################################################
--horizontal gap between dates
gaph=30
--###################################################
--gap between day titles and first line
gapt=25
--###################################################
--gap between calendar line
gapl=20
--###################################################
--spacer -- this can help with alignment enter 0, 1 space or 2 spaces between the ""
spacer=""
--###################################################
--calendar calcs
year=os.date("%G")
today=tonumber(os.date("%d"))
t1 = os.time( {    year=year,month=03,day=01,hour=00,min=0,sec=0} );
t2 = os.time( {    year=year,month=02,day=01,hour=00,min=0,sec=0} );
feb=(os.difftime(t1,t2))/(24*60*60)
local monthdays={ 31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
local day=tonumber(os.date("%w"))+1
local day_num = today
local remainder=day_num % 7
start_day=day-(day_num % 7)
if start_day<0 then start_day=7+start_day end     
month=os.date("%m")
mdays=monthdays[tonumber(month)]
mdaystm=mdays
x=mdays+start_day
dnum={}
dnumh={}
if mdays+start_day<36 then 
dlen=35
plen=29 
else 
dlen=42 
plen=36
end
for i=1,dlen do
if i<=start_day then dnum[i]="  " 
else dn=i-start_day
if dn=="nil" then dn=0 end
if dn<=9 then dn=(spacer .. dn) end
if i>x then dn="" end
dnum[i]=dn
dnumh[i]=dn
if dn==(spacer .. today) or dn==today then
dnum[i]=""
end 
if dn==(spacer .. today) or dn==today then
dnumh[i]=dn
place=i 
else dnumh[i]="  " 
end 
end
end--for
--###################################################
cairo_rotate (cr,(math.pi/180)*(rotate))
--print calendar titles
--###################################################
cairo_select_font_face (cr, tfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
cairo_set_font_size (cr, tfontsize);
cairo_set_source_rgba (cr,tred,tgreen,tblue,talpha)
dys={"S","M","T","W","T","F","S"}
--------------------------------
--use these settings to mess around with positioning
turn=0
ta=0
move=0
rot=0
--------------------------------
for i=1,7 do
cairo_move_to (cr, across+(gaph*(i-1)), down+(i*move))
cairo_rotate (cr,(math.pi/180)*(rot))
cairo_show_text (cr, dys[i])
cairo_stroke (cr)
cairo_rotate (cr,(math.pi/180)*(rot*-1))
end
cairo_select_font_face (cr, mfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
cairo_set_font_size (cr, mfontsize);
cairo_set_source_rgba (cr,bred,bgreen,bblue,balpha)
for i=1,plen,7 do
fn=i
for i=fn,fn+6 do
cairo_move_to (cr, across+(gaph*(i-fn))-((((fn-1)/7)+ta)*turn), (i*move)+down+gapt+(gapl*((fn-1)/7)))
cairo_rotate (cr,(math.pi/180)*(rot))
cairo_show_text (cr, dnum[i])
cairo_stroke (cr)
cairo_rotate (cr,(math.pi/180)*(rot*-1))
end
end
cairo_select_font_face (cr, hfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
cairo_set_font_size (cr, hfontsize);
cairo_set_source_rgba (cr,hred,hgreen,hblue,halpha)
for i=1,plen,7 do
fn=i
for i=fn,fn+6 do
cairo_move_to (cr, across+(gaph*(i-fn))-((((fn-1)/7)+ta)*turn), (i*move)+down+gapt+(gapl*((fn-1)/7)))
cairo_rotate (cr,(math.pi/180)*(rot))
cairo_show_text (cr, dnumh[i])
cairo_stroke (cr)
cairo_rotate (cr,(math.pi/180)*(rot*-1))
end
end
--###############################################################################
if surround==1 then
thisstart=tonumber(start_day)+1
thisend=tonumber(start_day)+mdays
previous=tonumber(start_day)
nextmon=dlen-thisend
pmon=tonumber(month)-1
if pmon==0 then pmon=12 end
pmon=monthdays[pmon]
snum={}
for i=1,dlen do
snum[i]=""
end
for i=tonumber(thisend)+1,tonumber(thisend)+nextmon do
snum[i]=i-tonumber(thisend)
end
for i=1,previous do
snum[i]=pmon-(previous-(i))
end
cairo_select_font_face (cr, sfont, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
cairo_set_font_size (cr, sfontsize);
cairo_set_source_rgba (cr,sred,sgreen,sblue,salpha)
for i=1,plen,7 do
fn=i
for i=fn,fn+6 do
cairo_move_to (cr, across+(gaph*(i-fn))-((((fn-1)/7)+ta)*turn), (i*move)+down+gapt+(gapl*((fn-1)/7)))
cairo_rotate (cr,(math.pi/180)*(rot))
cairo_show_text (cr, snum[i])
cairo_stroke (cr)
cairo_rotate (cr,(math.pi/180)*(rot*-1))
end
end
end
--box aound
if box==1 then
cairo_set_source_rgba (cr,xred,xgreen,xblue,xalpha)
cairo_set_line_width (cr,1)
if place>0 and place<8 then
cy=down+gapt
elseif
place>7 and place<15 then
cy=down+gapt+gapl
elseif
place>13 and place<23 then
cy=down+gapt+gapl+gapl
elseif
place>21 and place<29 then
cy=down+gapt+gapl+gapl+gapl
elseif
place>28 and place<36 then
cy=down+gapt+gapl+gapl+gapl+gapl
end
placey=place %7
if placey==1 then
cx=across
elseif
placey==2 then
cx=across+(gaph*1)
elseif
placey==3 then
cx=across+(gaph*2)
elseif
placey==4 then
cx=across+(gaph*3)
elseif
placey==5 then
cx=across+(gaph*4)
elseif
placey==6 then
cx=across+(gaph*5)
elseif
placey==0 then
cx=across+(gaph*6)
end
cairo_arc (cr,cx-xadjust,cy+yadjust,width,-height, 2 * math.pi)
cairo_stroke (cr)
end
--###################################################
cairo_rotate (cr,(math.pi/180)*(rotate*-1))
--end of calendar
--###################################################
--#################################################################################
end--end if 5
end--end main function

