

call-them-all: gcs-monitor gcs-wordcount http-hello
	@yellow "Calling all GCF tests I have here.."

gcs-monitor:
	cd gcs-monitor && make call-wordcount

gcs-wordcount:
	cd gcs-wordcount && make call-wordcount

http-hello:
	cd helloworld && make curl && make trigger