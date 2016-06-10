#include <stdio.h>
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
		}
	}
	return 0;
}
