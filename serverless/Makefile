

call-them-all: gcs-monitor http-wordcount http-hello
	@yellow "Calling all GCF tests I have here.."

gcs-monitor:
	cd gcs-monitor && make call-wordcount

http-wordcount:
	cd http-wordcount && make call-wordcount

http-hello:
	cd helloworld && make curl && make trigger