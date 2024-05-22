#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 4
#define NUM_POINTS 1000000

int points_in_circle = 0;
pthread_mutex_t lock;

void *calculate_points(void *thread_id) {
    long tid;
    double x, y, distance;

    tid = (long)thread_id;
    srand(time(NULL) + tid);

    for(int i=0; i < NUM_POINTS / NUM_THREADS; i++){
      x = (double)rand() / RAND_MAX * 2 - 1;
      y = (double)rand() / RAND_MAX * 2 - 1;
      distance = x * x + y * y;

      if (distance <= 1){
        pthread_mutex_lock(&lock);
        points_in_circle++;
        pthread_mutex_unlock(&lock);
      }
    }
    pthread_exit(NULL);
}

int pi() {
    pthread_t threads[NUM_THREADS];
    int rc;
    long t;

    pthread_mutex_init(&lock, NULL);

    for(t=0; t < NUM_THREADS; t++){
      rc = pthread_create(&threads[t], NULL, calculate_points, (void *)t);
      if(rc) {
        printf("ERROR, return code from pthread_create() is %d\n", rc);
        exit(-1);
      }
    }
    for(t=0; t < NUM_THREADS; t++){
      pthread_join(threads[t], NULL);
    }

    pthread_mutex_destroy(&lock);

    double pi_estimate = 4.0 * points_in_circle / NUM_POINTS;
    printf("Estimated value of pi: %f\n", pi_estimate);
    return 0;
}
