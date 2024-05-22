#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#define BUFFER_SIZE 256

int ipc(){
    char buffer[BUFFER_SIZE];
    pid_t pid, child_pid, parent_pid;
    int pipefd[2]; //pipefd[0]:read, pipefd[1]:write
    if(pipe(pipefd) == -1){
      fprintf(stderr, "Pipe Failed\n");
      return 1;
    }

    pid = fork();
    if(pid < 0){
      fprintf(stderr, "Fork Failed\n");
      return 1;
    }
    else if(pid == 0){
      child_pid = getpid();
      printf("child pid: %d\n", child_pid);
      close(pipefd[0]); //write start
      sprintf(buffer, "child pid: %d", child_pid);
      write(pipefd[1], buffer, strlen(buffer)+1);
      close(pipefd[1]); //write end
    }
    else{ //pid > 0
      parent_pid = getpid();
      printf("parent pid: %d\n", parent_pid);
      close(pipefd[1]); //read start
      read(pipefd[0], buffer, BUFFER_SIZE);
      printf("message: \"%s\" \n", buffer);
      close(pipefd[0]); //read end
      wait(NULL);
      printf("child process is terminated\n");
    }
    return 0;
}

