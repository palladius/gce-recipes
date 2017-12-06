

call-them-all: gcs-monitor gcs-wordcount hello
	@yellow "Calling all GCF tests I have here.."

gcs-monitor:
	cd gcs-monitor && make call-wordcount

gcs-wordcount:
	cd gcs-wordcount && make call-wordcount

hello:
	cd helloworld && make trigger