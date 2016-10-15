/* _start is the default linker entry point symbol name.
 * If not present, the linker will complain when generating the elf file.
 * This could be configured from the linker script.
 */
.global _start
_start:
    /* Set stack at 0x8000, just before where the code will be placed.
     * This prevents conflicts, since the stack grows down.
     */
    mov sp, #0x8000
    bl main
    /* Go into an infinite loop in case main returns. */
hang:
    b hang
