#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

// Simplified PCB structure (what OS actually maintains)
struct PCB {
    // PROCESS IDENTIFICATION
    pid_t process_id;           // Unique process ID
    pid_t parent_id;            // Parent process ID
    char process_name[256];     // Program name

    // PROCESS STATE
    enum process_state {
        NEW,
        READY,
        RUNNING,
        WAITING,
        TERMINATED
    } state;

    // CPU REGISTERS (saved during context switch)
    struct cpu_registers {
        unsigned long pc;       // Program Counter
        unsigned long sp;       // Stack Pointer
        unsigned long registers[16]; // General purpose registers
        unsigned long flags;    // Status flags
    } cpu_context;

    // MEMORY MANAGEMENT
    struct memory_info {
        void* code_segment;     // Where program code is loaded
        void* data_segment;     // Where global variables are
        void* heap_start;       // Dynamic memory start
        void* stack_start;      // Stack memory start
        size_t memory_size;     // Total memory used
    } memory;

    // SCHEDULING INFORMATION
    int priority;               // Process priority
    int cpu_time_used;         // How much CPU time consumed
    int time_slice_remaining;  // Time left in current slice

    // I/O AND FILES
    struct file_descriptor_table {
        int stdin_fd;           // Standard input
        int stdout_fd;          // Standard output
        int stderr_fd;          // Standard error
        int open_files[64];     // Other open files
    } files;

    // PROCESS RELATIONSHIPS
    struct PCB* parent;         // Pointer to parent PCB
    struct PCB* children[32];   // Pointers to children PCBs
    int num_children;

    // SYNCHRONIZATION
    int waiting_for_resource;   // What resource process waits for
    struct PCB* next_in_queue;  // For ready queue, wait queue, etc.
};

// Function to display PCB information
void display_pcb_info(struct PCB* pcb) {
    printf("=== PROCESS CONTROL BLOCK INFO ===\n\n");

    printf("IDENTIFICATION:\n");
    printf("  Process ID (PID): %d\n", pcb->process_id);
    printf("  Parent ID (PPID): %d\n", pcb->parent_id);
    printf("  Process Name: %s\n", pcb->process_name);

    printf("\nSTATE:\n");
    char* state_names[] = {"NEW", "READY", "RUNNING", "WAITING", "TERMINATED"};
    printf("  Current State: %s\n", state_names[pcb->state]);

    printf("\nCPU CONTEXT:\n");
    printf("  Program Counter: 0x%lx\n", pcb->cpu_context.pc);
    printf("  Stack Pointer: 0x%lx\n", pcb->cpu_context.sp);
    printf("  Registers: [saved during context switch]\n");

    printf("\nMEMORY:\n");
    printf("  Code Segment: %p\n", pcb->memory.code_segment);
    printf("  Data Segment: %p\n", pcb->memory.data_segment);
    printf("  Heap Start: %p\n", pcb->memory.heap_start);
    printf("  Stack Start: %p\n", pcb->memory.stack_start);
    printf("  Memory Size: %zu bytes\n", pcb->memory.memory_size);

    printf("\nSCHEDULING:\n");
    printf("  Priority: %d\n", pcb->priority);
    printf("  CPU Time Used: %d ms\n", pcb->cpu_time_used);
    printf("  Time Slice Remaining: %d ms\n", pcb->time_slice_remaining);

    printf("\nFILES:\n");
    printf("  stdin: %d, stdout: %d, stderr: %d\n",
           pcb->files.stdin_fd, pcb->files.stdout_fd, pcb->files.stderr_fd);

    printf("\nRELATIONSHIPS:\n");
    printf("  Number of Children: %d\n", pcb->num_children);
}

// Simulate creating a PCB for current process
struct PCB* create_current_process_pcb() {
    struct PCB* pcb = malloc(sizeof(struct PCB));

    // Fill in real information about current process
    pcb->process_id = getpid();
    pcb->parent_id = getppid();
    snprintf(pcb->process_name, sizeof(pcb->process_name), "demo_process");

    pcb->state = RUNNING;  // Currently running since we're executing

    // Simulate some values (real OS gets these from hardware)
    pcb->cpu_context.pc = 0x400000;  // Typical code start address
    pcb->cpu_context.sp = 0x7fff0000; // Typical stack address

    pcb->memory.code_segment = (void*)0x400000;
    pcb->memory.data_segment = (void*)0x600000;
    pcb->memory.heap_start = (void*)0x800000;
    pcb->memory.stack_start = (void*)0x7fff0000;
    pcb->memory.memory_size = 1024 * 1024; // 1MB

    pcb->priority = 20;  // Normal priority
    pcb->cpu_time_used = 150;
    pcb->time_slice_remaining = 50;

    pcb->files.stdin_fd = 0;
    pcb->files.stdout_fd = 1;
    pcb->files.stderr_fd = 2;

    pcb->num_children = 0;
    pcb->waiting_for_resource = 0;

    return pcb;
}

// Show how PCB is used during context switching
void demonstrate_context_switch() {
    printf("\n=== HOW PCB IS USED IN CONTEXT SWITCHING ===\n\n");

    printf("When OS switches from Process A to Process B:\n\n");

    printf("1. SAVE Process A's context:\n");
    printf("   - Save CPU registers to PCB_A\n");
    printf("   - Save program counter to PCB_A\n");
    printf("   - Save stack pointer to PCB_A\n");
    printf("   - Update PCB_A state to READY\n");
    printf("   - Add PCB_A to ready queue\n\n");

    printf("2. LOAD Process B's context:\n");
    printf("   - Load CPU registers from PCB_B\n");
    printf("   - Load program counter from PCB_B\n");
    printf("   - Load stack pointer from PCB_B\n");
    printf("   - Update PCB_B state to RUNNING\n");
    printf("   - Continue execution where B left off\n\n");

    printf("The PCB is what makes this possible!\n");
    printf("Without PCB, the OS wouldn't know where to resume each process.\n");
}

// Show process states using PCB
void demonstrate_process_states() {
    printf("\n=== PROCESS STATES IN PCB ===\n\n");

    printf("NEW:        Process created, PCB allocated, not yet loaded\n");
    printf("READY:      Process loaded, waiting for CPU assignment\n");
    printf("RUNNING:    Process currently executing on CPU\n");
    printf("WAITING:    Process blocked, waiting for I/O or resource\n");
    printf("TERMINATED: Process finished, PCB being cleaned up\n\n");

    printf("State transitions:\n");
    printf("NEW → READY:       OS loads process into memory\n");
    printf("READY → RUNNING:   Scheduler assigns CPU\n");
    printf("RUNNING → READY:   Time slice expires\n");
    printf("RUNNING → WAITING: Process requests I/O\n");
    printf("WAITING → READY:   I/O completes\n");
    printf("RUNNING → TERMINATED: Process exits\n");
}

int main() {
    printf("=== PROCESS CONTROL BLOCK (PCB) DEMONSTRATION ===\n\n");

    printf("WHAT IS PCB?\n");
    printf("• PCB = Process Control Block\n");
    printf("• OS data structure that REPRESENTS a process\n");
    printf("• Contains ALL information needed to manage the process\n");
    printf("• One PCB per process in the system\n\n");

    // Create and display a sample PCB
    struct PCB* current_pcb = create_current_process_pcb();
    display_pcb_info(current_pcb);

    demonstrate_context_switch();
    demonstrate_process_states();

    printf("\n=== KEY POINTS ABOUT PCB ===\n");
    printf("✓ PCB REPRESENTS the process to the OS\n");
    printf("✓ Process = running program, PCB = OS's record of it\n");
    printf("✓ OS uses PCB for scheduling, memory management, I/O\n");
    printf("✓ Context switching = saving/loading PCB information\n");
    printf("✓ Each process has exactly one PCB\n");
    printf("✓ PCB exists even when process is not running\n");

    free(current_pcb);
    return 0;
}