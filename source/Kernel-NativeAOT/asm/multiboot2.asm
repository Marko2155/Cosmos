EXTERN start
EXTERN __load_end_addr
EXTERN _initial_stack_top

ALIGN 8
section .multiboot_header

    mb_header:
        dd 0xe85250d6                              ; magic number (multiboot 2)
        dd 0                                       ; architecture 0 (protected mode i386)
        dd mb_header_end - mb_header ; header length
        ; checksum
        dd 0x100000000 - (0xe85250d6 + 0 + (mb_header_end - mb_header))

        ALIGN 8
        address_tag:
            dw 2                              ; type
            dw 0                              ; flags
            dd address_tag_end - address_tag  ; size
            dd mb_header                      ; header_addr
            dd start                          ; load_addr
            dd __load_end_addr                ; load_end_addr
            dd _initial_stack_top                      ; bss_end_addr
        address_tag_end:

        ALIGN 8
        entry_addr_tag:
            dw 3                                   ; type
            dw 0                                   ; flags
            dd entry_addr_tag_end - entry_addr_tag ; size
            dd start                               ; header_addr
        entry_addr_tag_end:

        ALIGN 8
        frame_buffer_start:
            dw 5                                     ; type
            dw 0                                     ; flags
            dd frame_buffer_end - frame_buffer_start ; size
            dd 800                                   ; x
            dd 600                                   ; y
            dd 32                                    ; bpp
        frame_buffer_end:

        ; insert optional multiboot tags here

        ALIGN 8
        mb2_header_tag_end_start: ; required end tag
            dw 0                                                    ; type
            dw 0                                                    ; flags
            dd mb2_header_tag_end_end - mb2_header_tag_end_start    ; size
        mb2_header_tag_end_end:

    mb_header_end: