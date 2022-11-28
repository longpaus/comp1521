#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
	struct stat s;
	if (stat("test.c", &s) != 0) {
		perror("test.c");
		exit(1);
	}
	printf("ino =  %10ld # Inode number\n", s.st_ino);
	printf("mode = %10o # File mode \n", s.st_mode);
	printf("nlink =%10ld # Link count \n", (long)s.st_nlink);
	printf("uid =  %10u # Owner uid\n", s.st_uid);
	printf("gid =  %10u # Group gid\n", s.st_gid);
	printf("size = %10ld # File size (bytes)\n", (long)s.st_size);

	printf("mtime =%10ld # Modification time (seconds since 1/1/70)\n",
	       (long)s.st_mtime);
}