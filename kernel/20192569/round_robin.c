#include <stdio.h>

#define MAX_PROCESSES 10

typedef struct {
    int pid;
    int arrival_time;
    int burst_time;
    int remaining_time;
} Process;

    Process processes[MAX_PROCESSES];
    int num_processes;

int round_robin() {
    int current_time = 0;
    int count = 0;
    int time_slice;
    int execution_time;

    printf("Input the number of processes: ");
    scanf("%d", &num_processes);
    printf("\n");

    for (int i = 0; i < num_processes; i++) {
        processes[i].pid = i + 1;
        printf("Enter arrival time for process %d: ", i + 1);
        scanf("%d", &processes[i].arrival_time);
        printf("Enter burst time for process %d: ", i + 1);
        scanf("%d", &processes[i].burst_time);
        processes[i].remaining_time = processes[i].burst_time;
    }

    printf("Enter the time slice: ");
    scanf("%d", &time_slice);
    printf("\n");

    while (count < num_processes) {
        int all_idle = 1;
        for (int i = 0; i < num_processes; i++) {
            if (processes[i].remaining_time > 0 && processes[i].arrival_time <= current_time) {
               all_idle = 0;
               if (processes[i].remaining_time > time_slice)
                    execution_time = time_slice;
                else
                    execution_time = processes[i].remaining_time;

                processes[i].remaining_time = processes[i].remaining_time - execution_time;
                current_time = current_time + execution_time;

                printf("Process %d executed for %d, Remaining time is %d\n", processes[i].pid, execution_time, processes[i].remaining_time);

                if (processes[i].remaining_time == 0) {
                    count++;
                    printf("Process %d completed at time %d\n\n", processes[i].pid, current_time);
                }
            }
        }
        if (all_idle) {
           current_time++;
        }
    }
    return 0;
}
