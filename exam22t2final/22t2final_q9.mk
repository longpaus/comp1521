EXERCISES	+= 22t2final_q9
CLEAN_FILES	+= 22t2final_q9

22t2final_q9:	22t2final_q9_helper.c 22t2final_q9.c
	$(CC) -pthread $^ -o $@
