    org 0x7c00

    BaseOfStack       equ 0x7c00
    BaseOfLoader      equ 0x1000
    OffsetOfLoader    equ 0x00

    RootDirSectors          equ 14
    SectorNumOfRootDirStart equ 19
    SectorNumOfFAT1Start    equ 1
    SectorBalance           equ 17


jmp short Label_Start
nop


;------------- FAT12 data ---------------
BS_OEMName                  db 'YunaBoot'           ; 8 生产厂商名
BPB_BytesPerSector          dw 512                  ; 2 每个扇区字节数
BPB_SectorsPerCluster       db 1                    ; 每族（cluster）的扇区数
BPB_ResveredSectors         dw 1                    ; 文件系统保留的扇区数
BPB_NumOfFATs               db 2                    ; FAT的个数
BPB_RootDirectoryEntries    dw 224                  ; 文件系统中，根目录项个数的最大值
BPB_TotalSectors            dw 2880                 ; 磁盘的扇区数
BPB_MediaDescriptor         db 0F0H                 ; 描述存储介质类型
BPB_SectorsPerFAT           dw 9                  ; 表示文件系统中，每个 FAT 占用的扇区数，这个值的计算方法我们稍后再说；
BPB_SectorsPerTrack         dw 18                   ; 表示磁盘每个磁道的扇区数s
BPB_NumOfHeads              dw 2                    ; 磁盘的磁头个数，对于软驱来说，这个值是 2
BPB_HiddenSectors           dd 0
BPB_TotalSectors32          dd 0
BS_DrvNum                   db 0 ; Driver number of int 13H
BS_Reserved                 db 0
BS_BootSig                  db 029H
BS_VolID                    dd 0
BS_VolLabel                 db 'boot loader'
BS_FileSystem               db 'FAT12   '

;------------- End FAT12 data ---------------

Label_Start:

  mov ax, cs
  mov ds, ax
  mov es, ax

jmp $


times 510 - ($ - $$) db 0
dw 0xAA55