/* _start is the default linker entry point symbol name.
 * If not present, the linker will complain when generating the elf file.
 * This could be configured from the linker script.
 */
.global _start
_start:
    /* Set stack at 0x8000, just before where the code will be placed.
     * This prevents conflicts, since the stack grows down.
     *
     * If we could move this to the C code, possibly as inline assembly,
     * and get rid of this file, that would be great.
     *
     * But I haven't found a way to get rid of function prologues on GCC,
     * which would set the sack on the function prologue before we can touch it.
     */
    mov sp, #0x8000
    bl main
    /* Go into an infinite loop in case main returns. */
hang:
    b hang
