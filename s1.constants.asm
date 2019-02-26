; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equates section - Names for variables.

; ---------------------------------------------------------------------------
; size variables - you'll get an informational error if you need to change these...
; they are all in units of bytes
Size_of_SEGA_sound =		$6978
Size_of_Snd_driver_guess =	$1760 ; approximate post-compressed size of the Z80 DAC driver

; ---------------------------------------------------------------------------
; Object Status Table offsets (for everything between Object_RAM and Primary_Collision)
; ---------------------------------------------------------------------------
; universally followed object conventions:
x_pos =			  8 ; and 9 ... some objects use $A and $B as well when extra precision is required (see ObjectMove) ... for screen-space objects this is called x_pixel instead
x_sub =			 $A ; and $B
y_pos =			 $C ; and $D ... some objects use $E and $F as well when extra precision is required ... screen-space objects use y_pixel instead
y_sub =			 $E ; and $F
priority =		$18 ; 0 = front
width_pixels =		$19
mapping_frame =		$1A
; ---------------------------------------------------------------------------
; conventions followed by most objects:
x_vel =			$10 ; and $11 ; horizontal velocity
y_vel =			$12 ; and $13 ; vertical velocity
y_radius =		$16 ; collision height / 2
x_radius =		$17 ; collision width / 2
anim_frame =		$1B
anim =			$1C
next_anim =		$1D
anim_frame_duration =	$1E
anim_delay =		$1F ; why?
status =		$22 ; note: exact meaning depends on the object... for sonic: bit 0: leftfacing. bit 1: inair. bit 2: spinning. bit 3: onobject. bit 4: rolljumping. bit 5: pushing. bit 6: underwater.
routine =		$24
routine_secondary =	$25
angle =			$26 ; angle about the z axis (360 degrees = 256)
; ---------------------------------------------------------------------------
; conventions followed by many objects but NOT sonic:
collision_flags =	$20
collision_property =	$21
respawn_index =		$23
subtype =		$28
; ---------------------------------------------------------------------------
; conventions specific to some objects
inertia =		$14 ; and $15 ; directionless representation of speed... not updated in the air
next_tile =		$20 ; and $21 and $22 and $23 ; used for Sonic's art buffer
; ---------------------------------------------------------------------------
; I run the main 68k RAM addresses through this function
; to let them work in both 16-bit and 32-bit addressing modes.
ramaddr function x,-(-x)&$FFFFFFFF

; ---------------------------------------------------------------------------
; RAM variables
RAM_Start =			ramaddr( $FFFF0000 ) ; 4 bytes ; start of RAM
Chunk_Table =			ramaddr( $FFFF0000 ) ; $A3FF bytes

Decomp_Buffer =			ramaddr( $FFFFAA00 ) ; $200 bytes

Game_Mode =			ramaddr( $FFFFF600 ) ; 1 byte ; see GameModesArray (master level trigger, Mstr_Lvl_Trigger)
Ctrl_1_Logical =		ramaddr( $FFFFF602 ) ; 2 bytes
Ctrl_1_Held_Logical =		ramaddr( $FFFFF602 ) ; 1 byte
Ctrl_1_Press_Logical =		ramaddr( $FFFFF603 ) ; 1 byte
Ctrl_1 =			ramaddr( $FFFFF604 ) ; 2 bytes
Ctrl_1_Press =			ramaddr( $FFFFF605 ) ; 1 byte
Demo_Time_left =		ramaddr( $FFFFF614 ) ; 2 bytes

DMA_data_thunk =		ramaddr( $FFFFF640 ) ; Used as a RAM holder for the final DMA command word. Data will NOT be preserved across V-INTs, so consider this space reserved.

Plc_Buffer =			ramaddr( $FFFFF680 )
Plc_Buffer_Reg0 =		ramaddr( $FFFFF6E0 )
Plc_Buffer_Reg4 =		ramaddr( $FFFFF6E4 )
Plc_Buffer_Reg8 =		ramaddr( $FFFFF6E8 )
Plc_Buffer_RegC =		ramaddr( $FFFFF6EC )
Plc_Buffer_Reg10 =		ramaddr( $FFFFF6F0 )
Plc_Buffer_Reg14 =		ramaddr( $FFFFF6F4 )
Plc_Buffer_Reg18 =		ramaddr( $FFFFF6F8 )
Plc_Buffer_Reg1A =		ramaddr( $FFFFF6FA )

Camera_RAM =			ramaddr( $FFFFF700 )
Camera_X_pos =			ramaddr( $FFFFF700 )
Camera_Y_pos =			ramaddr( $FFFFF704 )

Sonic_top_speed =		ramaddr( $FFFFF760 )
Sonic_acceleration =		ramaddr( $FFFFF762 )
Sonic_deceleration =		ramaddr( $FFFFF764 )

Obj_placement_routine =		ramaddr( $FFFFF76C )

Camera_X_pos_last =		ramaddr( $FFFFF76E )

Obj_load_addr_right =		ramaddr( $FFFFF770 )	; contains the address of the next object to load when moving right
Obj_load_addr_left =		ramaddr( $FFFFF774 )	; contains the address of the next object to load when moving left
Obj_load_addr_3 =		ramaddr( $FFFFF778 )
Obj_load_addr_4 =		ramaddr( $FFFFF77C )

Camera_X_pos_coarse =		ramaddr( $FFFFF7DA )

Object_Respawn_Table =		ramaddr( $FFFFFC00 )
Obj_respawn_index =		ramaddr( $FFFFFC00 ) ; respawn table indices of the next objects when moving left or right for the first player

Graphics_Flags =		ramaddr( $FFFFFFF8 ) ; misc. bitfield
Debug_mode_flag =		ramaddr( $FFFFFFFA ) ; (2 bytes)
Checksum_fourcc =		ramaddr( $FFFFFFFC ) ; (4 bytes)
; ---------------------------------------------------------------------------
; VDP addressses
VDP_data_port =			$C00000 ; (8=r/w, 16=r/w)
VDP_control_port =		$C00004 ; (8=r/w, 16=r/w)

; ---------------------------------------------------------------------------
; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_End =			$A02000 ; end of non-reserved Z80 RAM
Z80_Version =			$A10001
Z80_Port_1_Data =		$A10002
Z80_Port_1_Control =		$A10008
Z80_Port_2_Control =		$A1000A
Z80_Expansion_Control =		$A1000C
Z80_Bus_Request =		$A11100
Z80_Reset =			$A11200

Security_Addr =			$A14000