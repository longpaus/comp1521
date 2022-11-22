// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 9

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <stdbool.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdatomic.h>
#include "22t2final_q9_helper.h"

size_t watched_so_far;
pthread_t thread_handles[MAX_WATCHED_FILES];
char thread_files[MAX_WATCHED_FILES][PATH_SIZE];
pthread_mutex_t file_size_mutex = PTHREAD_MUTEX_INITIALIZER;


long int file_size(char *filename) {
    if (!filename) {
        fprintf(stderr, "ERROR: Cannot run file_size with filename == NULL!\n");
        fprintf(stderr, "the program will now exit\n");
        exit(1);

    }

	// START file_size_mutex critical section
	{
		pthread_mutex_lock(&file_size_mutex);

		pthread_t thread = pthread_self();
		size_t thread_num = 0;
		while (thread_num < watched_so_far) {
			if (pthread_equal(thread, thread_handles[thread_num])) {
				break;
			}
			thread_num++;
		}

		if (thread_num == MAX_WATCHED_FILES) {
			fprintf(
				stderr,
				"ERROR: Only %d threads may call file_size.\n"
				"HINT: This may be because you called file_size\n"
				"with the same argument from more than one thread.\n"
				"The program will now exit\n",
				MAX_WATCHED_FILES
			);
			exit(1);
		} else if (thread_num == watched_so_far) {
			// This is a new thread.
			thread_handles[thread_num] = thread;
			strncpy(thread_files[thread_num], filename, PATH_SIZE);
			watched_so_far++;
		} else if (thread_num < watched_so_far) {
			// This is an existing thread
			if (strncmp(filename, thread_files[thread_num], PATH_SIZE) != 0) {
				// ... and the file isn't the one we asked about last time.
				fprintf(
					stderr,
					"ERROR: A thread may only call file_size about one file.\n"
					"HINT: this thread already called file_size to get the\n"
					"size of \"%s\", but you called to find the size of \"%s\".\n"
					"The program will now exit\n",
					thread_files[thread_num],
					filename
				);
				exit(1);
			}

			// If it's still asking about the same file, let it through.

		} else {
			fprintf(stderr, "This is impossible.\n");
			exit(1);
		}

		pthread_mutex_unlock(&file_size_mutex);
	}
	// END file_size_mutex critical section

    struct stat statbuf;
    if (stat(filename, &statbuf) == -1) {
        return FILE_NOT_FOUND;
    }

    return statbuf.st_size;
}
