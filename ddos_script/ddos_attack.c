#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>

int main(int argc, char **argv){
	if(argc!=4){
		printf("Wrong parameters\n");
		return 1;
	}
	char ip[16];
	int aux;
	strcpy(ip, argv[1]);
	int port = atoi(argv[2]);
	int times = atoi(argv[3]);
	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(port);
	addr.sin_addr.s_addr = inet_addr(ip);
	char msg[] = "MessageToSend\n";
	int i;
	int bufferSize = 1024;
	char *msgRcv;
	for(i=1; i<=times; i++){
		int fd = socket(AF_INET, SOCK_STREAM, 0);
		if(fd<0){
			printf("Error creating socket\n");
			return 1;
		}
		if(connect(fd, (struct sockaddr*)&addr, sizeof(addr))==-1){
			printf("%d: Connection error\n", i);
		}else if(send(fd, msg, sizeof(msg), 0)==-1){
			printf("%d: Error sending message\n", i);
		}else{
			printf("%d: Message receive:\n", i);
			msgRcv = (char*)calloc(sizeof(char), bufferSize+1);
			int read;
			while((read=recv(fd, msgRcv, bufferSize, 0))>0){
				msgRcv[read]=0;
				printf("%s", msgRcv);
			}
			if(read==-1){
				printf("%d: Error receiving message\n", i);
			}else{
				msgRcv[read]=0;
				printf("%s\n", msgRcv);
				printf("%d: Connection closed\n", i);
			}
			free(msgRcv);
		}
	}
	return 0;
}
